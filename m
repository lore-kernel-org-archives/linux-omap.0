From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 2/2] arm: omap: gpmc-smsc911x: minor style fixes
Date: Tue, 26 Apr 2011 18:48:07 +0300
Message-ID: <4DB6E937.7090904@compulab.co.il>
References: <1303397412-24813-1-git-send-email-grinberg@compulab.co.il> <1303397412-24813-2-git-send-email-grinberg@compulab.co.il> <BANLkTikw73F1RBmJC=+Z2msA3Wr7gG3AGQ@mail.gmail.com> <4DB6D974.6080201@compulab.co.il> <BANLkTi=3eh+0zRD4jRDPoiGxMgCGeOdrww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:47471
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751180Ab1DZPsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Apr 2011 11:48:12 -0400
In-Reply-To: <BANLkTi=3eh+0zRD4jRDPoiGxMgCGeOdrww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Mike Rapoport <mike@compulab.co.il>, Tim Nordell <tim.nordell@logicpd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 04/26/11 17:49, Menon, Nishanth wrote:

> On Tue, Apr 26, 2011 at 09:40, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> Hi Nishanth,
>>
>> On 04/26/11 16:45, Menon, Nishanth wrote:
>>
>>> On Thu, Apr 21, 2011 at 09:50, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>>> replace "printk(KERN_ERR" by "pr_err("
>>>> and fix needlessly multi-lined #ifdef
>>>>
>>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>>>> ---
>>>>  arch/arm/mach-omap2/gpmc-smsc911x.c             |   14 +++++++-------
>>>>  arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |    3 +--
>>>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
>>>> index d30293a..b45efff 100644
>>>> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
>>>> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
>>> minor suggestion: wont using pr_fmt help to reduce the need to add %s,
>>> __func__ for pr_err through out the file?
>> I don't understand of what "need" are you talking about.
>> I don't know of any need to add "%s, __func__" with pr_fmt...
>> I've added "%s, __func__" as a meter of choice.
>> IMO, it makes it easier to parse the dmesg output.
>> If anyone objects it, I can remove them,
>> but I think both pr_fmt and __func__ are nice here and
>> way better then "printk(KERN_*" with embedded "smsc911x".
> Allow me to rephrase.
> I like the change of printk->pr_err - thanks for doing it. just
> suggesting a minor improvement
>
> if you add the following line before the #includes
> #define pr_fmt(fmt) "%s: " fmt, __func__
> then
> -               printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
> -                               gpmc_cfg->gpio_irq);
> +               pr_err("%s: Failed to request IRQ GPIO%d\n", __func__,
> +                      gpmc_cfg->gpio_irq);
> becomes,
> -               printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
> -                               gpmc_cfg->gpio_irq);
> +               pr_err("Failed to request IRQ GPIO%d\n", gpmc_cfg->gpio_irq);
>
> Both give you exactly the output you would like to see (which I
> personally prefer as well), but the second could be lesser lines of
> code change ;)

Ahh, now I understand, that can be useful indeed.
I'll send a v2...

Thanks

-- 
Regards,
Igor.

