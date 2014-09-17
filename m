From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap2: n8x0: move i2c devices to DT
Date: Wed, 17 Sep 2014 10:45:14 -0500
Message-ID: <20140917154514.GB8140@saruman.home>
References: <1410899500-21323-1-git-send-email-balbi@ti.com>
 <20140916203337.GI19010@saruman.home>
 <20140917145131.GB7987@atomide.com>
 <20140917150205.GB6903@saruman.home>
 <20140917150818.GB14505@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60652 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754786AbaIQPqJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2014 11:46:09 -0400
Content-Disposition: inline
In-Reply-To: <20140917150818.GB14505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>

--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2014 at 08:08:18AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140917 08:03]:
> > On Wed, Sep 17, 2014 at 07:51:32AM -0700, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [140916 13:34]:
> > > > On Tue, Sep 16, 2014 at 03:31:40PM -0500, Felipe Balbi wrote:
> > > > > By moving i2c devices to DT we can clean up
> > > > > i2c_board_info and fix a problem with moving
> > > > > INTC to irq domain where IRQs can be renumbered
> > > > > on each boot.
> > > > >=20
> > > > > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > >=20
> > > > note that this only causes problem for N8x0 because it boots in kin=
da of
> > > > a hybrid way, where it uses DT but not all peripherals are created
> > > > through DT.
> > >=20
> > > Thanks applying this into omap-for-v3.18/intc-v2.
> >=20
> > it might be better to apply this on your DT branch and merge DT before
> > intc-v2, that might avoid a bisection problem.
>=20
> Yes it would have been nice to have this as a patch before preparing
> for intc-v2, but I did not have my n8x0 booting reliably because of
> xhci vs ehci issues on my PC and did not notice it early enough.
>=20
> I've already sent a pull request for the first part of intc-v2, so
> best to keep the related changes together in this case.

alright, no problems then.

--=20
balbi

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUGayKAAoJEIaOsuA1yqREHwQQAJsuxDyI82y0DR0uyQ/mCwZW
LdqVzXHNK6XldWeDJZTYqSjXDQxPH0+wB/dAe2/EJ72O0oolJHGZB1KTJ+SdzUmA
LMhMe+TKJh2clEM32xvel2ag6t8gznDOFF3+sb5LQA4OVmv+Ju83DWhQJIKvqD/T
tfdxn5ufLLKYrX8JVWDUAPQ+zBhuQVacVBaQL7QuUvPKu4q55eZO9TKTL04hrHeq
urziv3MVlD3FhafgmGm18HSyRM6Mi8RitPH9oOAq1Ceej0VpbJh5maAKozciw1gZ
9nTvjM3B6Kg1zesgeEZ0HnPjzEd+YhXZoxfoGSl9KesjeWtuSSGvPqvv5VHN3lY1
V7kxPSw4qgivKeXiF38I7eIlbzDaP87yNUPVKePZ1H214mWQDKgMWY535OKc1ERM
kmek5h0tUxdVJuAS91tKDFuXzOHQ0uaR72hb+chB5jVNPOojmHUSyQ1M0bkrhjWi
SAkq4fCFQO57+LAqY0oGgnt3Oz2OYsXWe78/90Fs+CWrYlU946c7cpmFGwabXhyO
M4mqLLnfKdN+kYMAxcC47hDUHHoAA04B/aRlE+mrusDOSeE7QMsWmCoYtq3QBOt1
ggiGyteSVv01lBGLzH6uIWRPREn5ra10pMOP+u501xvJ0x+dEXjSraJNmOLqA7hB
O49Y2JJbNAG0RVpUW4tT
=b645
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
