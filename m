From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2+: hwmod: fix breakage introduced by d6504acd
Date: Mon, 7 Nov 2011 15:07:28 -0800
Message-ID: <20111107230728.GC31337@atomide.com>
References: <1320688617-4543-1-git-send-email-balbi@ti.com>
 <20111107183208.GG15294@n2100.arm.linux.org.uk>
 <20111107193908.GA5059@legolas.emea.dhcp.ti.com>
 <20111107212707.GH15294@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1111071428001.12394@utopia.booyaka.com>
 <20111107224129.GJ15294@n2100.arm.linux.org.uk>
 <20111107225157.GB31337@atomide.com>
 <20111107225529.GK15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111107225529.GK15294@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111107 14:20]:
> On Mon, Nov 07, 2011 at 02:51:57PM -0800, Tony Lindgren wrote:
> > Here's what I got. Looks like the removal of the sr[12]_hwmod
> > part is no longer needed, so only the r value check part is needed.
> 
> Err.  So do you have anything in your git tree which you're pushing out
> this evening which removes the sr[12]_hwmod from the omap_3xxx_hwmod
> list?
> 
> If not, how does that bug get fixed in mainline?

Ah sorry, there's also the following commit there that deals
with other related issues:

From: Abhilash K V <abhilash.kv@ti.com>
Date: Fri, 7 Oct 2011 03:08:56 -0600
Subject: [PATCH] ARM: OMAP: AM35x: remove hwmods that aren't generic

Removing modules iva, sr1_hwmod, sr2_hwmod, mailbox from
the base omap3xxx_hwmods list, so that they can be excluded
for am35x.  This removes quite a few warnings on boot for AM35x.

Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
[paul@pwsan.com: dropped 'mailbox class' comments; updated changelog]
Signed-off-by: Paul Walmsley <paul@pwsan.com>

--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3132,7 +3132,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_mmc2_hwmod,
 	&omap3xxx_mmc3_hwmod,
 	&omap3xxx_mpu_hwmod,
-	&omap3xxx_iva_hwmod,
 
 	&omap3xxx_timer1_hwmod,
 	&omap3xxx_timer2_hwmod,
@@ -3161,8 +3160,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_i2c1_hwmod,
 	&omap3xxx_i2c2_hwmod,
 	&omap3xxx_i2c3_hwmod,
-	&omap34xx_sr1_hwmod,
-	&omap34xx_sr2_hwmod,
 
 	/* gpio class */
 	&omap3xxx_gpio1_hwmod,
@@ -3184,8 +3181,6 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_mcbsp2_sidetone_hwmod,
 	&omap3xxx_mcbsp3_sidetone_hwmod,
 
-	/* mailbox class */
-	&omap3xxx_mailbox_hwmod,
 
 	/* mcspi class */
 	&omap34xx_mcspi1,
@@ -3198,31 +3193,39 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 
 /* 3430ES1-only hwmods */
 static __initdata struct omap_hwmod *omap3430es1_hwmods[] = {
+	&omap3xxx_iva_hwmod,
 	&omap3430es1_dss_core_hwmod,
+	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
 /* 3430ES2+-only hwmods */
 static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
+	&omap3xxx_iva_hwmod,
 	&omap3xxx_dss_core_hwmod,
 	&omap3xxx_usbhsotg_hwmod,
+	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
 /* 34xx-only hwmods (all ES revisions) */
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
+	&omap3xxx_iva_hwmod,
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
+	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
 /* 36xx-only hwmods (all ES revisions) */
 static __initdata struct omap_hwmod *omap36xx_hwmods[] = {
+	&omap3xxx_iva_hwmod,
 	&omap3xxx_uart4_hwmod,
 	&omap3xxx_dss_core_hwmod,
 	&omap36xx_sr1_hwmod,
 	&omap36xx_sr2_hwmod,
 	&omap3xxx_usbhsotg_hwmod,
+	&omap3xxx_mailbox_hwmod,
 	NULL
 };
 
