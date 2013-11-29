From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 0/3] ARM: OMAP2+: Remove remaining unused legacy code
Date: Fri, 29 Nov 2013 20:18:14 +0100
Message-ID: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40422 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab3K2TTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 14:19:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Now that OMAP2+ board files are scheduled for removal for v3.14
there is unused code that was only used by legacy platform code
and can be removed.

This patch-set depends on the series:

[PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in DT only mode

and is composed of the following patches:

[PATCH 1/3] ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC
[PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in GPMC driver
[PATCH 3/3] ARM: OMAP2+: Remove legacy board-flash.c

Best regards,
Javier
