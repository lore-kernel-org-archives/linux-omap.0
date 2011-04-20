From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Wed, 20 Apr 2011 13:42:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104201340450.5985@utopia.booyaka.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com> <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com> <alpine.DEB.2.00.1103100734490.15132@utopia.booyaka.com>
 <4D7A22F6.5050806@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50775 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab1DTTmq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Apr 2011 15:42:46 -0400
In-Reply-To: <4D7A22F6.5050806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, santosh.shilimkar@ti.com
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org


Hi Rajendra, Santosh,

just FYI I just observed this happening without the clockdomain patch, and  
tracked this down.  It seems that there is an intermittent 
problem with the OMAP L3 bus code.  On the 35xx BeagleBoard here, it 
occasionally hangs after powerup:

[    0.810119] OMAP GPIO hardware version 2.5
[    0.815368] OMAP GPIO hardware version 2.5
[    0.820465] OMAP GPIO hardware version 2.5
[    0.825531] OMAP GPIO hardware version 2.5
[    0.830657] OMAP GPIO hardware version 2.5
[    0.835784] OMAP GPIO hardware version 2.5
[    0.840881] initcall omap_gpio_drv_reg+0x0/0xc returned 0 after 38146 
usecs
[    0.848358] calling  bdi_class_init+0x0/0x50 @ 1
[    0.854003] initcall bdi_class_init+0x0/0x50 returned 0 after 0 usecs
[    0.860870] calling  kobject_uevent_init+0x0/0x20 @ 1
[    0.866363] initcall kobject_uevent_init+0x0/0x20 returned 0 after 0 
usecs
[    0.873626] calling  gpiolib_sysfs_init+0x0/0x98 @ 1
[    0.885894] initcall gpiolib_sysfs_init+0x0/0x98 returned 0 after 0 
usecs
[    0.893157] calling  lcd_class_init+0x0/0x58 @ 1
[    0.898742] initcall lcd_class_init+0x0/0x58 returned 0 after 0 usecs
[    0.905731] calling  backlight_class_init+0x0/0x70 @ 1
[    0.911834] initcall backlight_class_init+0x0/0x70 returned 0 after 0 
usecs
[    0.919219] calling  tty_class_init+0x0/0x3c @ 1
[    0.924743] initcall tty_class_init+0x0/0x3c returned 0 after 0 usecs
[    0.931610] calling  vtconsole_class_init+0x0/0xe4 @ 1
[    0.938812] initcall vtconsole_class_init+0x0/0xe4 returned 0 after 
7629 usecs
[    0.946472] calling  wakeup_sources_debugfs_init+0x0/0x3c @ 1
[    0.952606] initcall wakeup_sources_debugfs_init+0x0/0x3c returned 0 
after 0 usecs
[    0.960571] calling  spi_init+0x0/0x88 @ 1
[    0.966247] initcall spi_init+0x0/0x88 returned 0 after 0 usecs
[    0.972564] calling  i2c_init+0x0/0x70 @ 1
[    0.978485] initcall i2c_init+0x0/0x70 returned 0 after 0 usecs
[    0.984832] calling  omap3_l3_init+0x0/0x14 @ 1

(hang)

- Paul
