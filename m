From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/17] PM: Block CORE off when DSS is active
Date: Tue, 20 Oct 2009 10:19:05 -0700
Message-ID: <87hbtukmpi.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<74583B8642AB8841B30447520659FCA9DDCA9A26@dnce01.ent.ti.com>
	<1F18D6510CF0474A8C9500565A7E41A210F69EEF9C@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:58990 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZJTRTG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 13:19:06 -0400
Received: by pzk26 with SMTP id 26so4238934pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 10:19:09 -0700 (PDT)
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A210F69EEF9C@NOK-EUMSG-02.mgdnok.nokia.com> (Tero Kristo's message of "Mon\, 19 Oct 2009 11\:37\:38 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, kalle.jokiniemi@digia.com

<Tero.Kristo@nokia.com> writes:

>>>
>>>From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
>>>
>>>If CORE power domain is allowed to reach off state
>>>while display is active, the display will go blank.
>>>Fixed by adding a check in idle loop.
>>
>>What is root cause? I guess it is due to extra latency 
>>required to wakeup from OFF?
>>In that case, it should be better to use the 
>>omap_pm_set_max_dev_wakeup_lat() function and set a latency 
>>constraint to the CORE.
>
> I believe the root cause is that if core enters off while display is
> doing something (between DSS data bursts for example), then when the
> display next wakes up and tries to access memories, core has lost
> its context which is rather bad. It is not really a wakeup latency
> issue as such.

Still trying to fully understand...

So when the DSS wakes and tries to access memories, CORE should be
woken up from OFF but the context restore (done by MPU) will not have
happenend resulting in badness.  

If that's the case, this really should be a constraint set by the DSS
driver.  I'm not crazy about adding more special case handling in the
idle path.

While it's not technically a latency constraint we could use
omap_pm_set_max_mpu_wakeup_lat() in the DSS driver with a FIXME
comment to the effect that its not a latency constraint but rather a
prevent CORE context loss type of constraint.

Longer term, we'll need a new OMAP PM function for this.  Something like

    omap_pm_set_maximum_context_loss(struct device *initiator,
                                     strict device *target,
                                     u32 count);

Where count is 0 to prevent context loss and 1 to allow.  In this case,
the initiator would be the dss device and the target would be a new
device used for L3.   Comments?

Kevin

>
>>On the other hand, I remember a discussion between Kevin and 
>>Tomi saying that this API might not be fully functional yet.
>>
>>Regards,
>>Benoit
>>
>>
>>>Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
>>>Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>>>---
>>> arch/arm/mach-omap2/pm34xx.c |    9 ++++++++-
>>> 1 files changed, 8 insertions(+), 1 deletions(-)
>>>
>>>diff --git a/arch/arm/mach-omap2/pm34xx.c 
>>b/arch/arm/mach-omap2/pm34xx.c
>>>index e8704a6..52a3f2b 100644
>>>--- a/arch/arm/mach-omap2/pm34xx.c
>>>+++ b/arch/arm/mach-omap2/pm34xx.c
>>>@@ -103,7 +103,7 @@ static int (*_omap_save_secure_sram)(u32 *addr);
>>>
>>> static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>>> static struct powerdomain *core_pwrdm, *per_pwrdm;
>>>-static struct powerdomain *cam_pwrdm, *iva2_pwrdm;
>>>+static struct powerdomain *cam_pwrdm, *iva2_pwrdm, *dss_pwrdm;
>>>
>>> static struct prm_setup_vc prm_setup = {
>>>       .clksetup = 0xff,
>>>@@ -427,6 +427,7 @@ void omap_sram_idle(void)
>>>       int mpu_next_state = PWRDM_POWER_ON;
>>>       int per_next_state = PWRDM_POWER_ON;
>>>       int core_next_state = PWRDM_POWER_ON;
>>>+      int dss_state = PWRDM_POWER_ON;
>>>       int core_prev_state, per_prev_state;
>>>       u32 sdrc_pwr = 0;
>>>       int per_state_modified = 0;
>>>@@ -469,6 +470,7 @@ void omap_sram_idle(void)
>>>        * save / restore.
>>>        */
>>>       core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>>>+      dss_state = pwrdm_read_pwrst(dss_pwrdm);
>>>       if (core_next_state < PWRDM_POWER_ON) {
>>>               core_saved_state = core_next_state;
>>>               if ((cm_read_mod_reg(CORE_MOD, CM_IDLEST1) & 
>>CORE_IDLEST1_ALL)
>>>@@ -479,6 +481,10 @@ void omap_sram_idle(void)
>>>                               CORE_IDLEST3_ALL) != 
>>CORE_IDLEST3_ALL) {
>>>                       core_next_state = PWRDM_POWER_ON;
>>>                       pwrdm_set_next_pwrst(core_pwrdm, 
>>PWRDM_POWER_ON);
>>>+              } else if (core_next_state == PWRDM_POWER_OFF &&
>>>+                               dss_state == PWRDM_POWER_ON) {
>>>+                      core_next_state = PWRDM_POWER_RET;
>>>+                      pwrdm_set_next_pwrst(core_pwrdm, 
>>PWRDM_POWER_RET);
>>>               }
>>>       }
>>>
>>>@@ -1234,6 +1240,7 @@ static int __init omap3_pm_init(void)
>>>       core_pwrdm = pwrdm_lookup("core_pwrdm");
>>>       cam_pwrdm = pwrdm_lookup("cam_pwrdm");
>>>       iva2_pwrdm = pwrdm_lookup("iva2_pwrdm");
>>>+      dss_pwrdm = pwrdm_lookup("dss_pwrdm");
>>>
>>>       omap_push_sram_idle();
>>> #ifdef CONFIG_SUSPEND
>>>--
>>>1.5.4.3
>>>
>>>--
>>>To unsubscribe from this list: send the line "unsubscribe 
>>linux-omap" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
