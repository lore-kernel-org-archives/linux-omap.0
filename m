From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Regarding the GPIO  PROGRAMMING of OSK5912
Date: Mon, 23 Jul 2007 17:30:00 +0200
Message-ID: <46A4C978.8010209@googlemail.com>
References: <20070723083004.10528.qmail@f5mail11.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070723083004.10528.qmail@f5mail11.rediffmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balaji narayanam <narayanamb@rediffmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

balaji narayanam wrote:
> Dear Mr.Dirk,
> 
> I am trying to configure the GPIO PINS of OSK5912.
> 
> I had also gone through the "GPIO API's How To." explained by you in
> http://tree.celinuxforum.org/CelfPubWiki/OSK#head-0bda81ff448870f0aa282eb95524f2c157ca3e83
> 
> Based on this I had written the following c-program to activate the gpio 
> pin3
> 
> #include<include/asm/arch/gpio.h>
> main()
> {
> int ret;                      /* Return value */
> 
> omap_request_gpio(3);          /* Request for gpio pin */
> omap_set_gpio_direction(3,0);
> omap_set_set_dataout(3,1);    /* Writing a 1 to gpio pin # 3: */
> ret = omap_get_datain(3);      /* Reading the value of pin # 3 */
> printk("value of pin # 3 = %d\n",ret);
> omap_free_gpio(3);            /* Freeing gpio pin # 3 */
> 
> }
> 
> But it is giving error
> "gpioprog.c:1:27: asm/arch/gpio.h: No such file or directory"
> 
> Then I included the complete path of gpio.h as follow
> #include<linux2.6.22/include/asm/arch/gpio.h>
> Then it requested for the irqs.h
> After giving the path for irqs.h file it is giving the following error
> 
> /tmp/cc7Vui9c.o(.text+0x14): In function `main':
> : undefined reference to `omap_request_gpio'
> /tmp/cc7Vui9c.o(.text+0x20): In function `main':
> : undefined reference to `omap_set_gpio_direction'
> /tmp/cc7Vui9c.o(.text+0x2c): In function `main':
> : undefined reference to `omap_set_set_dataout'
> /tmp/cc7Vui9c.o(.text+0x34): In function `main':
> : undefined reference to `omap_get_datain'
> /tmp/cc7Vui9c.o(.text+0x48): In function `main':
> : undefined reference to `printk'
> /tmp/cc7Vui9c.o(.text+0x50): In function `main':
> : undefined reference to `omap_free_gpio'
> collect2: ld returned 1 exit status
> [root@localhost arch]# arm-linux-gcc gpioprog.c
> /tmp/ccqF1BLf.o(.text+0x14): In function `main':
> : undefined reference to `omap_request_gpio'
> /tmp/ccqF1BLf.o(.text+0x20): In function `main':
> : undefined reference to `omap_set_gpio_direction'
> /tmp/ccqF1BLf.o(.text+0x2c): In function `main':
> : undefined reference to `omap_set_set_dataout'
> /tmp/ccqF1BLf.o(.text+0x34): In function `main':
> : undefined reference to `omap_get_datain'
> /tmp/ccqF1BLf.o(.text+0x48): In function `main':
> : undefined reference to `printk'
> /tmp/ccqF1BLf.o(.text+0x50): In function `main':
> : undefined reference to `omap_free_gpio'
> collect2: ld returned 1 exit status
> 
> 
> Please help

If I understand you correctly, you want to access gpio interface from 
Linux user space with a user space program using main()? Then, there 
is a misunderstanding: GPIO API described in

OMAP GPIO API's HowTo

is about how to access kernels gpio driver by other Linux kernel 
drivers. This GPIO API can't be used by Linux user space programs. If 
you write e.g. an I2C kernel driver and have to access some OMAP GPIO 
pins for this, you have to use the GPIO API as described throughout 
this how to. But you can't use it from user space.

Hth,

Dirk

Btw.: Better ask publically on omap mailing list instead of private 
mails. Subscription system is hopefully back soon.
