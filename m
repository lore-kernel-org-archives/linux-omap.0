From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH] OMAP3 powerdomains: remove RET from SGX power states list
Date: Fri, 07 Nov 2008 17:01:33 +0200
Message-ID: <87ej1na8c2.fsf@trdhcp146196.ntc.nokia.com>
References: <alpine.DEB.2.00.0811051152150.15612@utopia.booyaka.com>
	<20081106033327.GQ21736@atomide.com>
	<alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:27570 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbYKGPBx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 10:01:53 -0500
In-Reply-To: <alpine.DEB.2.00.0811060401150.11718@utopia.booyaka.com> (ext
	Paul Walmsley's message of "Thu, 6 Nov 2008 04:08:44 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Stoppa Igor (Nokia-D/Helsinki)" <Igor.Stoppa@nokia.com>, r-woodruff2@ti.com, Kevin Hilman <khilman@deeprootsystems.com>, "Sawant, Anand" <sawant@ti.com>, Poussa Sakari <sakari.poussa@nokia.com>

"ext Paul Walmsley" <paul@pwsan.com> writes:

> On Wed, 5 Nov 2008, Tony Lindgren wrote:
>
>> * Paul Walmsley <paul@pwsan.com> [081105 11:39]:
>> > 
>> > The SGX device on OMAP3 does not support retention, so remove RET from the 
>> > list of possible SGX power states.  Problem debugged by Richard Woodruff 
>> > <r-woodruff2@ti.com>.
>> 
>> Pushing.
>
> Just FYI, that patch prevents the kernel from booting due to a bug in 
> pm34xx.c; patch below.
>
> Even with the follwoing patch, the initial power state setup code in 
> pm34xx.c will bail out early since it still tries to set the SGX next 
> power state to retention, which it does not support.

What do you Paul think about patch below:

From: Jouni Hogander <jouni.hogander@nokia.com>
Date: Fri, 7 Nov 2008 16:50:51 +0200
Subject: [PATCH] OMAP3: PM: Check that wanted state is supported by pwrdm in pwrdms_setup

Check that wanted sleep state is supported by powerdomain. If it is
not supported, then use next highest supported state.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index da098d2..d9959a8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -515,6 +515,7 @@ static void __init prcm_setup_regs(void)
 static int __init pwrdms_setup(struct powerdomain *pwrdm)
 {
 	struct power_state *pwrst;
+	u32 next_state = PWRDM_POWER_RET;
 
 	if (!pwrdm->pwrsts)
 		return 0;
@@ -523,12 +524,20 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
 		pwrdm_enable_hdwr_sar(pwrdm);
 
+	while (!(pwrdm->pwrsts & (1 << next_state))) {
+		if (next_state > PWRDM_POWER_ON) {
+			next_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
+			break;
+		}
+		next_state++;
+	}
+	pwrst->next_state = next_state;
+
 	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
-- 
1.6.0.1


