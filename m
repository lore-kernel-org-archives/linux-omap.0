From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/12] OMAP1: remove duplicated #include
Date: Mon, 22 Jun 2009 14:41:00 +0300
Message-ID: <20090622114100.28477.75299.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56639 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552AbZFVLk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:40:59 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

From: Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include in arch/arm/mach-omap1/board-nokia770.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-nokia770.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index d9ebba0..ed2a48a 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -36,7 +36,6 @@
 #include <mach/hwa742.h>
 #include <mach/lcd_mipid.h>
 #include <mach/mmc.h>
-#include <mach/usb.h>
 #include <mach/clock.h>
 
 #define ADS7846_PENDOWN_GPIO	15

