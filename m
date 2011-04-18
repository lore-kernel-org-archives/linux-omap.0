From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
Date: Mon, 18 Apr 2011 21:55:56 +0900
Message-ID: <BANLkTimc20N0nh9O0FaSXizW+bYOMx9Ddw@mail.gmail.com>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<201104180929.33569.arnd@arndb.de>
	<20110418110502.GI12272@atomide.com>
	<201104181358.53521.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57069 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab1DRMz6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 08:55:58 -0400
In-Reply-To: <201104181358.53521.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 18, 2011 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 18 April 2011, Tony Lindgren wrote:
>> * Arnd Bergmann <arnd@arndb.de> [110418 10:26]:
>> > On Friday 15 April 2011, Russell King - ARM Linux wrote:
>> > > On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo w=
rote:
>> > > > From: Ramesh Gupta <grgupta@ti.com>
>> > > >
>> > > > This patch is to flush the iommu page table entries from L1 an=
d L2
>> > > > caches using dma_map_single. This also simplifies the implemen=
tation
>> > > > by removing the functions =A0flush_iopgd_range/flush_iopte_ran=
ge.
>> > >
>> > > No. =A0This usage is just wrong. =A0If you're going to use the D=
MA API then
>> > > unmap it, otherwise the DMA API debugging will go awol.
>> >
>> >
>> > It's also completely upside-down: The iommu support should provide=
 interfaces
>> > using the dma-mapping API, not use that API to provide a machine s=
pecific
>> > version of the generic interface.
>> >
>> > As far as I can tell, nothing actually uses these drivers, maybe w=
e should just
>> > remove them before we get any code in the mainline kernel that dep=
ends on it.
>>
>> There is drivers/media/video/omap3isp/isp.c.
>
> Ah, I didn't see that, was looking at an older version.
>
>> But if we now have a generic replacement for this code we should sta=
rt
>> using it.
>
> To give some background:
>
> Historically, the dma-mapping API has been used for all IOMMUs on
> architectures that need it. This interface is rather flexible,
> but ARM currently only uses it for managing static mappings.
> One thing that it cannot do is mapping memory to an arbitrary
> (driver-chosen) bus address. The generic iommu API was added in order
> to do that, and is mostly used for virtual machines with KVM.
>
> The MSM platform in ARM also added support for the generic iommu
> API, and now the exynos4 is gaining support for it as well.

You can find a exynos4 patches.
http://comments.gmane.org/gmane.linux.drivers.video-input-infrastructur=
e/31613

>
> One missing piece is still a way for a platform to provide both
> the iommu and the dma-mapping API in a unified driver. Right now,
> you have to export both interface for a generic solution.

Actually MSM and we (Michal, Marek) tried to merge the generic IOMMU
implementation into mm, but MM did't accept it.
So now it's implemented at each SoCs. I think it's good chance to make
a generic IOMMU feature for ARM consolidation.

>
> On ARM, we don't yet use include/asm-generic/dma-mapping-common.h,
> which allows overriding the dma-mapping API per device. This would
> have to change if you want to export the IOMMU functionality using
> the dma-mapping API, but that would also allow abstracting the
> various ways we currently have (dmabounce, swiotlb, linear map,
> custom __arch_page_to_dma, iommu, coherent or noncoherent DMA)
> in a nicer way per device.

Before this idea, can you review our implementation at above URL?

Thank you,
Kyungmin Park
>
> =A0 =A0 =A0 =A0Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
