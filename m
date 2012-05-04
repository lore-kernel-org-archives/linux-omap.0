From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/7] ARM: OMAP: dma: Make use of cpu_class_is_omap2() to
 avoid future patching.
Date: Fri, 4 May 2012 12:34:23 +0530
Message-ID: <CAMQu2gxjEFK3p9CZ0i3ACWTGTQSM6ywMCWUQJg7PMyh2avvL=w@mail.gmail.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
 <1335952093-12541-5-git-send-email-santosh.shilimkar@ti.com> <8762cdgcmu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33728 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752067Ab2EDHEp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 03:04:45 -0400
Received: by qaea16 with SMTP id a16so1082908qae.10
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 00:04:44 -0700 (PDT)
In-Reply-To: <8762cdgcmu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Fri, May 4, 2012 at 3:17 AM, Kevin Hilman <khilman@ti.com> wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> cpu_class_is_omap2() contains all OMAP2+ devices. So update the DMA =
code
>> cpu checks accordingly so that there is no need to patch
>> the file for any future OMAP2+ devices.
>>
>> In long run, all these attributes should come from hwmod dev_attr ba=
sed
>> on DMA IP version.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/dma.c | =A0 =A02 +-
>> =A0arch/arm/plat-omap/dma.c =A0| =A0 =A04 ++--
>> =A02 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
>> index b19d849..2750bb9 100644
>> --- a/arch/arm/mach-omap2/dma.c
>> +++ b/arch/arm/mach-omap2/dma.c
>> @@ -227,7 +227,7 @@ static int __init omap2_system_dma_init_dev(stru=
ct omap_hwmod *oh, void *unused)
>>
>> =A0 =A0 =A0 dma_stride =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP2_DMA_STRI=
DE;
>> =A0 =A0 =A0 dma_common_ch_start =A0 =A0 =3D CSDP;
>> - =A0 =A0 if (cpu_is_omap3630() || cpu_is_omap44xx())
>> + =A0 =A0 if (omap_rev() >=3D OMAP3630_REV_ES1_0)
>
> It's not obvious (at least to me) that this is equivalent.
>
> For example, this will now be true on the TI81xx devices.
>
I see your point.
On second thought, i decided to drop this hunk from the patch since
the availability of the dma descriptor feature can be read from dma
capability register. Will post another patch for it and also add it to
the clean-up series.

Updated $subject patch in the end of email.

Regards
Santosh

=46rom e42966bc56b1603e033b5b259564ae149b11a5d9 Mon Sep 17 00:00:00 200=
1
=46rom: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sat, 28 Apr 2012 20:19:10 +0530
Subject: [PATCH 4/7] ARM: OMAP: dma: Make use of cpu_class_is_omap2() t=
o
 avoid future patching.

cpu_class_is_omap2() contains all OMAP2+ devices. So update the DMA cod=
e
cpu checks accordingly so that there is no need to patch
the file for any future OMAP2+ devices.

In long run, all these attributes should come from hwmod dev_attr based
on DMA IP version.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Dropped the hunk for descriptor feature check based on OMAP cpu
version since it can be handled with DMA hardware capability
register read.

 arch/arm/plat-omap/dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index ecdb3da..c046a19 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -843,7 +843,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read_p=
rio,
 	}
 	l =3D p->dma_read(CCR, lch);
 	l &=3D ~((1 << 6) | (1 << 26));
-	if (cpu_is_omap2430() || cpu_is_omap34xx() ||  cpu_is_omap44xx())
+	if (cpu_class_is_omap2() && !cpu_is_omap242x())
 		l |=3D ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
 	else
 		l |=3D ((read_prio & 0x1) << 6);
@@ -2057,7 +2057,7 @@ static int __devinit
omap_system_dma_probe(struct platform_device *pdev)
 		}
 	}

-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx())
+	if (cpu_class_is_omap2() && !cpu_is_omap242x())
 		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
 				DMA_DEFAULT_FIFO_DEPTH, 0);

--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
