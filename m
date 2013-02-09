From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH RFC 0/7] ARM: OMAP: add DT binding for gpmc-smsc911x
Date: Sat,  9 Feb 2013 21:44:24 +0100
Message-ID: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40035 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540Ab3BIUot (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 15:44:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This is an RFC to add Device Tree support for SMSC LAN chips connected
to OMAP processors though its General-Purpose Memory Controller.

The patch-set is composed of the following patches:

[PATCH RFC 1/7] platform: add a device node
[PATCH RFC 2/7] net: smsc911x: add pinctrl support
[PATCH RFC 3/7] ARM: OMAP: gpmc-smsc911x: add DT dev node init function
[PATCH RFC 4/7] ARM: OMAP: gpmc-smsc911x: pass a dev node to platform
[PATCH RFC 5/7] ARM: OMAP: gpmc: add support for gpmc-smsc911x child
[PATCH RFC 6/7] ARM: dts: OMAP: Add an GPMC node for OMAP3
[PATCH RFC 7/7] ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support

It is an RFC because I had to modify the platform_device_register_resndata()
platform device registration function to allow passing a device node and
associate to the platform device after allocation. The patch-set updates all
current users and this shouldn't have a function effect on them.

I think that the need for platform code to pass the DT device node to the
platform registration infraestructure will be needed for other devices too
whose probe function needs to access the device node associated with the
device.

The binding has been tested on an TI OMAP3 based board (IGEPv2) and added
support is included on the RFC as an example.

It is based on Linus' latest master branch + linux-omap/omap-for-v3.9/gpmc
+ linux-omap-dt/for_3.9/dts

Thanks a lot and best regards,
Javier
