From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 0/3] ARM: dts: omap3-igep0020: improvements for v3.13
Date: Sat,  5 Oct 2013 02:04:36 +0200
Message-ID: <1380931479-16142-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:39036 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab3JEAF1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Oct 2013 20:05:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org

Hi Benoit,

This series are some enhancements and cleanups for IGEP boards
that it would be great if can make it for v3.13.

The patch-set is composed of the following patches:

[PATCH 1/3] ARM: dts: omap3-igep0020: Add USB OTG support
[PATCH 2/3] ARM: dts: omap3-igep0020: Add HS USB Host support
[PATCH 3/3] ARM: dts: omap3-igep0020: use standard constant for IRQ flags

Patch 1 and 2 adds USB OTG and Host support respectively and patch 3
is a small cleanup to get rid of a magic number and use the proper
constant for IRQ edge/level type flags.

Thanks a lot and best regards,
Javier
