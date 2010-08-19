From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC] [PATCH 1/6] SoC Camera: add driver for OMAP1 camera interface
Date: Thu, 19 Aug 2010 19:09:27 +0200
Message-ID: <201008191909.28697.jkrzyszt@tis.icnet.pl>
References: <201007180618.08266.jkrzyszt@tis.icnet.pl> <Pine.LNX.4.64.1008191336290.26145@axis700.grange> <201008191516.21910.mitov@issp.bas.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201008191516.21910.mitov@issp.bas.bg>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: Marin Mitov <mitov@issp.bas.bg>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>
List-Id: linux-omap@vger.kernel.org

Thursday 19 August 2010 14:16:21 Marin Mitov napisa=C5=82(a):
> On Thursday, August 19, 2010 02:39:47 pm Guennadi Liakhovetski wrote:
> >
> > No, I don't think you should go to the next power of 2 - that's too
> > crude. Try rounding your buffer size to the page size, that should
> > suffice.

Guennadi,
If you have a look at how a device reserved memory is next allocated to=
 a=20
driver with drivers/base/dma-coherent.c::dma_alloc_from_coherent(), the=
n than=20
you may find my conclusion on a power of 2 as true:

int dma_alloc_from_coherent(struct device *dev, ssize_t size,
					dma_addr_t *dma_handle, void **ret)
{
=2E..
        int order =3D get_order(size);
=2E..
	pageno =3D bitmap_find_free_region(mem->bitmap, mem->size, order);
=2E..
}


> Allocated coherent memory is always a power of 2.

Marin,
=46or ARM, this seems true as long as allocated with the above from a d=
evice=20
assigned pool, but not true for a (pre)allocation from a generic system=
 RAM.=20
See arch/arm/mm/dma-mapping.c::__dma_alloc_buffer(), where it looks lik=
e extra=20
pages are freed:

static struct page *__dma_alloc_buffer(struct device *dev, size_t size,=
 gfp_t gfp)
{
	unsigned long order =3D get_order(size);
=2E..
	page =3D alloc_pages(gfp, order);
=2E..
	split_page(page, order);
        for (p =3D page + (size >> PAGE_SHIFT), e =3D page + (1 << orde=
r); p < e; p++)
                __free_page(p);
=2E..
}=09


Thanks,
Janusz
