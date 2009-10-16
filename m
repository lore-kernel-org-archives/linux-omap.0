From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH 03/17] PM: Block CORE off when DSS is active
Date: Fri, 16 Oct 2009 17:27:18 +0200
Message-ID: <74583B8642AB8841B30447520659FCA9DDCA9A26@dnce01.ent.ti.com>
References: <> <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50311 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbZJPP2H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 11:28:07 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Hi Tero,

>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of Tero Kristo
>Sent: Friday, October 16, 2009 12:49 PM
>To: linux-omap@vger.kernel.org
>Cc: Kalle Jokiniemi
>Subject: [PATCH 03/17] PM: Block CORE off when DSS is active
>
>From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
>
>If CORE power domain is allowed to reach off state
>while display is active, the display will go blank.
>Fixed by adding a check in idle loop.

What is root cause? I guess it is due to extra latency required to wakeup from OFF?
In that case, it should be better to use the omap_pm_set_max_dev_wakeup_lat() function and set a latency constraint to the CORE.

On the other hand, I remember a discussion between Kevin and Tomi saying that this API might not be fully functional yet.

Regards,
Benoit


>Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
>Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>---
> arch/arm/mach-omap2/pm34xx.c |    9 ++++++++-
> 1 files changed, 8 insertions(+), 1 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>index e8704a6..52a3f2b 100644
>--- a/arch/arm/mach-omap2/pm34xx.c
>+++ b/arch/arm/mach-omap2/pm34xx.c
>@@ -103,7 +103,7 @@ static int (*_omap_save_secure_sram)(u32 *addr);
>
> static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
> static struct powerdomain *core_pwrdm, *per_pwrdm;
>-static struct powerdomain *cam_pwrdm, *iva2_pwrdm;
>+static struct powerdomain *cam_pwrdm, *iva2_pwrdm, *dss_pwrdm;
>
> static struct prm_setup_vc prm_setup = {
>       .clksetup = 0xff,
>@@ -427,6 +427,7 @@ void omap_sram_idle(void)
>       int mpu_next_state = PWRDM_POWER_ON;
>       int per_next_state = PWRDM_POWER_ON;
>       int core_next_state = PWRDM_POWER_ON;
>+      int dss_state = PWRDM_POWER_ON;
>       int core_prev_state, per_prev_state;
>       u32 sdrc_pwr = 0;
>       int per_state_modified = 0;
>@@ -469,6 +470,7 @@ void omap_sram_idle(void)
>        * save / restore.
>        */
>       core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>+      dss_state = pwrdm_read_pwrst(dss_pwrdm);
>       if (core_next_state < PWRDM_POWER_ON) {
>               core_saved_state = core_next_state;
>               if ((cm_read_mod_reg(CORE_MOD, CM_IDLEST1) & CORE_IDLEST1_ALL)
>@@ -479,6 +481,10 @@ void omap_sram_idle(void)
>                               CORE_IDLEST3_ALL) != CORE_IDLEST3_ALL) {
>                       core_next_state = PWRDM_POWER_ON;
>                       pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_ON);
>+              } else if (core_next_state == PWRDM_POWER_OFF &&
>+                               dss_state == PWRDM_POWER_ON) {
>+                      core_next_state = PWRDM_POWER_RET;
>+                      pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
>               }
>       }
>
>@@ -1234,6 +1240,7 @@ static int __init omap3_pm_init(void)
>       core_pwrdm = pwrdm_lookup("core_pwrdm");
>       cam_pwrdm = pwrdm_lookup("cam_pwrdm");
>       iva2_pwrdm = pwrdm_lookup("iva2_pwrdm");
>+      dss_pwrdm = pwrdm_lookup("dss_pwrdm");
>
>       omap_push_sram_idle();
> #ifdef CONFIG_SUSPEND
>--
>1.5.4.3
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


