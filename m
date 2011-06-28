From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 8/8] OMAP2+: hwmod: Follow the recommended PRCM module
 enable sequence
Date: Tue, 28 Jun 2011 14:55:14 -0700
Message-ID: <4E0A4DC2.4060501@ti.com>
References: <1309191103-8817-1-git-send-email-b-cousson@ti.com>	<1309191103-8817-9-git-send-email-b-cousson@ti.com> <87wrg5yiz5.fsf@ti.com> <4E0A48BA.7080602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40738 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751149Ab1F1VzT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 17:55:19 -0400
Received: by mail-yw0-f44.google.com with SMTP id 31so287983ywp.3
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 14:55:18 -0700 (PDT)
In-Reply-To: <4E0A48BA.7080602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "toddpoynor@google.com" <toddpoynor@google.com>

On 6/28/2011 2:33 PM, Cousson, Benoit wrote:
> On 6/28/2011 7:16 PM, Hilman, Kevin wrote:
>> Benoit Cousson<b-cousson@ti.com> writes:
>>
>>> From: Rajendra Nayak<rnayak@ti.com>
>>>
>>> On OMAP4, the PRCM recommended sequence for enabling
>>> a module after power-on-reset is:
>>> -1- Force clkdm to SW_WKUP
>>> -2- Enabling the clocks
>>> -3- Configure desired module mode to "enable" or "auto"
>>> -4- Wait for the desired module idle status to be FUNC
>>> -5- Program clkdm in HW_AUTO(if supported)
>>>
>>> This sequence applies to all older OMAPs' as well,
>>> however since they use autodeps, it makes sure that
>>> no clkdm is in IDLE, and hence not requiring a force
>>> SW_WKUP when a module is being enabled.
>>
>> OK, I found the problem that prevents booting on OMAP3...
>
> Cool... thanks for that.
>
>>> OMAP4 does not need to support autodeps, because
>>> of the dyanamic dependency feature, wherein
>>> the HW takes care of waking up a clockdomain from
>>> idle and hence the module, whenever an interconnect
>>> access happens to the given module.
>>>
>>> Implementing the sequence for OMAP4 requires
>>> the clockdomain handling that is currently done in
>>> clock framework to be done as part of hwmod framework
>>> since the step -4- above to "Wait for the desired
>>> module idle status to be FUNC" is done as part of
>>> hwmod framework.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> [b-cousson@ti.com: Adapt it to the new clkdm hwmod attribute and API]
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Paul Walmsley<paul@pwsan.com>
>>> ---
>>> arch/arm/mach-omap2/clock.c | 17 +----------------
>>> arch/arm/mach-omap2/omap_hwmod.c | 26 +++++++++++++++++++++++++-
>>> 2 files changed, 26 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
>>> index 180299e..2828d29 100644
>>> --- a/arch/arm/mach-omap2/clock.c
>>> +++ b/arch/arm/mach-omap2/clock.c
>>> @@ -268,9 +268,6 @@ void omap2_clk_disable(struct clk *clk)
>>> clk->ops->disable(clk);
>>> }
>>>
>>> - if (clk->clkdm)
>>> - clkdm_clk_disable(clk->clkdm, clk);
>>> -
>>> if (clk->parent)
>>> omap2_clk_disable(clk->parent);
>>> }
>>> @@ -308,30 +305,18 @@ int omap2_clk_enable(struct clk *clk)
>>> }
>>> }
>>>
>>> - if (clk->clkdm) {
>>> - ret = clkdm_clk_enable(clk->clkdm, clk);
>>> - if (ret) {
>>> - WARN(1, "clock: %s: could not enable clockdomain %s: "
>>> - "%d\n", clk->name, clk->clkdm->name, ret);
>>> - goto oce_err2;
>>> - }
>>> - }
>>> -
>>> if (clk->ops&& clk->ops->enable) {
>>> trace_clock_enable(clk->name, 1, smp_processor_id());
>>> ret = clk->ops->enable(clk);
>>> if (ret) {
>>> WARN(1, "clock: %s: could not enable: %d\n",
>>> clk->name, ret);
>>> - goto oce_err3;
>>> + goto oce_err2;
>>> }
>>> }
>>
>> The clkdm enable/disable in this part of the patch is still required on
>> OMAP2/3, since the clkdm is still attached to the clock and not to the
>> hwmod.
>
> OK, but I guess that in case of OMAP4, we are probably incrementing
> twice the usage counter... but that should not hurt, because we will
> decrement twice as well.
>
> Rajendra,
> Does that seems OK to you?

When I did the initial patch, all clkdm's were still associated with
clocks, and removing this from clock framework made sense and also
worked on OMAP3/2, because I had clkdm_clk_enable/disable being called
from hwmod framework.
Now that we have clkdm_hwmod_enable/disable being called from hwmod
framework, and clkdm's are associated with hwmod, I guess its best to
do this for all OMAP's. Keeping this association of clkdm with clocks
(for OMAP3/2) and the above piece of code because that association
exits looks messy.

>
> Thanks,
> Benoit

