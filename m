From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: RE: Converting OMAP's custom vram allocator
Date: Fri, 07 Sep 2012 13:54:52 +0300
Message-ID: <1347015292.2646.23.camel@deskari>
References: <1346839733.32747.1.camel@deskari>
	 <019b01cd8cbd$6fef8c50$4fcea4f0$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-AqnKlGBSrmjedGaYNTYu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:36882 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760269Ab2IGKy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 06:54:58 -0400
Received: by lbbgj3 with SMTP id gj3so1782959lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 03:54:55 -0700 (PDT)
In-Reply-To: <019b01cd8cbd$6fef8c50$4fcea4f0$%szyprowski@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Rob Clark <rob@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, 'linux-omap' <linux-omap@vger.kernel.org>


--=-AqnKlGBSrmjedGaYNTYu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-07 at 07:55 +0200, Marek Szyprowski wrote:
> Hello,
>=20
> On Wednesday, September 05, 2012 12:09 PM Tomi Valkeinen wrote:
>=20
> > OMAP has a custom video ram allocator, which I'd like to remove and use
> > the standard dma allocation functions.
> >=20
> > There are two problems for which I'd like to hear suggestions or
> > comments:
> >=20
> > First one is that the dma_alloc_* functions map the allocated memory fo=
r
> > cpu use. In many cases with OMAP DSS (display subsystem) this is not
> > needed: the memory may be written only by the SGX or the DSP, and it's
> > only read by the DSS, so it's never touched by the CPU.
> >=20
> > This is even more true when using VRFB on omap3 (and probably TILER on
> > omap4) for rotation, as VRFB hides the actual memory and offers rotated
> > views. In this case the backend memory is never accessed by anyone else
> > than VRFB.
> >=20
> > Is there a way to allocate the memory without creating a mapping? While
> > it won't break anything as such, the allocated areas can be quite large
> > thus causing large areas of the kernel's memory space to be needlessly
> > reserved.
>=20
> Please check commits d5724f172fd1 and 955c757e090 merged to v3.6-rc1.=20
> Support for this attribute is now only available in IOMMU-aware=20
> dma-mapping implementation, but I plan to add it also to standard linear
> ARM dma-mapping implementation based on alloc_pages_exact().

Ok, good to know. Do you have any guestimate when the non-iommu version
could end up in the mainline? Any chance for 3.7? I volunteer for
testing if needed =3D).

> Some not-well-documented example can be found here:=20
> https://patchwork.kernel.org/patch/1323591/ (at the bottom).
>=20
> You probably might need to add your own custom dma_map_ops set of functio=
ns
> for TILER device, but I'm not really sure if I get right what does that=
=20
> device do and what will be the use cases for it.

I think we have three different cases how we need to manage the memory
used for video on OMAP.

1) Conventional case, without VRFB/TILER. We need large contiguous
areas. I think we usually want both normal kernel and userspace mapping
in this case, although some use cases could not need those.

2) VRFB (omap3). In this case we need large contigous area, which is
given to the VRFB hardware to be used as a storage. This area is never
mapped. VRFB offers four rotated "views" (i.e. memory areas), which give
a 0/90/180/270 degree view of the same image, and we will create mapping
of these views with ioremap. The actual data is stored in the memory by
VRFB in a proprietary format.

3) TILER (omap4). I'm not too familiar with TILER, but afaik it's kinda
like a better version of VRFB. In this case we don't need contiguous
memory, but like VRFB, we never create mapping for the memory. (Rob,
correct me if I'm wrong).

I think we can manage all of those with dma_alloc_attrs(), even though
contiguous area is not really needed for TILER.

So, if I define DMA_ATTR_NO_KERNEL_MAPPING, there's no point in defining
DMA_ATTR_WRITE_COMBINE at the same time, right?

Can I still create the kernel mapping for the allocated memory later,
yielding the same result as if I would've omitted
DMA_ATTR_NO_KERNEL_MAPPING?

> > The second case is passing a framebuffer address from the bootloader to
> > the kernel. Often with mobile devices the bootloader will initialize th=
e
> > display hardware, showing a company logo or such. To keep the image on
> > the screen when kernel starts we need to reserve the same physical
> > memory area early at boot, and use that for the framebuffer.
> >=20
> > I'm not sure if there's any actual problem with this one, presuming
> > there is a solution for the first case. Somehow the memory is reserved
> > at early boot time, and this is passed to the fb driver. But can the
> > memory be managed the same way as in normal case (for example freeing
> > it), or does it need to be handled as a special case?
>=20
> The only solution I see here is to use custom coherent memory pool for th=
e
> framebuffer device and setup it starting from the physical address of the
> framebuffer configured by bootloader. See dma_declare_coherent() function=
.
> Some usage example on ARM architecture can be found in=20
> arch/arm/plat-samsung/s5p-dev-mfc.c
>=20
> The other possibility is to enable Contiguous Memory Allocator and define
> a custom contiguous memory area for framebuffer device at the same=20
> physical address as configured by bootloader:
> http://git.linaro.org/gitweb?p=3Dpeople/mszyprowski/linux-archive.git;a=
=3Dcommitdiff;h=3Df8ff4f99cfa4f67e09a3c948e007e82a0c21434a
>=20
> Feel free to comment both possibilities, maybe we can work out something
> better for solving this quite common use case.

I think CMA is definitely the way to go.

But I'm not quite sure how it should be used in this case. I understand
how to reserve the memory area at boot time, as the patch in your link
shows, but how should the driver get the memory?

Normally the driver would just use dma_alloc_*, and the reserved CMA
area would be used automatically, right? But in this case we want to get
the allocation from a particular physical address of the private area.

 Tomi


--=-AqnKlGBSrmjedGaYNTYu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQSdJ8AAoJEPo9qoy8lh71fx0P/3i7JCiLeTodkxnhnwZzsk2S
+bjXV+ar2hgVEkYHBaPxUN5ebwLOZP1qr5K4p6sO9OdF0lTFEBkaeAaRdDUz86Q6
zZwo7WzE7/Qzc56UtJupvrxlQ0eE2HDglOEvMSdLtjmAoY7ewbcC4mp+2mEX54fA
gZdlzJ3bM3vdGoSKj/PZedZdmlxR8W1AG5CRcUygHyz+zykdjupc0fL8Y9nME5OK
Wd9CLNEAYoTJAlp5pY8C41KqU4Jr3hATExHYMeldF0C+6r153264rXgKGs8N6Kvz
fpkePr1Zx0x8tXv3l5/+8lGGuG9EoELI35iWBpbj7SUxoGhOSP1hsQYmzfGwFzul
ySpoC4mebSL3hQ+qdTg9gaOSER212jIGWp6cWuu1t+GDRJjmYeVD1PuPxQN2zljI
Jiz3QVmfmMIzYIjJcYs0QUme/dyhBD9bYhRMU8qVdymOZHNnrfRPf1TkWv6BuDHX
UevlyFMW28JYNnhGRwSEnnBJyLFoAE2SWwesgOSAkunamWsxdB0UPALpc0M5PPUU
zd39hc7CQsBkWnyZfpv4w3cfYKTPNWR0/Dhb7neaCeS7RtFlX/Lq9I3YKZI7WPI9
Hxd2e9brR36FwkJRwasXJK+UYlDJEMu04u2VDuor8jQ7WAh/Rxn60FkzRk23dhJj
inGMvOthZG9xnV1vOwRU
=l/IQ
-----END PGP SIGNATURE-----

--=-AqnKlGBSrmjedGaYNTYu--

