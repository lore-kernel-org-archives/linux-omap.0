From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/2] omap3: iovmm: Work around sg_alloc_table size
 limitation in IOMMU
Date: Fri, 3 Jun 2011 12:39:27 +0300
Message-ID: <BANLkTingi0kS6MpqGNd0RJtAcY40Rz0DRw@mail.gmail.com>
References: <20110601131744.GH11352@atomide.com>
	<201106011550.50873.laurent.pinchart@ideasonboard.com>
	<20110601140306.GC6700@n2100.arm.linux.org.uk>
	<201106030212.48226.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53824 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab1FCJj3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 05:39:29 -0400
Received: by bwz15 with SMTP id 15so1612806bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 02:39:28 -0700 (PDT)
In-Reply-To: <201106030212.48226.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <fernando.lugo@ti.com>

On Fri, Jun 3, 2011 at 3:12 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Russell,
>
> On Wednesday 01 June 2011 16:03:06 Russell King - ARM Linux wrote:
>> On Wed, Jun 01, 2011 at 03:50:50PM +0200, Laurent Pinchart wrote:
>> > In the specific iovmm case, the driver uses the sglist API to buil=
d a
>> > list of page-size sg entries, and then process it in software. Is =
that
>> > considered as an abuse of the sglist API, or valid usage ?
>> >
>> > Anyway, sglist chaining is not needed by iovmm. As iovmm just walk=
s the
>> > sglist manually, it's easier to allocate it in one go rather than =
using
>> > sglist chaining. This of course doesn't make your patch unneeded o=
r
>> > wrong.
>>
>> Well, there's a two issues here:
>> 1. Should iovmm use sg_phys(sg) with sg_dma_len(sg) ?
>> =C2=A0 =C2=A0Probably not, because a scatterlist before DMA API mapp=
ing is defined
>> =C2=A0 =C2=A0by sg_page(sg), sg->offset, sg->length and has N entrie=
s. =C2=A0After DMA
>> =C2=A0 =C2=A0API mapping (n =3D dma_map_sg(dev, sg, N, dir)), it has=
 n entries where
>> =C2=A0 =C2=A0n <=3D N, and the DMA address/lengths are sg_dma_addres=
s(sg) and
>> =C2=A0 =C2=A0sg_dma_len(sg). =C2=A0Both these are undefined for unma=
pped scatterlists.
>>
>> =C2=A0 =C2=A0Getting this wrong means breakage when CONFIG_NEED_SG_D=
MA_LENGTH is
>> =C2=A0 =C2=A0enabled.
>
> iovmm abuses the sglist API, there's no doubt on that. It will break =
when
> CONFIG_NEED_SG_DMA_LENGTH is enabled. iovmm should probably not use t=
he sglist
> API, and it should probably not even exist in the first place. I know=
 that TI
> is working on moving the OMAP-specific iommu/iovmm implementation to =
the
> generic IOMMU API, but that will take time. In the meantime, I'd like=
 to fix
> iovmm to avoid the userspace-triggerable BUG_ON().

This would also allow the tidspbridge driver to use iommu.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
