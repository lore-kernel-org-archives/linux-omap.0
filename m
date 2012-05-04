From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/7] ARM: OMAP: dma: Make use of cpu_class_is_omap2() to avoid future patching.
Date: Fri, 04 May 2012 09:46:17 -0700
Message-ID: <87txzvc2sm.fsf@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
	<1335952093-12541-5-git-send-email-santosh.shilimkar@ti.com>
	<8762cdgcmu.fsf@ti.com>
	<CAMQu2gxjEFK3p9CZ0i3ACWTGTQSM6ywMCWUQJg7PMyh2avvL=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58672 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754009Ab2EDQqR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 12:46:17 -0400
Received: by pbbrq13 with SMTP id rq13so4368493pbb.36
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 09:46:14 -0700 (PDT)
In-Reply-To: <CAMQu2gxjEFK3p9CZ0i3ACWTGTQSM6ywMCWUQJg7PMyh2avvL=w@mail.gmail.com>
	(Santosh Shilimkar's message of "Fri, 4 May 2012 12:34:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Fri, May 4, 2012 at 3:17 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> cpu_class_is_omap2() contains all OMAP2+ devices. So update the DMA=
 code
>>> cpu checks accordingly so that there is no need to patch
>>> the file for any future OMAP2+ devices.
>>>
>>> In long run, all these attributes should come from hwmod dev_attr b=
ased
>>> on DMA IP version.
>>>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/dma.c | =C2=A0 =C2=A02 +-
>>> =C2=A0arch/arm/plat-omap/dma.c =C2=A0| =C2=A0 =C2=A04 ++--
>>> =C2=A02 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
>>> index b19d849..2750bb9 100644
>>> --- a/arch/arm/mach-omap2/dma.c
>>> +++ b/arch/arm/mach-omap2/dma.c
>>> @@ -227,7 +227,7 @@ static int __init omap2_system_dma_init_dev(str=
uct omap_hwmod *oh, void *unused)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 dma_stride =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=3D OMAP2_DMA_STRIDE;
>>> =C2=A0 =C2=A0 =C2=A0 dma_common_ch_start =C2=A0 =C2=A0 =3D CSDP;
>>> - =C2=A0 =C2=A0 if (cpu_is_omap3630() || cpu_is_omap44xx())
>>> + =C2=A0 =C2=A0 if (omap_rev() >=3D OMAP3630_REV_ES1_0)
>>
>> It's not obvious (at least to me) that this is equivalent.
>>
>> For example, this will now be true on the TI81xx devices.
>>
> I see your point.
> On second thought, i decided to drop this hunk from the patch since
> the availability of the dma descriptor feature can be read from dma
> capability register. Will post another patch for it and also add it t=
o
> the clean-up series.
>
> Updated $subject patch in the end of email.
>
> Regards
> Santosh
>
> From e42966bc56b1603e033b5b259564ae149b11a5d9 Mon Sep 17 00:00:00 200=
1
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Sat, 28 Apr 2012 20:19:10 +0530
> Subject: [PATCH 4/7] ARM: OMAP: dma: Make use of cpu_class_is_omap2()=
 to
>  avoid future patching.
>
> cpu_class_is_omap2() contains all OMAP2+ devices. So update the DMA c=
ode
> cpu checks accordingly so that there is no need to patch
> the file for any future OMAP2+ devices.
>
> In long run, all these attributes should come from hwmod dev_attr bas=
ed
> on DMA IP version.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Dropped the hunk for descriptor feature check based on OMAP cpu
> version since it can be handled with DMA hardware capability
> register read.

Right, this looks better.

Thanks,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
