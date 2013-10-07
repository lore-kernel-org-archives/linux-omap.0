From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 0/3] ARM: dts: omap3-igep: improvements for v3.13
Date: Mon,  7 Oct 2013 11:55:37 +0200
Message-ID: <1381139740-13495-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40481 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab3JGJ4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 05:56:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org

Hi Benoit,

This series are some enhancements and cleanups for IGEP boards
that it would be great if can make it for v3.13.

This is a second version of the patch-set that addresses some issues
raised by Roger Quadros and is composed of the following patches:

[PATCH v2 1/3] ARM: dts: omap3-igep: Add USB OTG support
[PATCH v2 2/3] ARM: dts: omap3-igep0020: Add HS USB Host support
[PATCH v2 3/3] ARM: dts: omap3-igep0020: use standard constant for IRQ

Patch 1 and 2 adds USB OTG and Host support respectively and patch 3
is a small cleanup to get rid of a magic number and use the proper
constant for IRQ edge/level type flags.

Thanks a lot and best regards,
Javier
