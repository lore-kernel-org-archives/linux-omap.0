From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [PATCH RFC] ehci-omap: simple suspend implementation
Date: Fri, 16 Feb 2018 19:35:57 +0100
Message-ID: <20180216193557.2a7dbda4@aktux>
References: <20180216171414.8097-1-andreas@kemnade.info>
        <Pine.LNX.4.44L0.1802161302300.1402-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=_P+RuhQ5Q.8+R_iiUYVeRg"; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1802161302300.1402-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/=_P+RuhQ5Q.8+R_iiUYVeRg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2018 13:13:11 -0500 (EST)
Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:

> On Fri, 16 Feb 2018, Andreas Kemnade wrote:
>=20
> > This powers down the phy and on a gta04 it reduces
> > suspend current by 13 mA.
> > For unknown reasons usb does not power on properly.
> > Also calling usb_phy_shutdown() here feels wrong
> > apparently the reset line has to be activated.
> > usb_phy_set_suspend is not enough here. The power
> > consumption still stays approximately the same as
> > without any patch.
> >=20
> > With a device connected the device does not enumerate
> > after resume. A rmmod ehci-omap ; modprobe ehci-omap
> > does not make it reenumerade.
> > So there is still something wrong here.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
> > ---
> >  drivers/usb/host/ehci-omap.c | 59 ++++++++++++++++++++++++++++++++++++=
++++++--
> >  1 file changed, 57 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> > index 8d8bafc70c1f..0be2ccf8182a 100644
> > --- a/drivers/usb/host/ehci-omap.c
> > +++ b/drivers/usb/host/ehci-omap.c
> > @@ -266,6 +266,58 @@ static int ehci_hcd_omap_remove(struct platform_de=
vice *pdev)
> >  	return 0;
> >  }
> > =20
> > +
> > +static int __maybe_unused ehci_omap_suspend(struct device *dev)
> > +{
> > +	struct usb_hcd *hcd =3D dev_get_drvdata(dev);
> > +	struct omap_hcd *omap =3D (struct omap_hcd *)hcd_to_ehci(hcd)->priv;
> > +	int ret;
> > +	int i;
> > +
> > +	ret =3D ehci_suspend(hcd, false);
> > +	if (ret) {
> > +		dev_err(dev, "ehci suspend failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +	for (i =3D 0; i < omap->nports; i++) {
> > +		if (omap->phy[i])
> > +			usb_phy_shutdown(omap->phy[i]);
> > +	}
> > +	pm_runtime_put_sync(dev); =20
>=20
> Why do you include a runtime PM call here, given that the driver
> doesn't support runtime suspend or resume?
>=20
Well, the parent (drivers/mfd/omap-usb-host.c) has, and there are runtime PM
calls here in the _probe/_remove functions, so it seems to be sane to do it
here, too.


> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused ehci_omap_resume(struct device *dev)
> > +{
> > +	struct usb_hcd *hcd =3D dev_get_drvdata(dev);
> > +	struct omap_hcd *omap =3D (struct omap_hcd *)hcd_to_ehci(hcd)->priv;
> > +	int i;
> > +
> > +	pm_runtime_get_sync(dev);
> > +	/*
> > +	 * An undocumented "feature" in the OMAP3 EHCI controller,
> > +	 * causes suspended ports to be taken out of suspend when
> > +	 * the USBCMD.Run/Stop bit is cleared (for example when
> > +	 * we do ehci_bus_suspend).
> > +	 * This breaks suspend-resume if the root-hub is allowed
> > +	 * to suspend. Writing 1 to this undocumented register bit
> > +	 * disables this feature and restores normal behavior.
> > +	 */
> > +	ehci_write(hcd->regs, EHCI_INSNREG04,
> > +		   EHCI_INSNREG04_DISABLE_UNSUSPEND); =20
>=20
> Doesn't this code belong in ehci_hcd_omap_probe()?  I assume you only
> need to set this undocumented bit once, not every time the controller
> is suspended.  And in any case, according to the comment, you would
> need to take care of this before the root hub is suspended -- by the
> time the controller is suspended, it is already too late.
>
=20
I am not really sure about this one. It is set in ehci_hcd_omap_probe()
so it is set before suspend. I set it here to ensure it is re-set when
the controller is powered down too much to keep register contents. I
do not know if that is the case. But I thought it would not harm.

Regards,
Andreas

--Sig_/=_P+RuhQ5Q.8+R_iiUYVeRg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlqHJI0ACgkQfb1qx03i
kyQDlw/+JVX9ce2rGkM3MsOkHN03i8cLsC/iC8CVzy7rOAE07fIPnB4xNLHPNSDs
siA+V9NOnv5vqEQ3uJZslRwA+g6wiQtAvFQdRDWTmcwghvHrfwRm1+cPFVosksq4
mkoG+sJU7LlrOyEqEZySms0+08vSQ7s5lSCy+uK6QTq2pmGnos+NjTuEETU6gyno
zm0dTHcsXoErcIXXL8xLLx7mPasjYJBL9x81Fl1gviu6Lya2Wu+L7B5rjSrrM0b7
PZ8bLLBDLmHLwwFJU9C3khtGoCwVJo8Sqtkje4tiLCofP+MdRgleIbdjx2B+u/gZ
fB8hgFiwtBlSV+b8Oh7Wb4OkI7w/wdy3nPnyb5rKxOHEonFttgWSEI22jZ43PHuJ
8FNL+kLvGd6W9uRMCnd/b85EwcrgcFEqSJm5TRywfvxu1yae+K+LVjMrQ9twtT72
i8uke2n1Q51UCt4Hw3AMpiryjdDd1vtgBBp8jo/TLd4fG2/zY9YgY5R/2tAvFGkE
JFnk5/a+T5iZAm2CT+ymK1VC7feQ3B/xyXmqTBaZPkkwCGRy0SWrBDTapKybEli/
Le0LBk3Px3CdwY78li3TcqeHH1WWwCPjGMtKFxEWiPdzVT5RbLhbmwoLpuj6l5n2
yeEyzTkZqTVPIJ5kOW4dq+EZ2PniQsrlyY59xKWHixvg5P2a/7g=
=cGmS
-----END PGP SIGNATURE-----

--Sig_/=_P+RuhQ5Q.8+R_iiUYVeRg--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
