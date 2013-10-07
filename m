From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v3 0/3] ARM: dts: omap3-igep: improvements for v3.13
Date: Mon,  7 Oct 2013 17:12:22 +0200
Message-ID: <1381158745-9557-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40663 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741Ab3JGPNY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 11:13:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org

Hi Benoit,

This series are some enhancements and cleanups for IGEP boards
that it would be great if can make it for v3.13.

This is a third version of the patch-set that addresses some issues
raised by Roger Quadros and is composed of the following patches:

[PATCH v3 1/3] ARM: dts: omap3-igep: Add USB OTG support
[PATCH v3 2/3] ARM: dts: omap3-igep0020: Add HS USB Host support
[PATCH v3 3/3] ARM: dts: omap3-igep0020: use standard constant for IRQ

The patches were tested using the new generic PHY framework that are
currently on usb-next branch and will be part of v3.13

Thanks a lot and best regards,
Javier
