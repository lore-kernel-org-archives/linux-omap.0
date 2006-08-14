From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Add GPIO API howto
Date: Mon, 14 Aug 2006 09:12:01 +0200
Message-ID: <44E02241.1020103@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040708010100080002030007"
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708010100080002030007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Add GPIO API howto.

Signed-off-by: Arnold <abo_gwapo_at_yahoo.com>
Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------040708010100080002030007
Content-Type: text/plain;
 name="gpio_api_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gpio_api_patch.txt"

--- ./Documentation/arm/OMAP/gpio_orig	2006-08-14 08:29:22.000000000 +0200
+++ ./Documentation/arm/OMAP/gpio	2006-08-14 09:08:28.000000000 +0200
@@ -0,0 +1,135 @@
+
+                         OMAP GPIO API's HowTo
+                         =====================
+
+This document is a short summary how to use OMAP Linux GPIO API. It is
+mainly focussed on OMAP5912 OSK, but should fit with extensions (more 
+or less GPIOs) to other OMAP processors as well.
+
+If anything is missing, is wrong, needs extension or update, please send
+update to Linux-omap-open-source@linux.omap.com.
+
+I. GPIO Modules/Banks
+---------------------
+
+OMAP5912 OSK has 64 GPIOs (general purpose IO pins). These are organized
+in four modules (banks) with 16 pins each. OMAP GPIO API doesn't distinguish
+between modules and numbers the pins from 0 - 63:
+        
+A) GPIO MODULE/BANK 0 - PIN  0-15
+B) GPIO MODULE/BANK 1 - PIN 16-31
+C) GPIO MODULE/BANK 2 - PIN 32-47
+D) GPIO MODULE/BANK 3 - PIN 48-63
+
+See
+
+http://www-s.ti.com/sc/psheets/spru767a/spru767a.pdf
+
+for more details.
+
+II. GPIO API's
+--------------
+
+A) Include
+
+#include <asm/arch/gpio.h>
+
+B) omap_cfg_reg(xxxx);
+
+Description: Configure pin mux.
+
+Parameter: Pin to be configured for GPIO.
+
+Note: This function may only be necessary for some GPIO pins. Because OMAP
+      chip itself has less real hardware pins than necessary to use all
+      its functionality at the same time, some pins share different
+      functions (called pin multiplexing, short pin mux). E.g. one pin may 
+      be used for serial interface *or* GPIO. Check if this is the case for 
+      the GPIO you want to use and if you have to configure the pin mux.
+
+C) omap_request_gpio(int gpio)
+     
+Description: Request GPIO to be used.
+
+Parameter: int gpio - GPIO PIN (Pin 0-63)
+
+Note: Using this function, you dont have to worry about banks/modules where 
+      the gpio pin is.
+
+D) omap_set_gpio_direction(int gpio, int is_input)
+    
+Description: This function is responsible for setting the gpio pin direction
+             (input or output).
+
+Parameter: int gpio - GPIO PIN (Pin 0-63)
+           int is_input - pin direction (0 = output, 1 = input)
+
+E) omap_set_gpio_dataout(int gpio, int enable)
+
+Description: This function is responsible for writing to a pin.
+
+Parameter: int gpio - GPIO PIN (Pin 0-63)
+           int enable - pin value (0 or 1)
+
+F) omap_get_gpio_datain(int gpio)
+    
+Description: This function is responsible for reading pin values.
+
+Parameter: int gpio - GPIO PIN (Pin 0-63)
+
+G) omap_free_gpio(int gpio)
+
+Description: This function is responsible for freeing the pin used.
+
+Parameter: int gpio - GPIO PIN (Pin 0-63)
+
+H) OMAP_GPIO_IRQ(int gpio)
+    
+Description: Returns the Interrupt number for the specified gpio pin.
+
+Parameter: int gpio - GPIO PIN (Pin 0-63)
+
+I) set_irq_type(unsigned int irq, unsigned int type)
+
+Description: This function is responsible for setting the type of interrupt
+             (RISING or FALLING).
+
+Parameter: unsigned int irq - The interrupt number for the gpio pin.
+           unsigned int type - (IRQT_RISING = rising, IRQT_FALLING= falling)
+
+
+III. Example
+------------
+
+1) Writing to gpio pin#3 a value 1 and reading the value of gpio pin#3.
+
+#include <asm/arch/gpio.h>
+
+int ret;                       /* Return value */
+
+omap_request_gpio(3);          /* Request for gpio pin */ 
+omap_set_gpio_direction(3,0);     
+omap_set_set_dataout(3,1);     /* Writing a 1 to gpio pin # 3: */ 
+ret = omap_get_datain(3);      /* Reading the value of pin # 3 */
+printk("value of pin # 3 = %d\n",ret);
+omap_free_gpio(3);             /* Freeing gpio pin # 3 */                
+
+2) Interrupt input by gpio pin#3
+
+#include <asm/arch/gpio.h>
+
+omap_request_gpio(3);         /* Request for gpio pin */
+omap_set_gpio_direction(3,0);
+set_irq_type(OMAP_GPIO_IRQ(3),IRQT_RISING); /* Setting up pin for interrupt */
+request_irq(OMAP_GPIO_IRQ(3), (void *)&my_int_handler, SA_SHIRQ,....);
+
+...                         /* Do stuff, handle interrupts in my_int_handler */
+                
+free_irq(OMAP_GPIO_IRQ(3),&id); /*  Freeing interrupt and gpio pin */
+omap_free_gpio(3); 
+
+------------------------------------------------------------------
+Last modified 14. August 2006
+The OMAP Linux Kernel Team
+Arnold <abo_gwapo@yahoo.com>
+Dirk Behme <dirk.behme@gmail.com>


--------------040708010100080002030007
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040708010100080002030007--
