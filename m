From: David Brownell <david-b@pacbell.net>
Subject: Re: [APPLIED] Overo broken after recent mainline merge
Date: Fri, 20 Mar 2009 15:33:24 -0700
Message-ID: <200903201533.24620.david-b@pacbell.net>
References: <notify-1237576717@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:29015 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752947AbZCTWd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2009 18:33:27 -0400
In-Reply-To: <notify-1237576717@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Friday 20 March 2009, Tony Lindgren wrote:
> This patch has been applied to the linux-omap
> by youw fwiendly patch wobot.
> 
> Commit: f4223ec219313d631c3f620220ed23670c158a34
> 
> PatchWorks
> http://patchwork.kernel.org/patch/12140/
> 

To avoid needless divergence from mainline, the appended
patch would probably work better ... it doesn't actually
fix the bug in the regulator core, but it's a workaround
that could go to mainline until that core gets fixed.

(Oh, and it includes a real, albeit minor, bugfix.)

- Dave

=============
From: David Brownell <dbrownell@users.sourceforge.net>

Updates to the mmc-twl4030 code:

 - Partial workaround for the bug fixed more comprehensively
   by f4223ec219313d631c3f620220ed23670c158a34 ... workaround
   applies only to MMC devs using this code.

 - Fix a cut'n'paste bug as noted by Adrian Hunter:  the intent
   was to "disable" not (re)"enable".

The reason to want this workaround is lack of faith that any
sane fix for that regulator framework bug will ever merge,
while still wanting to see things work in mainline.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
I suggest reverting f4223ec219313d631c3f620220ed23670c158a34
after applying this ...

 arch/arm/mach-omap2/mmc-twl4030.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -128,6 +128,27 @@ static int twl_mmc_late_init(struct devi
 			reg = regulator_get(dev, "vmmc_aux");
 			hsmmc[i].vcc_aux = IS_ERR(reg) ? NULL : reg;
 
+			/* UGLY HACK:  workaround regulator framework bugs.
+			 * When the bootloader leaves a supply active, it's
+			 * initialized with zero usecount ... and we can't
+			 * disable it without first disabling it.  Until the
+			 * framework is fixed, we need a workaround like this
+			 * (which is safe for MMC, but not in general).
+			 */
+			if (regulator_is_enabled(hsmmc[i].vcc) > 0) {
+				dev_warn(dev, "APPLY REGULATOR HACK for vmmc\n");
+				regulator_enable(hsmmc[i].vcc);
+				regulator_disable(hsmmc[i].vcc);
+			}
+			if (hsmmc[i].vcc_aux) {
+				if (regulator_is_enabled(reg) > 0) {
+					dev_warn(dev, "APPLY REGULATOR HACK "
+						"for vmmc_aux\n");
+					regulator_enable(reg);
+					regulator_disable(reg);
+				}
+			}
+
 			break;
 		}
 	}
@@ -285,7 +306,7 @@ static int twl_mmc23_set_power(struct de
 		}
 	} else {
 		if (c->vcc_aux)
-			ret = regulator_enable(c->vcc_aux);
+			ret = regulator_disable(c->vcc_aux);
 		if (ret == 0)
 			ret = mmc_regulator_set_ocr(c->vcc, 0);
 	}

