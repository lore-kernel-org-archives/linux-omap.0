From: Ram <vshrirama@gmail.com>
Subject: I2C TWL4030 Keypad
Date: Fri, 16 Feb 2007 16:55:01 +0530
Message-ID: <8bf247760702160325m6624817bpbced2b76db9ae30a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
   Im using omap2430 SDP.
   Im trying to get TWL4030 Keypad to work on 2.6.19. Im using 2.6.14 for
omap2430 as a reference.

   Im using the following files:
        1) i2c-omap.c which exists on 2.6.19
        2) twl4030_core.c
        3) twl4030_gpio.c (taken from 2.6.14)
        4) omap-twl4030keypad.c (taken from 2.6.14)

   made  changes  to support generic interrupts in 2.6.19.

   Im able to read the value of registers using  twl4030_kpread_u8
    TWL4030_MODULE_KEYPAD, REG_KEYP_EDR, REG_LK_PTV_REG, REG_KEY_DEB_REG,
REG_LONG_KEY_REG1, REG_KEYP_SIH_CTRL, REG_KEYP_IMR1

  However, im not able to recieve interrupts. upon pressing keys in keypad.
i dont observe
  any change in interrupts count. when i do a cat /proc/interrupts.

Im not sure if im missing something.


  I also observe randomly (say 3 out of 10 times), my i2c bus times out and
im unable to read or write TWL4030 registers. i get an return value of
-110.

i2c_omap i2c_omap.2: timeout waiting for bus ready

Please Advice,

Regards,
sriram
