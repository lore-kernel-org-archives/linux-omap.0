From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: SMP local timers and their CPUfreq notifiers setup on OMAP3
Date: Tue, 21 Feb 2012 14:56:07 +0530
Message-ID: <CAMQu2gzmTrODAks68o0cWF99sMenLRGjT-YTNUOOmAc3jAfvxQ@mail.gmail.com>
References: <8739aahc0n.fsf@ti.com> <4F3E0655.2040702@ti.com>
 <0401fed02a58f7bc48cc274050adbac7@localhost> <CAMQu2gwW6ES14jB8E6snE4pQRKg1q2ZF0pBedBtuPxeYV+7cow@mail.gmail.com>
 <4F3E34A3.4000307@arm.com> <4F3E47F2.2090400@ti.com> <20120221091124.GB22675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:43049 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753047Ab2BUJ02 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 04:26:28 -0500
Received: by mail-qw0-f48.google.com with SMTP id h8so7991920qau.0
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 01:26:27 -0800 (PST)
In-Reply-To: <20120221091124.GB22675@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Feb 21, 2012 at 2:41 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 17, 2012 at 05:58:34PM +0530, Santosh Shilimkar wrote:
>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index 4285daa..9834851 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb =3D =
{
>>
>> =A0static int twd_cpufreq_init(void)
>> =A0{
>> - =A0 =A0 if (!IS_ERR(twd_clk))
>> + =A0 =A0 =A0if (twd_evt && *__this_cpu_ptr(twd_evt) && !IS_ERR(twd_=
clk))
>
> You seem to have an additional space before 'if'.
Yep.
=46ixed in the updated version in patch system.
patch 7336/1

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
