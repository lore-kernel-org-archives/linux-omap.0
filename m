From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.29-rc3-omap-git] omap3: gpio pin config bugfixes
Date: Fri, 27 Feb 2009 14:46:08 -0800
Message-ID: <20090227224607.GN11594@atomide.com>
References: <200902082055.08954.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EuxKj2iCbKjpUGkD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60094 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZB0WqM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 17:46:12 -0500
Content-Disposition: inline
In-Reply-To: <200902082055.08954.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>, Manikandan Pillai <mani.pillai@ti.com>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* David Brownell <david-b@pacbell.net> [090208 20:55]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Bugfix several GPIO mux configurations which didn't enable the
> input drivers, but weren't named as e.g. ..._GPIO141_OUT.
> These bugs were added quite recently, for OMAP3 EVM support.
> 
> To help avoid such bugs in the future, update the comment to
> clarify the rule:  always use PIN_INPUT, unless the name uses
> that name suffix, to be crystal-clear on the signal's use as
> output-only.
> 
> (Also adds GPIO-63, for the EVM's MMC-1 writeprotect switch.
> Presumably that works right...)

Here's this refreshed to apply against l-o.

Tony

--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=apply

From:	David Brownell <david-b@pacbell.net>
To:	OMAP <linux-omap@vger.kernel.org>
Subject: [patch 2.6.29-rc3-omap-git] omap3: gpio pin config bugfixes
From: David Brownell <dbrownell@users.sourceforge.net>

Bugfix several GPIO mux configurations which didn't enable the
input drivers, but weren't named as e.g. ..._GPIO141_OUT.
These bugs were added quite recently, for OMAP3 EVM support.

To help avoid such bugs in the future, update the comment to
clarify the rule:  always use PIN_INPUT, unless the name uses
that name suffix, to be crystal-clear on the signal's use as
output-only.

(Also adds GPIO-63, for the EVM's MMC-1 writeprotect switch.
Presumably that works right...)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---

 arch/arm/mach-omap2/mux.c             |   13 ++++++++-----
 arch/arm/plat-omap/include/mach/mux.h |    1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -453,6 +453,7 @@ MUX_CFG_34XX("AC1_3430_USB3FS_PHY_MM3_TX
 
 
 /* 34XX GPIO - bidirectional, unless the name has an "_OUT" suffix.
+ * (Always specify PIN_INPUT, except for names suffixed by "_OUT".)
  * No internal pullup/pulldown without "_UP" or "_DOWN" suffix.
  */
 MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
@@ -460,17 +461,19 @@ MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AF26_34XX_GPIO0", 0x1e0,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AF22_34XX_GPIO9", 0xa18,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("L8_34XX_GPIO63", 0x0ce,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("AE6_34XX_GPIO141", 0x16e,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
-		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AG4_34XX_GPIO134", 0x160,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("U8_34XX_GPIO54", 0x0b4,
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -792,6 +792,7 @@ enum omap34xx_index {
 	J25_34XX_GPIO170,
 	AF26_34XX_GPIO0,
 	AF22_34XX_GPIO9,
+	L8_34XX_GPIO63,
 	AF6_34XX_GPIO140_UP,
 	AE6_34XX_GPIO141,
 	AF5_34XX_GPIO142,


--EuxKj2iCbKjpUGkD--
