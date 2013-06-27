From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: AM35xx i2c3 issues
Date: Thu, 27 Jun 2013 08:29:05 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE08D2E7A08@MARCM-SBS2011.marcmltd.local>
References: <F690310232FDDF4AB457E8B3EF90DDE08D2E797B@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm5-vm6.bt.bullet.mail.ir2.yahoo.com ([212.82.99.220]:29625
	"EHLO nm5-vm6.bt.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752753Ab3F0If1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 04:35:27 -0400
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE08D2E797B@MARCM-SBS2011.marcmltd.local>
Content-Language: en-GB
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Grygorii/All,

I have been trying to address an issue I am having with 3.6rc6 kernel a=
nd even with the latest 3.9 and trying to use i2c3 channel on an AM3517=
=2E

I see that there has been some work done on the OMAP4 and issues with i=
2c which looks like the controller being suspended during boot.

I would like to know how I can enable the debug so I can see the messag=
es for warning and debug and whether anyone has tested i2c3 channel on =
an AM3517 ?

I find the problem a little confusing as the system initializes the int=
erfaces 1-3

[    0.168182] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 400 kHz
[    0.169830] VDCDC1: 1200 <--> 1600 mV at 1200 mV normal
[    0.169830] VDCDC1: Voltage range but no REGULATOR_CHANGE_VOLTAGE
[    0.170684] VDCDC2: 3300 mV normal
[    0.171264] VDCDC3: 1800 mV normal
[    0.171905] LDO1: 1800 mV normal
[    0.172729] LDO2: 3300 mV normal
[    0.174102] omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 400 kHz
[    0.187530] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz

But when it comes to probe the i2c3 interface for the mpu6050 that is c=
onnected it fails

[    3.896606] omap_i2c omap_i2c.3: timeout waiting for bus ready
[    3.902832] inv-mpu6050: probe of 3-0068 failed with error -110

If I move the mpu6050 onto the i2c2 channel it=92s OK so its not an iss=
ue with the core omap_i2c.

I also have a scope connected to the scl line and see no activity.  I h=
ave proved to myself that the pin is connected and working by configuri=
ng as a GPIO output and toggling 0/1/0 and I can see the output changin=
g on the scope.

The mux is configured correctly from what I can see using debugfs
#  cat /sys/kernel/debug/omap_mux/i2c3_scl
name: i2c3_scl.i2c3_scl (0x480021c2/0x192 =3D 0x0100), b af14, t NA
mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
signals: i2c3_scl | NA | NA | NA | gpio_184 | NA | NA | safe_mode

#  cat /sys/kernel/debug/omap_mux/i2c3_sda
name: i2c3_sda.i2c3_sda (0x480021c4/0x194 =3D 0x0100), b ag14, t NA
mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
signals: i2c3_sda | NA | NA | NA | gpio_185 | NA | NA | safe_mode


If I probe with i2cdetect for all 3 buses there is only an issue with i=
2c3
# i2cdetect -r 1
WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
I will probe file /dev/i2c-1 using read byte commands.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

# i2cdetect -r 2
WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
I will probe file /dev/i2c-2 using read byte commands.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

# i2cdetect -r 3
WARNING! This program can confuse your I2C bus, cause data loss and wor=
se!
I will probe file /dev/i2c-3 using read byte commands.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          [  837.943481] omap_i2c omap_i2c.3: timeout waiting for bu=
s ready
-- [  838.958984] omap_i2c omap_i2c.3: timeout waiting for bus ready
-- [  839.974731] omap_i2c omap_i2c.3: timeout waiting for bus ready


Any pointers/help appreciated as I have the accelerometer and RTC chip =
connected on i2c3 but cannot get anything working.

Kind Regards

Marc
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
