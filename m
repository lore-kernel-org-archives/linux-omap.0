From: Felipe Balbi <balbi@ti.com>
Subject: Re: CONFIG_DEBUG_SHIRQ and PM
Date: Thu, 27 Aug 2015 08:02:18 -0500
Message-ID: <20150827130218.GA4701@saruman.tx.rr.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
 <CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
 <20150826193820.GT14625@saruman.tx.rr.com>
 <CAAEAJfAPVgxhRnfYJYzebFJDRJ4Ooam6n+0B5HJ-+uLJ0exTLA@mail.gmail.com>
 <20150826200300.GU14625@saruman.tx.rr.com>
 <CAAEAJfB3iiRENEKm6xx-kLae5AR6BV0XVo0KNkb8-okvLjhFhg@mail.gmail.com>
 <20150826202429.GV14625@saruman.tx.rr.com>
 <CAAEAJfAPB1N-xcz+HbHCcF8JaXAVL05CSwpQGi7ea+114mMpmw@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAEAJfAPB1N-xcz+HbHCcF8JaXAVL05CSwpQGi7ea+114mMpmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Felipe Balbi <balbi@ti.com>, Ingo Molnar <mingo@elte.hu>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2015 at 05:36:24PM -0300, Ezequiel Garcia wrote:
> On 26 August 2015 at 17:24, Felipe Balbi <balbi@ti.com> wrote:
> [..]
> >>
> >> static irqreturn_t tw68_irq(int irq, void *dev_id)
> >> {
> >>         struct tw68_dev *dev =3D dev_id;
> >>         u32 status, orig;
> >>         int loop;
> >>
> >>         status =3D orig =3D tw_readl(TW68_INTSTAT) & dev->pci_irqmask;
> >
> > Now try to read that register when your clock is gated. That's the
> > problem I'm talking about. Everything about the handler is functioning
> > correctly; however clocks are gated in ->remove() and free_irq() is
> > only called *AFTER* ->remove() has returned.
> >
>=20
> Yeah, it's pretty clear you are talking about clocks here. That's
> why I said "read won't stall" in the next paragraph.
>=20
> >>         [etc]
> >> }
> >>
> >> The IRQ handler accesses the device struct and then
> >> reads through PCI. So if you use devm_request_irq
> >> you need to make sure the device struct is still allocated
> >> after remove(), and the PCI read won't stall or crash.
> >
> > dude, that's not the problem I'm talking about. I still have my
> > private_data around, what I don't have is:
> >
> >               _            _
> >   __ _    ___| | ___   ___| | __
> >  / _` |  / __| |/ _ \ / __| |/ /
> > | (_| | | (__| | (_) | (__|   <
> >  \__,_|  \___|_|\___/ \___|_|\_\
> >
> >
>=20
> Yes, *you* may have your private data around and have a clock gated,
> others (the tw68 for instance) may have its region released and unmapped.
>=20
> And yet others may have $whatever resource released in the
> remove() and assume it's available in the IRQ handler.
>=20
> I honestly can't think why using request_irq / free_irq to solve this
> is a workaround.

because it'll, eventually, boil down to not using devm_* at all and
that's pretty stupid.

--=20
balbi

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3wpaAAoJEIaOsuA1yqREwnYQAJSy8KQYJI4unct1na3W9UUf
qlVk5C1O9oeNlL/xsDGqjzhAgg7RQMEo1RpEr3u0hWaJmQZJNoG3dvxfgO4l2xX6
zOcH82ty3r93qx8+QsqHLz1XFCqUIiFWZ54tzTopWwxHG76N9QPaWCZ87IpssAgM
uwAjawmebH4VFbzdnGLJpkbHLUYEYJJf/6CIhQl6w41rXGf8I8KeTD1SKXTe9q5L
up2Eit0L82K2azp9tsEKP7hhIvyoMmPQe711lssKtvYnhBso0FDGiOzjoIWkc8YS
tVUWNA0ZNj5UDgio7x8b8q7w1+bOWy52TEHQDngtz/RaX6Kz0Taft/bBV5O0vtz2
CHy4hetf8PgaXZKeFgmq1Sez740Q8c9TShCb2CZM53YgbNhJP2tJCjovK12+tS+g
Wb/Fs4jHAKHnx+g0Fb03XboC4/RBjILNUDgHt0wOBDljOXY5+Jjd/AdrVROM1+97
OzZa49STXmjvReGmqo/bIhMKvbWtzKJ1lQebDAvFccDlZk4P5hb5zQTqKqpqTv11
Men2oMwtG4FgWkXOFOXk+9t/50Va/P6uyYCCMOqYy6SAcOGHIJC50SQEt53oR4gC
vc/WdAxIVq+p893P9RPN7YTdZLqG6g+6+qgfVMypxmWA1ATZv4aamZZ+Jfe8abhg
4Tc1yHTSs2KDP4vLrRCu
=3iXV
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
