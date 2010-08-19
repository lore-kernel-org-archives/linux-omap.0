From: Marin Mitov <mitov@issp.bas.bg>
Subject: Re: [RFC] [PATCH 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Thu, 19 Aug 2010 20:25:31 +0300
Message-ID: <201008192025.31660.mitov@issp.bas.bg>
References: <201007180618.08266.jkrzyszt@tis.icnet.pl> <201008191516.21910.mitov@issp.bas.bg> <201008191909.28697.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.issp.bas.bg ([195.96.236.10]:48818 "EHLO mail.issp.bas.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab0HSR1T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 13:27:19 -0400
In-Reply-To: <201008191909.28697.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

On Thursday, August 19, 2010 08:09:27 pm Janusz Krzysztofik wrote:
> Thursday 19 August 2010 14:16:21 Marin Mitov napisa=C5=82(a):
> > On Thursday, August 19, 2010 02:39:47 pm Guennadi Liakhovetski wrot=
e:
> > >
> > > No, I don't think you should go to the next power of 2 - that's t=
oo
> > > crude. Try rounding your buffer size to the page size, that shoul=
d
> > > suffice.
>=20
> Guennadi,
> If you have a look at how a device reserved memory is next allocated =
to a=20
> driver with drivers/base/dma-coherent.c::dma_alloc_from_coherent(), t=
hen than=20
> you may find my conclusion on a power of 2 as true:
>=20
> int dma_alloc_from_coherent(struct device *dev, ssize_t size,
> 					dma_addr_t *dma_handle, void **ret)
> {
> ...
>         int order =3D get_order(size);
> ...
> 	pageno =3D bitmap_find_free_region(mem->bitmap, mem->size, order);
> ...
> }
>=20
>=20
> > Allocated coherent memory is always a power of 2.
>=20
> Marin,
> For ARM, this seems true as long as allocated with the above from a d=
evice=20
> assigned pool, but not true for a (pre)allocation from a generic syst=
em RAM.=20
> See arch/arm/mm/dma-mapping.c::__dma_alloc_buffer(), where it looks l=
ike extra=20
> pages are freed:
>=20
> static struct page *__dma_alloc_buffer(struct device *dev, size_t siz=
e, gfp_t gfp)
> {
> 	unsigned long order =3D get_order(size);
> ...
> 	page =3D alloc_pages(gfp, order);
> ...
> 	split_page(page, order);
>         for (p =3D page + (size >> PAGE_SHIFT), e =3D page + (1 << or=
der); p < e; p++)
>                 __free_page(p);
> ...
> }=09

Thanks for the clarification.

Marin Mitov

>=20
>=20
> Thanks,
> Janusz
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
