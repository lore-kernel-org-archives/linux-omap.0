From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [GIT PULL] OMAP: mailbox and iommu changes: for-next for v2.6.38
Date: Thu, 2 Dec 2010 09:43:38 -0600
Message-ID: <AANLkTi=01qGO6pX15n_w-W4RaaXsK3u697UQ9pD_DuvW@mail.gmail.com>
References: <AANLkTind+DH5emar2L9EiV-pqpCvQHQGnFevh9Bncrpz@mail.gmail.com>
	<20101202123304.GB10461@n2100.arm.linux.org.uk>
	<AANLkTi=iRUD3_dcY47tebHGbxxAOcY61_2MtSVfO8zQB@mail.gmail.com>
	<20101202152053.GC10461@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47721 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753646Ab0LBPnj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 10:43:39 -0500
Received: by mail-fx0-f54.google.com with SMTP id 16so6291684fxm.13
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 07:43:38 -0800 (PST)
In-Reply-To: <20101202152053.GC10461@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Tony Lindgren <tony@atomide.com>, linux omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 2, 2010 at 9:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 02, 2010 at 08:50:07AM -0600, Guzman Lugo, Fernando wrote=
:
>> On Thu, Dec 2, 2010 at 6:33 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Thu, Dec 02, 2010 at 06:07:23AM -0600, Kanigeri, Hari wrote:
>> >> Hi Tony,
>> >>
>> >> The following changes since commit e8a7e48bb248a1196484d3f8afa53b=
ded2b24e71:
>> >> =A0 Linus Torvalds (1):
>> >> =A0 =A0 =A0 =A0 Linux 2.6.37-rc4
>> >>
>> >> are available in the git repository at:
>> >>
>> >> =A0 git://gitorious.org/iommu_mailbox/iommu_mailbox.git for_2.6.3=
8
>> >>
>> >> Fernando Guzman Lugo (5):
>> >> =A0 =A0 =A0 OMAP: mailbox: change full flag per mailbox queue ins=
tead of global
>> >> =A0 =A0 =A0 omap: iovmm - no gap checking for fixed address
>> >> =A0 =A0 =A0 omap: iovmm - add superpages support to fixed da addr=
ess
>> >> =A0 =A0 =A0 omap: iovmm - replace __iounmap with omap_iounmap
>> >
>> > This change is wrong. =A0Nothing should be directly referencing om=
ap_iounmap
>> > nor for that matter omap_ioremap. =A0Both are implementation detai=
ls of the
>> > standard ioremap/iounmap APIs.
>> >
>> > Use the official APIs rather than the implementation details behin=
d them.
>>
>> if you see where the function is used, you will see that it is not
>> calling the function, it is use as a parameter in unmap_vm_area(), i=
f
>> I used iounmap which is a macro there I will get a compilation error=
=2E
>
> Hmm, yes, because iounmap() is defined as a macro rather than iounmap=
=2E
>
> The solution to this is to fix iounmap and __arch_iounmap macros so
> they aren't macros which take arguments. =A0That will then allow them
> to be used in the way you desire.

yes, that way it can be used in the function parameter. what is the
right thing to do?
1) You send your patch and then I send the new version of the patches.
2) I make a new series of the patches with the change to iounmap and I
include your patch in the series.


Thanks,
=46ernando.

>
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 815efa2..91be1f8 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -245,13 +245,13 @@ extern void _memset_io(volatile void __iomem *,=
 int, size_t);
> =A0#define ioremap_nocache(cookie,size) =A0 __arm_ioremap(cookie, siz=
e, MT_DEVICE)
> =A0#define ioremap_cached(cookie,size) =A0 =A0__arm_ioremap(cookie, s=
ize, MT_DEVICE_CACHED)
> =A0#define ioremap_wc(cookie,size) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__a=
rm_ioremap(cookie, size, MT_DEVICE_WC)
> -#define iounmap(cookie) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0__iounmap(cookie)
> +#define iounmap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0__iounmap
> =A0#else
> =A0#define ioremap(cookie,size) =A0 =A0 =A0 =A0 =A0 __arch_ioremap((c=
ookie), (size), MT_DEVICE)
> =A0#define ioremap_nocache(cookie,size) =A0 __arch_ioremap((cookie), =
(size), MT_DEVICE)
> =A0#define ioremap_cached(cookie,size) =A0 =A0__arch_ioremap((cookie)=
, (size), MT_DEVICE_CACHED)
> =A0#define ioremap_wc(cookie,size) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__a=
rch_ioremap((cookie), (size), MT_DEVICE_WC)
> -#define iounmap(cookie) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0__arch_iounmap(cookie)
> +#define iounmap =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0__arch_iounmap
> =A0#endif
>
> =A0/*
> diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-oma=
p/include/plat/io.h
> index 128b549..204865f 100644
> --- a/arch/arm/plat-omap/include/plat/io.h
> +++ b/arch/arm/plat-omap/include/plat/io.h
> @@ -294,8 +294,8 @@ static inline void omap44xx_map_common_io(void)
> =A0extern void omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t omap_sdrc_params *sdrc_cs1);
>
> -#define __arch_ioremap(p,s,t) =A0omap_ioremap(p,s,t)
> -#define __arch_iounmap(v) =A0 =A0 =A0omap_iounmap(v)
> +#define __arch_ioremap omap_ioremap
> +#define __arch_iounmap omap_iounmap
>
> =A0void __iomem *omap_ioremap(unsigned long phys, size_t size, unsign=
ed int type);
> =A0void omap_iounmap(volatile void __iomem *addr);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
