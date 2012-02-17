From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with
 frequency
Date: Fri, 17 Feb 2012 12:19:20 +0200
Message-ID: <1329473960.4102.417.camel@sokoban>
References: <1329420043-32656-1-git-send-email-khilman@ti.com>
	 <1329420043-32656-2-git-send-email-khilman@ti.com>
	 <CAORVsuUsnp8gMygbsrQh7O6048eUyjTrT3Ob_Jop5JKQyxiMOA@mail.gmail.com>
	 <87lio2fu56.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60049 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab2BQKTX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 05:19:23 -0500
In-Reply-To: <87lio2fu56.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

On Thu, 2012-02-16 at 11:36 -0800, Kevin Hilman wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
> 
> > Hi Kevin,
> >
> > On Thu, Feb 16, 2012 at 11:20 AM, Kevin Hilman <khilman@ti.com> wrote:
> >> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> >> index 8a36342..140c032 100644
> >> --- a/arch/arm/mach-omap2/voltage.c
> >> +++ b/arch/arm/mach-omap2/voltage.c
> >> @@ -89,6 +89,8 @@ int voltdm_scale(struct voltagedomain *voltdm,
> >>        ret = voltdm->scale(voltdm, target_volt);
> >>        if (!ret)
> >>                voltdm->nominal_volt = target_volt;
> >> +       printk("KJH: %s: %d\n", __func__, target_volt);
> >> +       dump_stack();
> > The debugging letfovers need to be removed.
> 
> heh, that's why it's RFT.  :)

<snip>

I tested this out with performance governor and limiting the
max_scaling_freq to different numbers. Clock frequency seems to change
based on arm_fck/rate debugfs entry, and the voltage is changing based
on both measurement and microvolts entry for the regulator.

However, twd_update_frequency crashes on omap3, as it doesn't have local
timer support but smp_twd registers a cpufreq notifier anyways.
Following patch fixes this issue (I'll send this out to l-o and l-arm
lists separately in a bit):

---
 arch/arm/kernel/smp_twd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 4285daa..dae8902 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb = {
 
 static int twd_cpufreq_init(void)
 {
-       if (!IS_ERR(twd_clk))
+       if (twd_clk && !IS_ERR(twd_clk))
                return cpufreq_register_notifier(&twd_cpufreq_nb,
                        CPUFREQ_TRANSITION_NOTIFIER);
 
-- 
1.7.4.1


