From: "Azhar Mr." <shaik.azharuddin@yahoo.co.in>
Subject: KEYBOARD BASED GPIO PROGRAM
Date: Tue, 4 Dec 2007 12:33:22 +0000 (GMT)
Message-ID: <21639.6769.qm@web7602.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,

   

  I AM WORKING ON OMAP5912 OSK.

 

I am writing a keyboard based gpio program to write a value '1' to the free gpio pin when a key was pressed.

 

For that I modified the gpio-switch.c program. I am using the up arrow

key which is mapped to gpio7. 

 

By pressing this key I am unable to write 

a value '1' to the gpio pin 7.

 

At the shell prompt I am able to see a logic '0' value at gpio pin 7 with the following message

 

Value of pin # 7 = 0

up (GPIO 7) is now disconnected

 

I am supposed to get the Value of pin # 7 = 1

 Here is my gpio-switch code

 #define OMAP_GPIO_SW_POLL_DELAY    10

 #define LED_GPIO 7

 const struct omap_gpio_switch_config omap_left_switch = {

    .name = "left",

    .type = OMAP_GPIO_SWITCH_TYPE_CONNECTION,

    .gpio = 6,

    .flags = OMAP_GPIO_SWITCH_FLAG_INVERTED,

    .key_code = KEY_LEFT

};

 

const struct omap_gpio_switch_config omap_enter_switch = {

    .name = "enter",

    .type = OMAP_GPIO_SWITCH_TYPE_CONNECTION,

    .gpio = 12,

    .flags = OMAP_GPIO_SWITCH_FLAG_INVERTED,

    .key_code = KEY_ENTER

};

 

const struct omap_gpio_switch_config omap_up_switch = {

    .name = "up",

    .type = OMAP_GPIO_SWITCH_TYPE_CONNECTION,

    .gpio = 7,

    .flags = OMAP_GPIO_SWITCH_FLAG_INVERTED,

    .key_code = KEY_UP

};

 

const struct omap_gpio_switch_config omap_down_switch = {

    .name = "down",

    .type = OMAP_GPIO_SWITCH_TYPE_CONNECTION,

    .gpio = 15,

    .flags = OMAP_GPIO_SWITCH_FLAG_INVERTED,

    .key_code = KEY_DOWN

};

 

const struct omap_gpio_switch_config *omap_switches[] = {

    &omap_left_switch,

    &omap_enter_switch,

    &omap_up_switch,

    &omap_down_switch,

    NULL              /* Guard */    

};

 

static void gpio_sw_handler(void *data)

{

    struct gpio_switch *sw = data;

    int state = gpio_sw_get_state(sw);

 

    if (sw->state == state)

          return;

 

    if (sw->type == OMAP_GPIO_SWITCH_TYPE_CONNECTION)

          kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE,

                    &dev_attr_connection_switch.attr);

    else

          kobject_uevent(&sw->pdev.dev.kobj, KOBJ_CHANGE,

                    &dev_attr_cover_switch.attr);

    sw->state = state;

    input_report_key(&omap_sw_kp_dev, sw->key_code, state);

    

    /*** [START]: code for writing some value to GPIO 17 ***/

 

    if(sw->key_code==KEY_UP)

    {

          if(led_glow(sw))

              printk(KERN_ERR "led_glow:failed ");

    }    

    

    /*** [END]: code for writing some value to GPIO 17 ***/          

 

static int led_glow(struct gpio_switch *ctrlsw)

{

    /* requesting for LED_GPIO */

    if(omap_request_gpio(LED_GPIO)<0)

          return -1;

    

    /* setting LED_GPIO as output pin */

    omap_set_gpio_direction(LED_GPIO,0);

 

    /* writing to LED_GPIO the state of KEY_UP */

    omap_set_gpio_dataout(LED_GPIO,ctrlsw->state);

 

    /* printing the value of led_gpio pin */

    printk("value of pin # %d = %d\n",LED_GPIO,omap_get_gpio_datain(LED_GPIO));

 

    return 0;

    

 

}

 

But if I alone run the following code with out using the switch dependency, I am able to set the GPIO pin to 1 and I can observe the change from logic 0 to Logic 1 in the C.R.O

 /* define any of the valid GPIO pins as LED_GPIO */
  #define LED_GPIO 7
   
   
  /* Defines the value written to the pin defined as LED_GPIO */
  #define LED_STATUS 1
   
  MODULE_LICENSE("Dual BSD/GPL");
   
   
   
  int init_module(void)
  {
        /* requesting for LED_GPIO */
        if(omap_request_gpio(LED_GPIO)<0)
        {
        printk("[ERROR]: Failed in allocating the requested GPIO Pin \n");
              return -1;
        }
        
        /* setting LED_GPIO as output pin */
        omap_set_gpio_direction(LED_GPIO,0);
   
        /* writing to LED_GPIO the value of LED_STATUS */
        omap_set_gpio_dataout(LED_GPIO,1);
   
        /* printing the value of LED_GPIO pin */
  printk("value of pin # %d = %d\n",LED_GPIO,omap_get_gpio_datain(LED_GPIO));
   
        return 0;
  }
   
  Void cleanup_module (void)
  {
        omap_free_gpio(LED_GPIO);     
        printk("[SUCCESS]: LED_GLOW Module unregistered successfull.\n");
  }

Please suggest where I had gone wrong.

 With Regards

  Azharuddin
   

       
---------------------------------
 Bring your gang together - do your thing.  Start your group.
