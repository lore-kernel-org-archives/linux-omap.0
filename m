From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: Peculiar Behaviour of the GPIO Program
Date: Tue, 27 Nov 2007 02:05:08 +0200
Message-ID: <1196121909.6829.0.camel@mort>
References: <74079.72407.qm@web7604.mail.in.yahoo.com>
	<E6CCDC65B8C522458685D8D1F145FEA801A34BA7@CA2-MSX-C01.nw.net>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <E6CCDC65B8C522458685D8D1F145FEA801A34BA7@CA2-MSX-C01.nw.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Krishna Prasad Herur <kherur@nextwave.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


On Mon, 2007-11-26 at 15:55 -0800, ext Krishna Prasad Herur wrote:
> The GPIO driver does not automatically do the required pin muxing for
> you. It is possible that the pin you are looking at is muxed with other
> signals. Look at the OMAP TRM, and set the Pin Mux register correctly.
> -Prasad

Pullup/pulldown settings might require some adjustment too.


> -----Original Message-----
> From: linux-omap-open-source-bounces+kherur=nextwave.com@linux.omap.com
> [mailto:linux-omap-open-source-bounces+kherur=nextwave.com@linux.omap.co
> m] On Behalf Of Azhar Mr.
> Sent: Thursday, November 22, 2007 10:35 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Peculiar Behaviour of the GPIO Program
> 
> Dear all,
>    
>   I am working on OMAP5912 OSK.
>    
>   I am trying to write a simple GPIO Program to write a value '1' to a
> particular free GPIO Pin. For that I had written a program led_glow.c
> given below.
>    
>   /* define any of the valid GPIO pins as LED_GPIO */
>   #define LED_GPIO 18
>    
>    
>   /* Defines the value written to the pin defined as LED_GPIO */
>    
>   #define LED_STATUS 1
>    
>   MODULE_LICENSE("Dual BSD/GPL");
>    
>    
>   int init_module(void)
>   {
>         /* requesting for LED_GPIO */
>         if(omap_request_gpio(LED_GPIO)<0)
>         {
>    printk("[ERROR]: Failed in allocating the requested GPIO Pin \n");
>               return -1;
>         }
>         
>         /* setting LED_GPIO as output pin */
>    
>        omap_set_gpio_direction(LED_GPIO,0);
>    
>         /* writing to LED_GPIO the value of LED_STATUS */
>    
>         omap_set_gpio_dataout(LED_GPIO,LED_STATUS);
>    
>         /* printing the value of LED_GPIO pin */
>    
>   printk("value of pin # %d =
> %d\n",LED_GPIO,omap_get_gpio_datain(LED_GPIO));
>    
>         return 0;
>   }
>    
>   void cleanup_module(void)
>   {
>         omap_free_gpio(LED_GPIO);     
>   printk("[SUCCESS]: LED_GLOW Module unregistered successfull.\n");
>   }
>    
>    
>   I included our led_glow.c as a module in the Linux-2.6.22/drivers/leds
> directory .
>    
>   Then using arm-linux-gcc compiler, I compiled the led_glow.c code to
> obtain led_glow.ko
>    
>   Then using the insmod I inserted the module led_glow.ko in the
>   OSK5912 Environment.
>    
>   I tested the module with various free GPIO-Pins of Expansion connector
> 'C'
>    
>   For some GPIO pins it is able to write the value '1' and for some pins
> it is unable to write '1'
>    
>   Sh-3.00# value of pin #15 = 1
>   Sh-3.00# value of pin #16 = 1
>   Sh-3.00# value of pin #17= 0
>   Sh-3.00# value of pin #20 = 0
>    
>   I tested all the free GPIO pins of EXPANSION CONEECTOR C, irrespective
> of the printed value at the GPIO Pins at all the GPIO Pins I can observe
> only '0' value in the C.R.O. I could not get any response in the C.R.O
>    
>   I don't understand this peculiar behavior of my GPIO-CODE.
>    
>   Please Help
>    
>   With Regards
>    
>   Azhar
> 
>        
> ---------------------------------
>  Bring your gang together - do your thing.  Start your group.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
