From: pramod gurav <pramodforum-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I2C1 controller timed out with twl4030-powerbutton
Date: Sat, 23 May 2009 19:02:13 +0530
Message-ID: <f502236f0905230632m4e259e9xcc597e6d89ece43f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,
I am working on omap3430 custom board with linux-omap-2.6
(2.6.28-omap1 tag) on it.
I am using twl4030 power buttom. Whenever I press the power key I get
i2c controller timed out.
I am seeing following logs and the keypad stops responding and I have
to remove the board supply completely.

i2c_omap i2c_omap.1: controller timed out
i2c_omap i2c_omap.1: controller timed out
twl4030: I2C error -110 reading PIH ISR
i2c_omap i2c_omap.1: controller timed out
twl4030: I2C error -110 reading PIH ISR
i2c_omap i2c_omap.1: controller timed out
twl4030: I2C error -110 reading PIH ISR
i2c_omap i2c_omap.1: controller timed out

When I enabled the logs I could see
twl4030: i2c error -110 while reading TWL4030 PM_MASTER
STS_HW_CONDITIONS register

The behavior is seen mostly with power-button key. Is there any fix
that has gone into the kernel for
this(after 2.6.28-omap1)?

-- 
Best Regards
Pramod
