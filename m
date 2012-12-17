From: Felipe Balbi <balbi@ti.com>
Subject: Re: MUSB-HDRC Gadget driving VBUS inappropriately
Date: Mon, 17 Dec 2012 18:13:03 +0200
Message-ID: <20121217161302.GD22943@arwen.pp.htv.fi>
References: <C3E8C797-AE49-4638-B41B-B3AE180D3426@gmail.com>
 <CANOLnONT=dFx581WFRn_b9Q=ngJpfzx+A56b-7po4xVZVqisyw@mail.gmail.com>
 <20121214121319.GB16600@arwen.pp.htv.fi>
 <CACqpBg54RfyyLA-seGegLX0uGpfDDX3GueyFhe12C0OU8N_6oQ@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33707 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179Ab2LQQUU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 11:20:20 -0500
Content-Disposition: inline
In-Reply-To: <CACqpBg54RfyyLA-seGegLX0uGpfDDX3GueyFhe12C0OU8N_6oQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ian coolidge <iancoolidge@gmail.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-usb@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, felipe.contreras@gmail.com, icoolidge@trellisware.com

--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2012 at 05:38:10PM -0800, ian coolidge wrote:
> Felipe, Tony, Grazvydas, Thanks for the responses,
>=20
> On Fri, Dec 14, 2012 at 4:13 AM, Felipe Balbi <balbi@ti.com> wrote:
>=20
> > Hi,
> >
> > On Fri, Dec 14, 2012 at 02:13:07PM +0200, Grazvydas Ignotas wrote:
> > > On Fri, Dec 14, 2012 at 11:53 AM, Ian Coolidge <iancoolidge@gmail.com>
> > wrote:
> > > > we find that with about a 2% chance, the gadget comes up in some ki=
nd
> > of firmware failed state, driving VBUS.
> > > > In this condition, we found that MUSB_DEVCTL_SESSION bit was set.
> > > > I understand this to be indicative of MUSB thinking it is in host
> > mode, which agrees with the driven VBUS.
> > > > Further, in this state, I found that usually, there was one interru=
pt
> > from twl4030_usb, but NO interrupts from musb-hdrc.
> > >
> > > I'm also also often seeing this and don't know any workaround except
> > > powercycling the board :(
> > > This was kind or relieved for me after I changed it to deinit musb on
> > > shutdown/reset (3.3 should have that patch merged), however if you
> > > randomly reset the board, there is still something like 30-50% chance
> > > musb will come up dead, and on proper reset it's still something like
> > > 5% chance like you reported.
> >
> > hehe, then you should've reported earlier :-)
> >
> > Anyway, I really think this has something to do with some bogus
> > set_vbus() calls.
> >
> > Likely that looking at probe() path for checks for MUSB_DEVCTL_VBUS will
> > probably show you something which is wrong. Maybe the driver is assuming
> > that if VBUS bitfield is zero, then it kicks host side, or something.
> >
> > Go over that part of the code and you probably will find something.
> >
> > --
> > balbi
> >
>=20
> So, I did some more testing, just printing out MUSB_DEVCTL each time. At
> omap2430.c "init",
> musb_probe()->musb_init_controller()->omap2430_musb_init(),
> I always saw 0x80. This corresponds to MUSB_DEVCTL_BDEVICE.
> It appears, then, that the MUSB is initialized correctly, but becomes bad
> somehow. I'll continue to dig into this, but it would be nice to have some
> simple abstract description of what the SESSION bit actually does here.
> It's used as both an input and an output throughout the MUSB Linux driver,
> and judging by comments, appears to have different behavior in different
> configurations. Felipe?

Session bit, really means a session, a USB session. It has different
meanings (to some extent) when working with Host or Gadget. For Gadget
mode, the session bit also triggers SRP, on host mode, maybe it's used
to start sourcing VBUS, who knows.

Also look at the usage of musb->is_active. That's a flag use for host
mode. IIRC, it tells other parts of the driver to connect the vbus
charge pump, but my memory fails now :-s

--=20
balbi

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQz0SOAAoJEIaOsuA1yqRE/5sQAIzrHRmS/6q+x9Ou9krBfTat
gLsgJ5OGZkrVSd0+NGhu2bk3C4OJKGBlUMJ7VZ+gMZ2EIdLoQivW+XEDDGisdK55
RRttoxpgDJIhslgmg5422vwEXBkfnKaunDizyzI2Aruu/JI2hYZ1QaTlCWr5eEhQ
aRMB7leMeEWtizSH9YJ6hFv0oBAhb3dzyvXwn74Zrr/kRR8wtRX2ZnCrYCfr0NxQ
/InjZWwNg8/gvqJzMkm6ey0G4gKWXxMwlPTaEPElZRuvn9WWWTcRhtyYVSlkzw1S
kSLoJFrDo0IjE5zqDp5PTbmUhyoIDBepaTEo78jRP2WXluZ/dLvLv25yh3jkGjbp
1VtbhC6rasnwb1V6/GhDKUMEHouWZagb00f/niwh6x1bY0+Qj32KN09GfqvMvFAF
CU1v5hrVO8Myu69RrZV9PS7MyjuWvZ9z6aunFBygv8DnKl0/SIciFXFI+1SgHBwY
8ehtvnVtpcLlC88+LRvB+Qon+yO46h27gfGpIWSHtz8jGrr5eV33KbdtzdHfjvXK
FW7ew2MDtYUcLc5v0kT8el3yiIOw7jDOrQKGEimyFjDw1LRUJs1q27SlMuLUf04z
GzOrIG7lLzFU8FB2QBcLTBCj4FPlY+t6oyztlXWCbECAsUQR5e8YjAm3Whcvp3wv
46B9dmszWIBOet2QTPbw
=I4DW
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
