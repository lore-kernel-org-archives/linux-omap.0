From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [pm-wip/cpufreq][PATCH 3/3] OMAP2+: cpufreq: do lateinit
Date: Tue, 7 Jun 2011 07:38:20 -0500
Message-ID: <BANLkTimKYru6f4cNYaNp+Gh7f=+hZNXpsw@mail.gmail.com>
References: <1307412330-25798-1-git-send-email-nm@ti.com> <1307412330-25798-4-git-send-email-nm@ti.com>
 <4DEDDE1C.3050506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:52829 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753221Ab1FGMio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jun 2011 08:38:44 -0400
Received: by mail-ww0-f45.google.com with SMTP id 36so4074882wwi.26
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 05:38:42 -0700 (PDT)
In-Reply-To: <4DEDDE1C.3050506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, kevin <khilman@ti.com>

On Tue, Jun 7, 2011 at 03:15, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 6/7/2011 7:35 AM, Nishanth Menon wrote:
>>
>> Since we do module_init, cpufreq initializes before power late_init
>> where many of the required data structures are registered. Move
>> cpufreq init to late_initcall instead. Further CONFIG_CPU_FREQ
>> on which the build depends is bool and does'nt support modules yet.
>>
> You might want to fix sequence instead of this change
> considering we want to make OMAP CPUFReq as a loadable module.

Unless I add a is_omap_pm_ready() in omap_target() - it is not really
safe. but smartreflex.c has a similar issue as well - I am open to
suggestions on how we should fix this in a clean manner. Current
omap2-cpufreq.c does not do dvfs - so it has dependency only on clocks
- but the moment it depends on anything PM code does,we'd be dead as,
for instance, dvfs requires a lot of those pieces to fall in place
before we can execute omap_target.

Regards,
Nishanth Menon

>
>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> b/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> index 2177381..07c2ab9 100644
>> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> @@ -273,5 +273,5 @@ static void __exit omap_cpufreq_exit(void)
>>
>> =A0MODULE_DESCRIPTION("cpufreq driver for OMAP2PLUS SOCs");
>> =A0MODULE_LICENSE("GPL");
>> -module_init(omap_cpufreq_init);
>> +late_initcall(omap_cpufreq_init);
>> =A0module_exit(omap_cpufreq_exit);
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
