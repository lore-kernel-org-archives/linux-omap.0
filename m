From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: MUSB-HDRC Gadget driving VBUS inappropriately
Date: Fri, 14 Dec 2012 12:00:42 +0200
Message-ID: <20121214100042.GD15370@arwen.pp.htv.fi>
References: <C3E8C797-AE49-4638-B41B-B3AE180D3426@gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C3E8C797-AE49-4638-B41B-B3AE180D3426-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Coolidge <iancoolidge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, icoolidge-N6lXUpBFt8Mlk5EcyZIkJQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2012 at 01:53:07AM -0800, Ian Coolidge wrote:
> Hi,
>=20
> We're using Linux 3.3 on DM3730 with TPS6595xx PMIC for an embedded
> product.
> For a particular board, we have musb-hdrc (RTL 1.4) configured in periphe=
ral mode.
> We use the Ethernet gadget configured for cdc_eem to use Ethernet
> emulation over USB for this link, and the robustness of the link is
> mission-critical. To assure this, we have performed some massive
> reboot testing to ensure that this usb link reliably comes up.
>=20
> After working through an issue which required pulling in the following
> patch,
> -----
> commit b1b552a69b8805e7e338074a9e8b670b4a795218
> Author: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Date:   Wed Aug 8 11:48:10 2012 +0200
>=20
>     usb: gadget: u_ether: fix kworker 100% CPU issue with still used inte=
rfaces in eth_stop
> -----
>=20
> we find that with about a 2% chance, the gadget comes up in some kind
> of firmware failed state, driving VBUS.
> In this condition, we found that MUSB_DEVCTL_SESSION bit was set.
> I understand this to be indicative of MUSB thinking it is in host
> mode, which agrees with the driven VBUS.
> Further, in this state, I found that usually, there was one interrupt
> from twl4030_usb, but NO interrupts from musb-hdrc.
>=20
> So, as a hack, I cleared MUSB_DEVCTL_SESSION in omap2430.c in the
> notifier block from the VBUS interrupt.
> This appears to reduce the frequency of the problem -- I now always at
> least one instance of the musb-hdrc interrupt.
> However, sometimes, it looks like the MUSB PHY dies shortly
> thereafter.
> So, I don't think this hack is fully effective.
>=20
> I reviewed commits that post-date 3.3 in omap2430.c, musb_core.c,
> twl4030-usb.c, musb_gadget.c, and I couldn't find anything interesting
> -- it looks like mostly reorganization has taken place.
>=20
> We have also engaged TI to try to get some silicon errata from Mentor
> Graphics, and maybe a register manual for the MUSB HDRC IP, but this
> is slow going, and that has little guarantee of paying off anyways.
>=20
> Are there any ideas, or patches that anyone might suggest?

I don't think it's a silicon errata. Looks like a driver bug to me. But
since you're using such an old kernel, your TI support channel is the
only way forward, unless you can test with a more recent kernel like
v3.7.

=46rom what you describe, however, it sounds like it's a problem with some
->set_vbus() call.

--=20
balbi

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQyvjJAAoJEIaOsuA1yqRE0jsP/0J0XNZglG737eUHEhmfuOJ/
kN90ABgD51KRhc5g7dKQPZWh+XC8N2+epQfcQTf62TkS/zRICDpCrKq0tOR6hmtV
WIGBb1GHfQ8rOkIoHLORCIaz/1taIKXAnCe9vgdw5n3g4XPqHG9VzGaWdUAzUKuQ
QMWSxP9qeaQsAeoqnsDhs1oxs4ojbCINZoYk2ztTRffqggGH2BuNZxAO6lkneJF/
xQ8z4H3ry+WzfqN1hqycsuy3dmCOymnRCp3sIWz9S4pVtJBhtv3Qp3Rn9FL1VIoB
VVAKGUbsJTwt8IIwpLIq1TUBkQRI4UDT+vpNjeOjp0TprJ6Az2Dc66zfyq7jNNej
Xk8KyLGRmreIOdW/mBafGARPI2W94jaXHji5gNoS8xpvIXCjEAXD8xNIM2sfxuh/
iqT6qVsnXZTCKoJ8ngacZeK4JbRytvv7QjK/VTYG3gIt5UIsfEPR4u9jC2geh71k
dwWSqjijpBPHtAIAC7ncB6gc7UDitumWUshYW2FJ8IWiAjd45jF/HnZkdrVwwYWq
Uj2uiQvNTUQmg1tcXWfZB6r13eZ3ykgR0KHnpyG9UUq1nBosZTCG6Pj9J1vxpLpR
Se/LlH7EKZDzfDZHLcssVoQGPYH8HaBNexR694rpCJxySZa6TW/glzu2oT802ZAV
LBQg9cdUHSexHA6iazST
=u758
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
