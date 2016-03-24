From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 02/23] ARM: dts: n950: add display support
Date: Thu, 24 Mar 2016 15:26:52 +0100
Message-ID: <20160324142652.GA25083@earth>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <1457455195-1938-3-git-send-email-sre@kernel.org>
 <21766689.NesyW3QHk4@avalon>
 <20160317174901.GB3864@earth>
 <87lh59pdt6.fsf@intel.com>
 <20160323140105.GA31703@earth>
 <87h9fwdwh6.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87h9fwdwh6.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 24, 2016 at 12:03:01PM +0200, Jani Nikula wrote:
> On Wed, 23 Mar 2016, Sebastian Reichel <sre@kernel.org> wrote:
> > On Wed, Mar 23, 2016 at 02:40:53PM +0200, Jani Nikula wrote:
> >> On Thu, 17 Mar 2016, Sebastian Reichel <sre@kernel.org> wrote:
> >> > On Thu, Mar 17, 2016 at 02:14:26PM +0200, Laurent Pinchart wrote:
> >> >> [...]
> >> >> > +
> >> >> > +		/* panel is 480x464 with top and bottom 5 lines not visible */
> >> >>=20
> >> >> I assume you mean 480x864 ?
> >> >
> >> > Yes, nice catch. Basically the screen is 480x864, but only
> >> > 480x854 are visible.
> >>=20
> >> It's been a while, but I thought the full 480x864 was actually usable
> >> and visible.
> >
> > I tried that first and the first few lines were missing. The stock
> > kernel also uses only 854px:
> >
> > https://github.com/nemomobile/kernel-adaptation-n950-n9/blob/mer-n9-2.6=
=2E32-20121301/arch/arm/mach-omap2/board-rm680-video.c
> >
> > (search for partial_area)
>=20
> Heh, I was reminded by old colleagues that it was actually my commit
> back in the day that changed the resolution 864->854 in the stock
> kernel. And that I did it reluctantly, because there really was no
> technical reason to do the change.
>=20
> I don't really care all that much either way anymore. I just thought
> you'd like to get those 4800 pixels back that you've been missing all
> these years. Plus 864 was nicer to deal with because it has 2^5 as a
> prime factor while 854 only has 2.

As I said: I did use 864 initially. That results in missing pixels.
This is what I observed before switching to 854:

In fbcon the first line was rendered half (only the bottom part of
each character was visible). Then, when I rotated fbcon (fbcon has
native rotation support, which does not work with DRM, but just
renders the text differently), the left part of each character was
missing. In my case the "[" prefix of kernel messages was rendered
as two dots. At least the vertical line was not visible at all.

I _think_, that your HW team decided to cover the first and the
last few pixels of the 864 display with plastic. So technically
it's a 864 display, but effectively it's 854.

-- Sebastian

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW8/knAAoJENju1/PIO/qajhgP/1iOxrrWhAo8lR6HkSI+Qnqk
JZJYZVN3N2nTdZ3hIKSbs85q97yY3obn2yYGZiN53L20n1UKX+hpv6LmVlDXEKz8
0SMpjwzafXNFvkKMtzVMYsr8pAySYZISocc1sNiivRxqmQGMVEKq190FxI4zveUZ
WnC3quUUaV7NQySKCxYYc3GIiPOEcNHAmIqutzGfnhRkfhAUtoYatBF17xVhcLfX
wgX8u0gLmbvjOUAQnuN3tvJ88I/OU1hCTj37B2F2BMFyKSINJzFfMVCWx47jn7Uo
KLh7xZIgcrTy88VvgN64QdoCZi6c7+MEqYxl/Fe5WuP2KR/YZUaeYhAKIwPaa1KR
qmqPa4+u/aBpbbZLM3vSuFLTm/YXAeNyFNm8si3BATn2aPSxP3SFLoUE3L7US7Ro
adxelcsktobZO2VnT8GNxEhyF3BESbSwVF/zo4gtG/qsmuxPDLOrDa8kCnWBMOto
987lBtvb47og3ewC/1IABEDyZhenPgmhZYwyoQ2NSWcpgf9nxNE1Hz+v2ju032V9
QcGd2PIeo2ozIIiV7XQzxOAojePZLZ0nueeomdAcfVeWHC1FdrWstc25zf+q42Ie
cqWbcCtbnvSQl8ijAzEs2QHjUd+nmodwNTxYCtJzRjXomeDzjiuVjBfqDSRMxyql
/qaBW2DPtDBv/Y1a+tDd
=qJb0
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
