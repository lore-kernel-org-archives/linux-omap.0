From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 3/7] arm: perf: support device with other non-irq resources
Date: Tue, 25 Oct 2011 09:09:22 +0800
Message-ID: <CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-4-git-send-email-ming.lei@canonical.com>
	<20111024150814.GA4771@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57981 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137Ab1JYBJZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Oct 2011 21:09:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RIVW8-00089C-1m
	for linux-omap@vger.kernel.org; Tue, 25 Oct 2011 01:09:24 +0000
Received: by ywm3 with SMTP id 3so2067957ywm.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Oct 2011 18:09:23 -0700 (PDT)
In-Reply-To: <20111024150814.GA4771@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

Hi,

On Mon, Oct 24, 2011 at 11:08 PM, Will Deacon <will.deacon@arm.com> wro=
te:
> Hi Ming Lei,
>
> On Mon, Oct 24, 2011 at 03:45:55PM +0100, ming.lei@canonical.com wrot=
e:
>> From: Ming Lei <ming.lei@canonical.com>
>>
>> omap4 may create device via hwmod, which can create resources
>> automatically, so may include some non-irq resources.
>>
>> This patch supports device with other non-irq resources.
>
> I'd rather not do this in the Perf code since we're essentially deali=
ng with
> an artifact of the hwmod -> platform_device conversion.
>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>> =A0arch/arm/kernel/perf_event.c | =A0 =A05 +++--
>> =A0arch/arm/kernel/pmu.c =A0 =A0 =A0 =A0| =A0 12 ++++++++++--
>> =A02 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_eve=
nt.c
>> index f367780..d91dba2 100644
>> --- a/arch/arm/kernel/perf_event.c
>> +++ b/arch/arm/kernel/perf_event.c
>> @@ -19,6 +19,7 @@
>> =A0#include <linux/platform_device.h>
>> =A0#include <linux/spinlock.h>
>> =A0#include <linux/uaccess.h>
>> +#include <linux/cpumask.h>
>>
>> =A0#include <asm/cputype.h>
>> =A0#include <asm/irq.h>
>> @@ -414,7 +415,7 @@ armpmu_reserve_hardware(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 for (i =3D 0; i < pmu_device->num_resources; ++i) {
>> + =A0 =A0 for (i =3D 0; i < nr_cpu_ids; ++i) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D platform_get_irq(pmu_device, i);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irq < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>
> Hmm, I actually changed this code recently. Take a look:
>
> https://github.com/wdeacon/linux-wd/blob/perf/system-pmus/arch/arm/ke=
rnel/perf_event.c
>
> This should all be in for 3.2-rc1, so you can rebase then. If you sti=
ll have
> hwmod issues, please solve them outside of perf_event.c

Looks your patch has solved the problem, so the patch is not needed
any more.

I will try to rebase the patchset on your tree first.

>> diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
>> index c53474f..0e9c908 100644
>> --- a/arch/arm/kernel/pmu.c
>> +++ b/arch/arm/kernel/pmu.c
>> @@ -19,6 +19,7 @@
>> =A0#include <linux/module.h>
>> =A0#include <linux/of_device.h>
>> =A0#include <linux/platform_device.h>
>> +#include <linux/cpumask.h>
>
> 'fraid I've changed this file too!
>
> https://github.com/wdeacon/linux-wd/blob/perf/system-pmus/arch/arm/ke=
rnel/pmu.c
>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
