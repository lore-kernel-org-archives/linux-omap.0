From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 5/9] usb: dwc3: core: make dual-role work with OTG irq
Date: Thu, 3 Sep 2015 10:51:25 -0500
Message-ID: <20150903155125.GC4031@saruman.tx.rr.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-6-git-send-email-rogerq@ti.com>
 <20150902144338.GG8299@saruman.tx.rr.com>
 <55E85082.5040006@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55E85082.5040006-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 03, 2015 at 04:52:02PM +0300, Roger Quadros wrote:
> >>  	if (on) {
> >> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> >> +		/* OCTL.PeriMode =3D 0 */
> >> +		reg =3D dwc3_readl(dwc->regs, DWC3_OCTL);
> >> +		reg &=3D ~DWC3_OCTL_PERIMODE;
> >> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
> >> +		/* unconditionally turn on VBUS */
> >> +		reg |=3D DWC3_OCTL_PRTPWRCTL;
> >> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
> >>  		/* start the HCD */
> >>  		usb_otg_start_host(fsm, true);
> >>  	} else {
> >>  		/* stop the HCD */
> >>  		usb_otg_start_host(fsm, false);
> >> +		/* turn off VBUS */
> >> +		reg =3D dwc3_readl(dwc->regs, DWC3_OCTL);
> >> +		reg &=3D ~DWC3_OCTL_PRTPWRCTL;
> >> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
> >> +		/* OCTL.PeriMode =3D 1 */
> >> +		reg =3D dwc3_readl(dwc->regs, DWC3_OCTL);
> >> +		reg |=3D DWC3_OCTL_PERIMODE;
> >> +		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
> >>  	}
> >=20
> > it looks like you're not really following the fluxchart from SNPS
> > documentation, see Figure 11-4 on section 11.1.4.5
>=20
> Did you mean that I'm ignoring all OTG bits (HNP/SRP/ADP)?

yes and no :-)  There's a rather complex flux chart which details how we
switch from host to peripheral and vice versa. We need to follow that to
the smallest details since that's what IP provider considers to be
correct. If we deviate from that we should have very strong reasons for
doing so and we also want big, fat, long comments in source code
detailing why and how we're deviating :-)

--=20
balbi

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6Gx9AAoJEIaOsuA1yqREECYP/3HC0ogUEgEl6ipp+VQ0F2Y6
Fts7NG7anSbKQQ5zV8kBV5hMRfmczqgDkgmk3eHhlotD+JEtDz09GP7tViHo5+3u
TEmANzmYUb2mHe/YaT2z4bRwnfUtR2U1saPCJ00v7KkuPckeHEI3mipcKS4ioNfk
RbRyFIL7b5ckS3g85aovrbQ2JYPHa1xop+0VVGe9r9Cc39+Umv77Xrcwene/bK5g
8heJr1OlY47jc5qCjhLG3rkh1qJoEmtTDU+7QinS5lmUzsFxxnnAhXCzeXfrZ2BF
FUufKteKV7a2Zo67zunoVjt6XH1ch/AsteoF+lYG3RrXVUdtknYPmVL44q8Ysand
fi7liVcpXmwhykMJ5WoaGJ7hB6Ug/XthKC0aUi2pp9ceLm80Seb3ZPnlhzuI0PkE
4BQCoTngjG5+hNzzL9ofL2hEGI02G4NTHef8uIgCkqzu2sj6K8TpVMMun7JSlVB1
C2icbXdDi4GhwpzckMVeteaTDeFv/MQHTNGoc0AmpCVxzsgIh2excVb82HgcoWN+
WXrlPVGZQ9NdPQ1kJRq3cuOemktnXnR+p55PJP1tWOm9r8Zj/Q3CabCU5hpVJ+az
mtdt7r6fBvUBu2syq3daqMYSV9gAF/5KRGiqbS4MYNauYfmhxi7FoZtOnukKVGdJ
NoVccZgi/D438M7GMg3l
=wxeu
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
