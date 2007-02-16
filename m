From: Ram <vshrirama@gmail.com>
Subject: I2C TWL4030 Keypad
Date: Fri, 16 Feb 2007 20:38:40 +0530
Message-ID: <8bf247760702160708m41f1d277o7c9200bc3d81bd0b@mail.gmail.com>
References: <8bf247760702160325m6624817bpbced2b76db9ae30a@mail.gmail.com>
	<45F366B1BC4F7C4A895F0F34C41E61A502EFB337@dbde01.ent.ti.com>
	<8bf247760702160650s62d2b401lad8746881aedd2aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8bf247760702160650s62d2b401lad8746881aedd2aa@mail.gmail.com>
Content-Disposition: inline
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

>> check if ARM interrupt for triton is unmasked or not.

 Im not sure, where this information is provided?. Could you let me
 know where do i check for this?.

 All are enabled:
 1. I2C driver
 2. TWL4030 Driver
 3. TWL4030 keypad driver

 Im able to read TWL Registers. Although randomly, i do get i2c
bustimeout error.

 Mux settings seem to be okay.


 regards,
 sriram




On 2/16/07, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> Make sure the following modules are enabled in the menuconfig:
>
> 1. I2C driver
> 2. TWL4030 Driver
> 3. TWL4030 keypad driver
>
> Also make sure, triton and its client driver interrupts are mapped in
> irqs.h file. If interrupt numbers are mapped properly, check if ARM
> interrupt for triton is unmasked or not.
>
> Last thing, check pin muxing for the sys_irq line and configure in
> proper mode for triton interrupt to work.
>
> Regards,
> Manjunath
>
> -----Original Message-----
> From: linux-omap-open-source-bounces+manjugk=ti.com@linux.omap.com
> [mailto:linux-omap-open-source-bounces+manjugk=ti.com@linux.omap.com ] On
> Behalf Of Ram
> Sent: Friday, February 16, 2007 4:55 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: I2C TWL4030 Keypad
>
> Hi,
>    Im using omap2430 SDP.
>    Im trying to get TWL4030 Keypad to work on 2.6.19. Im using 2.6.14
> for
> omap2430 as a reference.
>
>    Im using the following files:
>         1) i2c-omap.c which exists on 2.6.19
>         2) twl4030_core.c
>         3) twl4030_gpio.c (taken from 2.6.14)
>         4) omap-twl4030keypad.c (taken from 2.6.14)
>
>    made  changes  to support generic interrupts in 2.6.19.
>
>    Im able to read the value of registers using  twl4030_kpread_u8
>     TWL4030_MODULE_KEYPAD, REG_KEYP_EDR, REG_LK_PTV_REG,
> REG_KEY_DEB_REG,
> REG_LONG_KEY_REG1, REG_KEYP_SIH_CTRL, REG_KEYP_IMR1
>
>   However, im not able to recieve interrupts. upon pressing keys in
> keypad.
> i dont observe
>   any change in interrupts count. when i do a cat /proc/interrupts.
>
> Im not sure if im missing something.
>
>
>   I also observe randomly (say 3 out of 10 times), my i2c bus times out
> and
> im unable to read or write TWL4030 registers. i get an return value of
> -110.
>
> i2c_omap i2c_omap.2: timeout waiting for bus ready
>
> Please Advice,
>
> Regards,
> sriram
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
