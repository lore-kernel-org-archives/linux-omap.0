From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: usb: dwc3: gadget: warning on v4.3-rc1
Date: Mon, 21 Sep 2015 16:05:14 -0500
Message-ID: <20150921210514.GG22310@saruman.tx.rr.com>
References: <55FFBA83.7010003@ti.com>
 <20150921144150.GB9144@saruman.tx.rr.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150921144150.GB9144-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 09:41:50AM -0500, Felipe Balbi wrote:
> On Mon, Sep 21, 2015 at 11:06:27AM +0300, Roger Quadros wrote:
> > Hi Felipe,
> >=20
> > I see the following warning when g_zero is loaded
> > and USB cable is plugged to host on dra7-evm's USB1 port.
> >=20
> > It happens only once and no longer appears on re-loading gadget
> > or plugging/unplugging cable.
>=20
> already fixed, -rc2 should have the fix.

actually, the commit is Greg's queue, should hit -rc3 if LC doesn't
take all of Greg's time :-)

cheers

--=20
balbi

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWAHEKAAoJEIaOsuA1yqREnRwQAKEJN8YnWAfHtYfsaT6KQoC0
7ivofik7lfec+r5jzU37XKoFn+nuSU2ZxNXtHtUvFQkDofhCyr+T/c51w25tJyh6
mqOt3vtBggcszNPygrisihwXnJ+SRNbpt4dW4v2WgmTrYXH9zVMx21OVkXxFMQWE
xE5HMZmhsjLQdqN9RKbxaALSquc4WmHnNJm4RwspaNthw+Thip4+PbCK1PE0uf8g
POPqyuwrqeXxl2POdZ5mSBTe14ZFXfD43i2vrV2lX1w5x2d0aUF3s059sTy9HbPc
JE43HoPlbs+N1yrbqh3NJ0wJDDAI1V8c2xoiH00oHhV+K1kOGaW904lVlL8i7rrb
6MovOvkdpmTf13rdanpPvzOmUrsqsFa0auo5Stjo3rn8Tp6DAKqYKqukxvAja47M
eBumjT3Oxcqsfe8OOi5I3RkKvmsg95nr+gBT1zJ5RvxIhDlQBxfN8X3MSl+dvQLZ
5936tJa+gCvog8eakuH5IIPKaR6NumnnlQVALBZycryUml4KilXEY8DH2eKMg84L
RSF2zdVGlhV/5BNp/cB3MpYOXRpWYXZ+t2unK93bLGUwc8M5tI3sLSEMSfk9Bzwl
qKj4e+WA3ePWN5QmAHhWlHZtYLtKVVm2xgDyxVBf/T/uBZzvtiAfxY1bNWwJT4KO
EKj5by18aqQUGm+XKEWB
=JWVT
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
