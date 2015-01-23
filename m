From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 12/13] ARM: dts: omap3-gta04: uart4 is not connected, so
 mark it "disabled"
Date: Sat, 24 Jan 2015 09:28:42 +1100
Message-ID: <20150124092842.2441d3c6@notabene.brown>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
	<1421959099-28319-13-git-send-email-marek@goldelico.com>
	<20150122214052.GY7718@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Pu=LAE=9iVL8lHYgcpTy=YI"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150122214052.GY7718-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/Pu=LAE=9iVL8lHYgcpTy=YI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jan 2015 13:40:53 -0800 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> * Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [150122 12:42]:
> > From: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
> >=20
> > Signed-off-by: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/oma=
p3-gta04.dtsi
> > index 228e79b..8d2b0a1 100644
> > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > @@ -357,6 +357,10 @@
> >  	pinctrl-0 =3D <&uart3_pins>;
> >  };
> > =20
> > +&uart4 {
> > +	status =3D "disabled";
> > +};
> > +
>=20
> This you probably want to avoid from PM point of view. Depending on
> bootloader state of uart4, Linux may or may not be able to hit any
> deeper power states.
>=20
> Marking something with status =3D "disabled" in dts causes the device
> entry not even to be created. That means hwmod won't be able to reset
> and idle this device during boot.
>=20
> The uart4 device is there for sure even if not muxed and in incomplete
> state. You may want to also check other places where you're using
> status =3D "disabled" for the same reasons.

That's ... unfortunate.  Would that apply to the MCBSPs too?  They are
disabled by default so you would need to explicitly enable them all for
sensible behaviour....

Hopefully there is some way to mark as device as "this is not used, make su=
re
it is turned off and stays off" ???

Thanks for the heads-up.  I'll have a look and see exactly what is happenin=
g.

BTW, on the topic of OMAP UARTs and power saving...
 I note that there are now two drivers for the OMAP3 UART - omap-serial and
 8250_omap.
 I also note that your commit:

commit a2fc36613ac1af2e92cbed7af80bc72d8114dd50
    ARM: OMAP3: Use manual idle for UARTs because of DMA errata

 is incompatible with omap-serial.  In particular, if I enable runtime
 suspend of the serial port by setting the autosuspend_timeout, then incomi=
ng
 characters will no longer wake the port (if I revert your patch incoming
 chars do wake the port).
 This could (I think) be fixed by enabling the RX/CTS interrupt.  However if
 omap-serial is being deprecated, then there probably isn't any point.

 So: what is the longer term expectation for these drivers?  Should we be
 switching over to 8250?

Thanks,
NeilBrown

--Sig_/Pu=LAE=9iVL8lHYgcpTy=YI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVMLLGjnsnt1WYoG5AQI0GRAApeJgaD++vxc6PfBuABjkcpC6vfETHAAK
Mp53TskeQzfvKbjGQA+hUBZDBde9wvuhyH7FsFZJv02njrqhhgD/NOWFmhFeCcqS
M7HU/5TXui2Xs5216+GvpDuW1gbXzqrg8AcgMjcAlgEsa3DKCd1TfcgE4PognVZU
Sscy0YY97dSFDYk3n0kcJ6BnY6zzXPmaVMEZgx+B+hdBmO9S7RKuS8jxsnCKSQdE
QgKcXq7aQJOgtxz9z6I5zOj6thos2i1P+dGSS1QizHQ6bXs4QbI4+8lUPu3hxp1j
aiUezyyQeH03XtSekCqVRo//YvQ89XZK/r0/b6YUN97O9tfY4ODuvJhCFUWLN7Fs
Edi1nJp4iujyczyx290Rjb4483eQBbgJ1hAnjQZjyHEPyk9LdnO734rEvVPDWLm1
jKdKuj+Jsf86AwVkrTHep8gogS8BpjpKhZLMbKoFNaASEN1YSBlM5BehLsJRcsuB
DspFibuERnRgVMcBn0PxAnKFuTIeKSaZjxDVuqiZXTWYoAbIQ0WFbuhsyGXczDJT
uwX9Nv5+UIxAubZDrdOkH2eIWy335lWNfV3k5FzzIqbm8xoHMEfzDUf+99qFOWlM
z1QtUC58bSxnsW7lyMHrZKRfxcZfpD3QSmXtwr67MCpxmCwe2bm5Jc9YM7qHAs4M
9weUEsQjVfE=
=mF4f
-----END PGP SIGNATURE-----

--Sig_/Pu=LAE=9iVL8lHYgcpTy=YI--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
