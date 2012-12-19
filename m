From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Wed, 19 Dec 2012 10:33:19 +0200
Message-ID: <50D17BCF.1080108@ti.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com> <50ADE6A5.3030001@ti.com> <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com> <50AF37EA.3080400@ti.com> <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com> <50B4A4D7.2070203@ti.com> <CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com> <50B74592.3020308@ti.com> <CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com> <50B771D3.8050907@ti.com> <CAGDS+n=dbuEQgdw9nJ_mYQpuJr5huSgX6e3sBDcvy0+C6T5hFQ@mail.gmail.com> <50B777A3.1080803@ti.com> <CAAwP0s3hYiovSqRfBFDGVQCDVUqYKZrY9QXp+G-R707szdmVqA@mail.gmail.com> <CAAwP0s1JgN4tZjQ74-tmcGyJy9NFf=gPipP3VmqOCKJ6HdmrWg@mail.gmail.com> <CAAwP0s2ks
 E1wbb4Y3k3+_XeR5DLTgOsOAo63arh4f9F942nGdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig27C8AB773471E64571BD5F85"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46292 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752783Ab2LSIdX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 03:33:23 -0500
In-Reply-To: <CAAwP0s2ksE1wbb4Y3k3+_XeR5DLTgOsOAo63arh4f9F942nGdQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

--------------enig27C8AB773471E64571BD5F85
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-12-18 15:45, Javier Martinez Canillas wrote:
> Hi,
>=20
> I've tested with the latest stable kernel (Linux 3.7.1) and the video
> output is working correctly with the same user-space components.
> The complete dmesg is here: http://fpaste.org/1Kv4/
>=20
> Looking at the logs for both kernels I realized that there are two
> differences main between the working (3.7.1) and non-working
> (mainline) kernel (besides the versions of course):
>=20
> a) The number of framebuffers created (working 1, non working 3)
> b) The omapfb now uses dma_alloc_attrs to allocate memory instead of
> the now removed OMAP-specific omap_vram_alloc
>=20
> For a) I built mainline with CONFIG_FB_OMAP2_NUM_FBS=3D1 and that made
> the error about the overlay paddr being zero disappear (OVERLAY error:
> check_overlay: paddr cannot be 0) but still no video on the screen.

Ok. I think the reason for that is that the paddr errors come from X
trying to setup the video overlays with paddr 0. The video overlays are
by default on fb1 and fb2, so they are not present if you set the
NUM_FBS to 1.

> Conversely I build 3.7.1 with CONFIG_FB_OMAP2_NUM_FBS=3D3 and even
> though I had the paddr can't be zero error, video is working
> correctly. So it seems that error shouldn't affect the video display.

Hmm, so do you get any display with 3.8, before X is started, using
plain fb? For example, break the boot before X is started, and do

cat /dev/urandom > /dev/fb0

Do you have an userspace image I could download to reproduce this?

> For b) I tried to built mainline with CONFIG_CMA=3Dy but it didn't work=
 either.

I don't think the vram change affects this, except if you see errors
about mem alloc. But yes, I think you should enable CMA with 3.8,
although allocation may work fine for smaller displays even without CMA.

 Tomi



--------------enig27C8AB773471E64571BD5F85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQ0XvPAAoJEPo9qoy8lh71SuEP/1mDAYcV2ThovTdVH2CFZvNq
32l+uXic30zNBP7wKzvMcnje2uUrRhr8ttgoYnGDgpD5N2wwkiHnU0pdakHsyuui
3aBytcJMt2/Bx1koWRonPKdFs2JlyPqE2ZttgQIb7d0842YoeePYI6PmwdEcdp4o
4Mx2dBepbLNlMx8rnwviMERe0hJgS93R/zF8O7NVrp0s5u2Rf7pqW5dLyhybB00u
e6dCKpPksHrHHA+GMjPTYtg+laFnfqvlR0OO2Sk+M5yFu/bK2l5ycTJeqHolq9if
Mfo2OWE8mEjkzZzARW9yb0COw6qFd5EyDJQCKsoYGdHH0Qc9FglT1It2957Vk5XW
8pl3hGEMHjORJZ30OHEmRa4xIGZTomTqlhr+VgxU8A4wk0Yya/rja6nw1rcfllpc
DNGsOKLyvvblkEJfIRTlZzeghaXEwvJxxpRNvfobp+y2C4i9mlX4Z7i9QnAHgt8z
xhbGisJjfiHj3h1K2d/zP4fqFWZ1t1nbNwBb4fxgKOcT33whWvHqJWXydvWrPGDV
IEQLBvhhni4DvkF3LGEOHVOTzQqGs4zQm+Vfx2dAbVlrq/dfdZT21aArk0Q9eBCo
FguW4xX788q9n2KR1PE1KACSMo/HWzMAH25FjCF1pt4U0HlCSruTKKn74vxfEa6Q
iWSyR3tyWFEEAq5NcaLn
=NTSO
-----END PGP SIGNATURE-----

--------------enig27C8AB773471E64571BD5F85--
