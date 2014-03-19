From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [RESEND PATCH 0/3] ARM: OMAP2+: Remove remaining unused legacy code
Date: Wed, 19 Mar 2014 07:08:12 +0100
Message-ID: <1395209295-24399-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:58603 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbaCSGIq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 02:08:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Once OMAP2+ board files are removed, there is unused code that was only used
by legacy platform code and can be removed.

This patch-set depends on the series:

[PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in DT only mode [0]

and is composed of the following patches:

[RESEND PATCH 1/3] ARM: OMAP2+: Remove legacy smsc911x and smc91x
[RESEND PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in GPMC
[RESEND PATCH 3/3] ARM: OMAP2+: Remove legacy board-flash.c

Tony,

I don't know what is your new schedule for board files removal but in case it is
3.16, I forward ported this patch-set on top of 3.14-rc7 and fixed some conflicts.

Best regards,
Javier

[0]: http://marc.info/?t=138542504600001&r=1&w=2
