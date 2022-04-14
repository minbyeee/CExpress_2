 using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayerBall : MonoBehaviour
{
    AudioSource audio;
    public int ItemCount;
    public float jumpPower;
    Rigidbody rigid;
    bool isJump;
    public GameManagerLogic manager;
    public AudioSource mysfx;
    public AudioClip jumpsfx;

    public void Awake()
    {
        rigid = GetComponent<Rigidbody>();
        isJump = false;
        audio = GetComponent<AudioSource>();
        
    }

    public void Update()
    {
        if (Input.GetButtonDown("Jump") && !isJump)
        {
            isJump = true;
            rigid.AddForce(new Vector3(0, jumpPower, 0), ForceMode.Impulse);
        }
    }
    public void FixedUpdate()
    {
        float h = Input.GetAxisRaw("Horizontal");
        float v = Input.GetAxisRaw("Vertical");

        rigid.AddForce(new Vector3(h, 0, v), ForceMode.Impulse);

    }
    public void JumpSound()
    {
        mysfx.PlayOneShot(jumpsfx);
    }
    public void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Floor")
            isJump = false;
           JumpSound();
    }
   
   public void OnTriggerEnter(Collider other)
    {
       

        if (other.tag == "Item")
        {
         
            ItemCount++;
            audio.Play();
            other.gameObject.SetActive(false);
            manager.GetItem(ItemCount);
        }

     
                else if (other.tag == "Point")
                {

            if (ItemCount == manager.TotalitemCount)
            {
                SceneManager.LoadScene("Example1_" + (manager.Stage + 1).ToString());
            }
            else
            {
                SceneManager.LoadScene("Example1_" + (manager.Stage).ToString());
            }
            
            
                }   
    }
}
