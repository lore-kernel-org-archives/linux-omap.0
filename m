From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm_wip/voltdm_nm][PATCH v2 2/3] OMAP4: PM: VC: introduce concept of default channel
Date: Thu, 02 Jun 2011 16:45:15 -0700
Message-ID: <87pqmvn6gk.fsf@ti.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com>
	<1306711180-8631-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:57101 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752511Ab1FBXpT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 19:45:19 -0400
Received: by mail-pv0-f169.google.com with SMTP id 12so780701pvc.14
        for <linux-omap@vger.kernel.org>; Thu, 02 Jun 2011 16:45:18 -0700 (PDT)
In-Reply-To: <1306711180-8631-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sun, 29 May 2011 16:19:39 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Due to a TRM bug, the current code assumes that channel0(core) is the default
> channel. With the additional explanation provided by the hardware team, it is
> clear that PRM_VC_CFG_CHANNEL register allows for flexibility of configuring
> for various PMIC configurations. For example, the I2C slave address on TWL6030
> when using 4430 configuration could potentially use the same slave address for
> all domains, while in 4460 configuration, we drive MPU using TPS; Core and IVA
> using TWL6030. To allow this flexibility, we state in existing parameters using
> a flag to indicate usage of default channel.
>
> In addition, the TRM update clears up the confusion on the fact that MPU is
> infact the default channel on OMAP4.
>
> We update the same here.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

There's too much going on in this patch not described in the changelog
(extra error checking, volt & cmd reg checking etc.)

Also, I don't like the USE_DEFAULT_CHANNEL_I2C_PARAM, mainly because it
adds clutter without any obvious value.  To me, zero is a perfectly good
value to signify "use default channel value", especially since that's
the value used by the hardware.

Incidentally, adding this doesn't actually change current behavior.
Currently, I use zero (an unconfigured value in the VC settings) to
signify it should use default settings.  In your patch, you defined
USE_DEFAULT_CHANNEL_I2C_PARAM as 0x10000 (17 bits) but assign it to 16
bit fields, which means they are just set to zero. :)

So rather than take this patch, I'm just going to fold the following
diff into "OMAP3+: VC: abstract out channel configuration" in voltdm_b.
I'll also update the changelog noting that the TRM is wrong here in that
it describes CORE as the default channel when it's in fact MPU.

Kevin

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index fba352d..fa48944 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -33,21 +33,20 @@
  * - command configuration address (RAC) and enable bit (RACEN)
  * - command values for ON, ONLP, RET and OFF (CMD)
  *
- * This function currently only allows flexible configuration of
- * the non-default channel (e.g. non-zero channels.)  Starting with
- * OMAP4, only the non-zero channels can be configured.  Channel zero
- * always uses the channel zero register values.  Therefore, the
- * same limitation is imposed on OMAP3 for consistency.
+ * This function currently only allows flexible configuration of the
+ * non-default channel.  Starting with OMAP4, there are more than 2
+ * channels, with one defined as the default (on OMAP4, it's MPU.)
+ * Only the non-default channel can be configured.
  */
 static int omap_vc_config_channel(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
 
 	/*
-	 * For channel zero, the only configurable bit is RACEN.
+	 * For default channel, the only configurable bit is RACEN.
 	 * All others must stay at zero (see function comment above.)
 	 */
-	if (!vc->cfg_channel_sa_shift)
+	if (vc->is_default_channel)
 		vc->cfg_channel &= CFG_CHANNEL_RACEN;
 
 	voltdm->rmw(CFG_CHANNEL_MASK << vc->cfg_channel_sa_shift,
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index f0fb61f..c216b57 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -84,6 +84,8 @@ struct omap_vc_channel {
 	u32 smps_cmdra_mask;
 	u8 cmdval_reg;
 	u8 cfg_channel_sa_shift;
+
+	bool is_default_channel;
 };
 
 extern struct omap_vc_channel omap3_vc_mpu;
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index fe4f4e5..5844b20 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -58,6 +58,7 @@ struct omap_vc_channel omap4_vc_mpu = {
 	.smps_volra_mask = OMAP4430_VOLRA_VDD_MPU_L_MASK,
 	.smps_cmdra_mask = OMAP4430_CMDRA_VDD_MPU_L_MASK,
 	.cfg_channel_sa_shift = OMAP4430_SA_VDD_MPU_L_SHIFT,
+	.is_default_channel = true,
 };
 
 struct omap_vc_channel omap4_vc_iva = {
