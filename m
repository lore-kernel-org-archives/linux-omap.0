From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable
 mask on disable
Date: Wed, 24 Oct 2012 10:39:27 +0300
Message-ID: <20121024073927.GC5665@arwen.pp.htv.fi>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
 <20121023190914.GA853@arwen.pp.htv.fi>
 <87k3ug7st2.fsf@deeprootsystems.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59191 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934430Ab2JXHpO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 03:45:14 -0400
Content-Disposition: inline
In-Reply-To: <87k3ug7st2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: balbi@ti.com, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2012 at 03:00:09PM -0700, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
>=20
> > Hi,
> >
> > On Tue, Oct 23, 2012 at 11:09:31AM -0700, Kevin Hilman wrote:
> >> From: Kevin Hilman <khilman@ti.com>
> >>=20
> >> When debounce clocks are disabled, ensure that the banks
> >> dbck_enable_mask is cleared also.  Otherwise, context restore on
> >> subsequent off-mode transition will restore previous value from the
> >> shadow copies (bank->context.debounce*) leading to mismatch state
> >> between driver state and hardware state.
> >>=20
> >> This was discovered when board code was doing
> >>=20
> >>   gpio_request_one()
> >>   gpio_set_debounce()
> >>   gpio_free()
> >>=20
> >> which was leaving the GPIO debounce settings in a confused state.
> >> Then, enabling off mode causing bogus state to be restored, leaving
> >> GPIO debounce enabled which then prevented the CORE powerdomain from
> >> transitioning.
> >>=20
> >> Reported-by: Paul Walmsley <paul@pwsan.com>
> >> Cc: Igor Grinberg <grinberg@compulab.co.il>
> >> Signed-off-by: Kevin Hilman <khilman@ti.com>
> >
> > looks like this deserves a Cc: stable@vger.kernel.org tag.
> >
>=20
> Agreed.  I think this goes all the way back to v3.5, but would've only
> been seen on boards using a request/gpio_set_debounce/free sequence
> combined with off-mode.
>=20
> Linus, feel free to add the Cc: stable when commiting.  Thanks.
>=20
> >> ---
> >> Applies on v3.7-rc2, targetted for v3.7.
> >>=20
> >>  drivers/gpio/gpio-omap.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>=20
> >> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> >> index 94cbc84..dee2856 100644
> >> --- a/drivers/gpio/gpio-omap.c
> >> +++ b/drivers/gpio/gpio-omap.c
> >> @@ -187,6 +187,7 @@ static inline void _gpio_dbck_disable(struct gpio_=
bank *bank)
> >>  		 * to detect events and generate interrupts at least on OMAP3.
> >>  		 */
> >>  		__raw_writel(0, bank->base + bank->regs->debounce_en);
> >> +		bank->dbck_enable_mask =3D 0;
> >
> > shouldn't omap_gpio_restore_context() check for dbck_enabled instead of
> > the mask ? I mean:
> >
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index 94cbc84..b3a39a7 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -1371,7 +1371,7 @@ static void omap_gpio_restore_context(struct gpio=
_bank *bank)
> >  				bank->base + bank->regs->dataout);
> >  	__raw_writel(bank->context.oe, bank->base + bank->regs->direction);
> > =20
> > -	if (bank->dbck_enable_mask) {
> > +	if (bank->dbck_enabled) {
> >  		__raw_writel(bank->context.debounce, bank->base +
> >  					bank->regs->debounce);
> >  		__raw_writel(bank->context.debounce_en,
> >
> > the outcome would be the same, so it doesn't really matter. Just that,
> > at least to me, it would look better.
>=20
> I tried your version, and unfortunately, the outcome is not the same,
> but don't plan to look into why.  $SUBJECT version is targetted and
> tested.  If you want to cleanup the cosmetics here, please do in a
> subsequent patch.  This driver could certainly benefit from more
> readability cleanups.
>=20
> > No strong feelings though.
>=20
> Good.   I'll take that as an Ack.  :)

please do:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQh5svAAoJEIaOsuA1yqRE+90P/3tJIXDUgzQvrz4GdjOOSJlV
q3Th5s7pJg8H+211RbDlLnHDVIoRZAta3l50f40JD3QvWBCfMLnAh+2bZaRX70we
iO6wAXv/xQ+MRrReX30Pt8pEQ2B64XpGw3lHGzIEHYstpRbcbv5ZDoD8K9Shj5MC
v4rAHQ5iF0ScvbiYAFi/0RZWocrzQS8um6No4FURGMwuZKZ/vZADnVhksGH0t+JM
7ufTpX+z9i60CqYkBbW2ghkUCeAaynywVVLEfP4n/SjQ5MDJzcylTOSyVNxPzHvw
oYXalkl+mQ0clUfA87Xv0jAfwSiCv3dfdlzgeuEDpcJ0hkQ14Qmj+LxHfqHofU24
Bs956MEkTBGhj/sKK2+0xvEBn72J5c1/W37YqLS9HQt/ZHO2ZikrqTIZHF/YiN4t
yv1EaLerMW/Cp6BSgfga39N6Sslr7smd21AKj3683GH4nsmA+PTRN++TsR/dqH2r
6ioEm2uh3bIuATuBNqlGP0FIbZ79aKKAi4VNp1Hehjk1fre/n2u3Vk2dx3LJWBGJ
8mJOg/YiFgwNt37Wrx6jT3LDqQWcmdyabcm3fGKJyeQZCkT7frlwFgFstQpBvgBg
Hy7hHvgF09PXoOMJ/46QeTD7zajzjr1jAH4x1zT1ebA8id9i/eCYlQ87S1xfDteE
2Y6mYJBRq5s1wZpDDHFM
=gUiC
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
