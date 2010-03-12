From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 19b/19] ARM/OMAP: Remove the +x bit from a couple of source
 files
Date: Thu, 11 Mar 2010 16:11:19 -0800
Message-ID: <20100312001119.GB2900@atomide.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61887 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab0CLAJ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 19:09:58 -0500
Content-Disposition: inline
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

>From 5aeb05c97c94f03627ad6983a0b5069ea539d084 Mon Sep 17 00:00:00 2001
From: Andrew Clayton <andrew@digital-domain.net>
Date: Sat, 6 Mar 2010 00:14:46 +0000
Subject: [PATCH] ARM/OMAP: Remove the +x bit from a couple of source files

Remove the +x bit from a couple of source files

Signed-off-by: Andrew Clayton <andrew@digital-domain.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
old mode 100755
new mode 100644
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
old mode 100755
new mode 100644
