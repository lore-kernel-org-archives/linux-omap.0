From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/12] ARM: OMAP3: mmc-twl4030 add cover switch
Date: Tue, 10 Mar 2009 14:12:35 -0700
Message-ID: <20090310211235.16425.63506.stgit@localhost>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58473 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbZCJVMh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 17:12:37 -0400
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

From: Adrian Hunter <adrian.hunter@nokia.com>

Allow a cover switch to be used to cause a rescan of the
MMC slot.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |   13 ++++++++++++-
 arch/arm/mach-omap2/mmc-twl4030.h |    1 +
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 2becaf3..9f53d22 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -100,6 +100,14 @@ static int twl_mmc_get_ro(struct device *dev, int slot)
 	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
 }
 
+static int twl_mmc_get_cover_state(struct device *dev, int slot)
+{
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	/* NOTE: assumes card detect signal is active-low */
+	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+}
+
 /*
  * MMC Slot Initialization.
  */
@@ -410,7 +418,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 
 			mmc->slots[0].switch_pin = c->gpio_cd;
 			mmc->slots[0].card_detect_irq = gpio_to_irq(c->gpio_cd);
-			mmc->slots[0].card_detect = twl_mmc_card_detect;
+			if (c->cover_only)
+				mmc->slots[0].get_cover_state = twl_mmc_get_cover_state;
+			else
+				mmc->slots[0].card_detect = twl_mmc_card_detect;
 		} else
 			mmc->slots[0].switch_pin = -EINVAL;
 
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index 21d3572..0aa1686 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -11,6 +11,7 @@ struct twl4030_hsmmc_info {
 	u8	wires;		/* 1/4/8 wires */
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
+	bool	cover_only;	/* No card detect - just cover switch */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	struct device *dev;	/* returned: pointer to mmc adapter */

