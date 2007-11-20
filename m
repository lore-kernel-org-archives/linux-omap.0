From: "Azhar Mr." <shaik.azharuddin@yahoo.co.in>
Subject: OSK5912 GPIO
Date: Tue, 20 Nov 2007 13:20:34 +0000 (GMT)
Message-ID: <589867.89402.qm@web7606.mail.in.yahoo.com>
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

Dear all,

I AM WORKING ON OMAP5912 OSK

I am trying to write a simple GPIO program to change
the state of  a gpio pin.

For that I am using the gpio-switch.c located at
linux/arch/arm/plat-omap.

In the gpio-switch.c program I included the follwing
function

#define LED_GPIO 23

static int led_glow()
{
	/* requesting for LED_GPIO */
	
      if(omap_request_gpio(LED_GPIO)<0)
		return -1;
	
	/* setting LED_GPIO as output pin */
	omap_set_gpio_direction(LED_GPIO,0);

	/* writing to LED_GPIO the state of KEY_UP */

	omap_set_gpio_dataout(LED_GPIO,1);

	/* printing the value of led_gpio pin */
	
  printk("value of pin # %d =
%d\n",LED_GPIO,omap_get_gpio_datain(LED_GPIO));

	return 0;
	

}
 
I am calling the function "led_glow()" again in the
following function

static int __init gpio_sw_init(void)
{
	int r;

	printk(KERN_INFO "OMAP GPIO switch handler
initializing\n");

	r = driver_register(&gpio_sw_driver);
	if (r)
		return r;

	gpio_sw_platform_dev =
platform_device_register_simple("gpio-switch",
							       -1, NULL, 0);
	if (IS_ERR(gpio_sw_platform_dev)) {
		driver_unregister(&gpio_sw_driver);
		return PTR_ERR(gpio_sw_platform_dev);
	}

	r = add_atag_switches();
	if (r < 0) {
		platform_device_unregister(gpio_sw_platform_dev);
		driver_unregister(&gpio_sw_driver);
		gpio_sw_cleanup();
		return r;
	}

	report_initial_state();

	return 0;
        led_glow();
        
}
  
I complied and ported this to OSK5912

But I am getting neither the print statement nor the
response at the gpio pin 23 in the C.R.O. 

Even I changed the various gpio pins and tried I could
not see any response in the C.R.O

Please help me by an example code.


Regards

Azhar


      Bring your gang together - do your thing. Go to http://in.promos.yahoo.com/groups
