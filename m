From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 3/3] i2c: inititalise the actual transferred to zero
Date: Mon, 2 Jul 2012 14:54:23 +0300
Message-ID: <20120702115422.GC2730@arwen.pp.htv.fi>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
 <1340967927-27354-4-git-send-email-shubhrajyoti@ti.com>
 <20120629144002.3b4a31ee@endymion.delvare>
 <20120629145718.697b6955@endymion.delvare>
 <4FEDA9A8.1050504@ti.com>
 <20120629151832.0cb26bea@endymion.delvare>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:45717 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751502Ab2GBL46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 07:56:58 -0400
Received: by lboj14 with SMTP id j14so8726624lbo.35
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 04:56:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120629151832.0cb26bea@endymion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 29, 2012 at 03:18:32PM +0200, Jean Delvare wrote:
> On Fri, 29 Jun 2012 18:42:08 +0530, Shubhrajyoti wrote:
> > On Friday 29 June 2012 06:27 PM, Jean Delvare wrote:
> > > drivers/gpu/drm/nouveau/nouveau_bios.c:3535:3: warning: (near initial=
ization for =E2=80=98msg[1].actual=E2=80=99) [enabled by default]
> > >
> > > This needs to be all fixed (converted to C99-style struct
> > > initialization) before your patch is considered for inclusion. And
> > > there may be more that my config did not spot.
> > Yes,agree.
> >=20
> > The idea of this patch was if the idea is agreed upon then.
> > then fixing all the callers could be worked on.
>=20
> This is worth fixing anyway, C99-style initialization is always good to
> move to.
>=20
> > However do you agree with this approach?
>=20
> Well you've seen the caveats I mentioned, this will be no easy ride. If
> you are willing to take the risk, spend the time documenting the
> change, and help people if there are issues, then I'm OK. At least as
> long as someone else doesn't come saying it's a very bad idea ;)

This approach is a hard-requirement for devices which will pose any
interface/feedback with user. We have been working with a piezo driver
=66rom TI (drv2665) and it will be used (in most cases at least) to give
the user a feedback based on e.g. touchscreen event.

Imagine drv2665 responds with a NAK while we're in the middle of driving
a wave through it (keep in mind a wave could take seconds to finish,
depending on the usecase), if we don't have a way to tell users that we
have writen X bytes, how should we make sure to continue driving the
wave from the exact byte where we got a NAK ?

If can't make sure that detail is true, then such usecases (as piezo
drivers) will never work.

Another approach would be to not add any field to struct i2c_msg but
instead return either the amount of bytes transferred, or an error case.
This would mean a series that would:

1) fix all users of struct i2c_master_send() and the like to check for
	errors as if (ret < 0) instead of if (ret);
2) fix all i2c buses to return the amount of bytes written instead of
	zero or error case
3) fix Documentation to state that we're now returning the amount of
	bytes, instead of zero or errno.

I'm not sure what will have minimum impact to userland, though. What do
you say Jean ? What would you prefer ?

--=20
balbi

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8YvuAAoJEIaOsuA1yqRExJMQAIh6m7mXG4ZcXuVzQ12PNyQc
oKMXB/vFXdKTdsDrL7oOKxDViEKNqz/mwkTRLwwyUY1uG4shE90SNzrccj24xxL9
eJNtbE5UMVT7p0mRciO0tRscmABpwIM3kt90dZzhYdgoB87Cajc9qJUSHvLI545t
sJJVsxHH+FFYgTrxXLxkFfNSPvUQ1p/XksOr2TnmnNg+Fj9f/cqORvKujDW+qMIi
kUX1gZWlROpmlZwrirRxe3T5t3PXX9/086TxZKYrl/JiJM20Vu9iMrKpQ4mJzxgj
2PL9+fqtLcubDM4KkLI15lertJDwjtICOUUFJ1FjNIBSkeKeVxk0plCystjBKVZj
0ZXObtYG5MtJ+knjSwGOly7thh8850WjgEPZYpSrfr0VhrHIcZkIL0rh6tA2DtC8
KA15sclN9jNu05WOLsp/KqfA0t61DhnxFgFjQEmvw2SRKYuTlB9Jksk7jG8vG5df
kXokJDFEr7W4s49+RjLSCC97woa/LFkrCdpeJeL+KbhGnwhzRB4i/CI/HMrMGDsK
xy3nVjn0BPVat8+U10sdVh6y3UAnYcnS+trF6JutbjeQUKUnUW9Kc81N8pbkCfdj
fhFpHI9KoG2A/ZdN6wQ4atguQokEad1x93tfEwP2LbxJi5s0M5gSbXjULpoj193p
JecxhuUTcM52e+kY9G7E
=apzP
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
