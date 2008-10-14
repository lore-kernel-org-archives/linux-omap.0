From: Tony Lindgren <tony@atomide.com>
Subject: Re: git pull request for minimal omap3 support one more time
Date: Tue, 14 Oct 2008 10:19:08 -0700
Message-ID: <20081014171907.GD8150@atomide.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com> <20081004070534.GB30190@muru.com> <20081009145436.GI435@flint.arm.linux.org.uk> <20081009151724.GK26230@atomide.com> <20081010073251.GN435@flint.arm.linux.org.uk> <20081010091557.GI3044@atomide.com> <20081010092520.GK3044@atomide.com> <20081010113533.GU3044@atomide.com> <20081013133256.GA3510@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="s2ZSL+KKDSLx8OML"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52869 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYJNRTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 13:19:30 -0400
Content-Disposition: inline
In-Reply-To: <20081013133256.GA3510@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: twebb <taliaferro62@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081013 09:15]:
> On Fri, Oct 10, 2008 at 02:35:34PM +0300, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [081010 12:41]:
> > > * Tony Lindgren <tony@atomide.com> [081010 12:15]:
> > > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [081010 11:42]:
> > > > > On Thu, Oct 09, 2008 at 06:17:25PM +0300, Tony Lindgren wrote:
> > > > > > Sure, I'll post a minimal LDP patch separately tomorrow. I don't have
> > > > > > an LDP so I can't verify it boots though.
> > > > > 
> > > > > Unfortunately, Linus has been unpredictable, and released 2.6.27 last
> > > > > night, rather than the usual one week after -rc9.
> > > > > 
> > > > > What this means is that the merge window is now open, and I shouldn't
> > > > > be accepting anything else into my kernel tree.
> > > > > 
> > > > > However, if you can get LDP in by this evening, I'll pull it into the
> > > > > tree.  That will be the final devel code merged into my tree for 2.6.28.
> > > > 
> > > > Sure. Here's the minimal board patch for LDP with it's defconfig
> > > > in the following mail. Also added to the omap3-upstream queue.
> > > 
> > > Here's the defconfig.
> > 
> > And here's the updated pull request for you with the LDP patches added.
> > 
> > I also changed the title of the Overo patches to say OMAP3 instead of
> > OMAP2 for consistency.
> > 
> > Note that this will also pull the already posted omap2-upstream as
> > omap3-upstream is based on that.
> 
> There's something wrong with one of the sets I've pulled from you:
> 
> arch/arm/mach-omap2/mcbsp.c:253: error: ‘INT_24XX_MCBSP3_IRQ_RX’ undeclared here (not in a function)
> arch/arm/mach-omap2/mcbsp.c:254: error: ‘INT_24XX_MCBSP3_IRQ_TX’ undeclared here (not in a function)
> arch/arm/mach-omap2/mcbsp.c:262: error: ‘INT_24XX_MCBSP4_IRQ_RX’ undeclared here (not in a function)
> arch/arm/mach-omap2/mcbsp.c:263: error: ‘INT_24XX_MCBSP4_IRQ_TX’ undeclared here (not in a function)
> arch/arm/mach-omap2/mcbsp.c:271: error: ‘INT_24XX_MCBSP5_IRQ_RX’ undeclared here (not in a function)
> arch/arm/mach-omap2/mcbsp.c:272: error: ‘INT_24XX_MCBSP5_IRQ_TX’ undeclared here (not in a function)
> 
> Please take a look and resolve ASAP.  Thanks.

Sorry for the delay, I was sitting in an airplane again.

Here's the fix, looks like the missing McBSP irqs should have been
merged into the recent McBSP patches.

This patch is also in your patch system as 5301/1.

Tony

--s2ZSL+KKDSLx8OML
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="irqs.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 14 Oct 2008 10:07:04 -0700
Subject: [PATCH] ARM: OMAP: Add missing irq defines

Some McBSP irq defines were missing that should have been added
with the earlier McBSP patches.

Add the missing McBSP irqs, and a few other missing irqs as
defined in linux-omap tree. Also add a blank line to separate
irq defines from the irq line calculations.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -266,6 +266,8 @@
 #define INT_24XX_GPTIMER11	47
 #define INT_24XX_GPTIMER12	48
 #define INT_24XX_SHA1MD5	51
+#define INT_24XX_MCBSP4_IRQ_TX	54
+#define INT_24XX_MCBSP4_IRQ_RX	55
 #define INT_24XX_I2C1_IRQ	56
 #define INT_24XX_I2C2_IRQ	57
 #define INT_24XX_HDQ_IRQ	58
@@ -284,7 +286,22 @@
 #define INT_24XX_USB_IRQ_HGEN	78
 #define INT_24XX_USB_IRQ_HSOF	79
 #define INT_24XX_USB_IRQ_OTG	80
+#define INT_24XX_MCBSP5_IRQ_TX	81
+#define INT_24XX_MCBSP5_IRQ_RX	82
 #define INT_24XX_MMC_IRQ	83
+#define INT_24XX_MMC2_IRQ	86
+#define INT_24XX_MCBSP3_IRQ_TX	89
+#define INT_24XX_MCBSP3_IRQ_RX	90
+#define INT_24XX_SPI3_IRQ	91
+
+#define INT_243X_MCBSP2_IRQ	16
+#define INT_243X_MCBSP3_IRQ	17
+#define INT_243X_MCBSP4_IRQ	18
+#define INT_243X_MCBSP5_IRQ	19
+#define INT_243X_MCBSP1_IRQ	64
+#define INT_243X_HS_USB_MC	92
+#define INT_243X_HS_USB_DMA	93
+#define INT_243X_CARKIT_IRQ	94
 
 #define INT_34XX_BENCH_MPU_EMUL	3
 #define INT_34XX_ST_MCBSP2_IRQ	4
@@ -321,6 +338,7 @@
 #define INT_34XX_PARTHASH_IRQ	79
 #define INT_34XX_MMC3_IRQ	94
 #define INT_34XX_GPT12_IRQ	95
+
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and
  * 16 MPUIO lines */
 #define OMAP_MAX_GPIO_LINES	192

--s2ZSL+KKDSLx8OML--
