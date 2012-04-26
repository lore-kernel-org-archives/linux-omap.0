From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/10] OMAPDSS: HDMI: Implement DSS driver interface
 for audio
Date: Thu, 26 Apr 2012 10:31:44 +0300
Message-ID: <1335425504.1962.17.camel@deskari>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
	 <1332974305-4578-11-git-send-email-ricardo.neri@ti.com>
	 <1335186116.1535.23.camel@lappy>  <4F97820E.2020006@ti.com>
	 <1335334757.1923.19.camel@lappy>  <4F988262.7000703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ldue1md+xnJfDyvXtwzU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:55440 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908Ab2DZHbv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 03:31:51 -0400
Received: by lagv3 with SMTP id v3so839242lag.41
        for <linux-omap@vger.kernel.org>; Thu, 26 Apr 2012 00:31:47 -0700 (PDT)
In-Reply-To: <4F988262.7000703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>


--=-ldue1md+xnJfDyvXtwzU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-04-25 at 18:01 -0500, Ricardo Neri wrote:

> > If so, we need to make sure it's not currently called in an atomic
> > context, because it would break if the function will sleep in the
> > future. And with "make sure" I just mean that we check the code and kee=
p
> > it in mind. Or perhaps adding a comment in the header, that says
> > "audio_enable may sleep, other audio functions do not sleep" or such.
>=20
> I revisited the ALSA code. Only the audio_start function is atomic.=20
> Although ALSA may not be the only user, it makes sense to me to think=20
> that they will follow a similar approach in terms of locks.
>=20
> Hence, based on that and on the reasons you describe (audio_enable=20
> potentially taking too long to return), Rephrasing what you stated, a=20
> mutex may be used for the enable/disable and config operations. Only=20
> start/stop would be protected by a spinlock. This should be described in=
=20
> comments in the header file. Does it make sense to you?

Yes. Well, you don't need to mention the locks, they are internal
implementation details. It should be enough to say that start/stop never
sleeps and the other functions may sleep.

And, this is obvious but just to be sure, note that you should use
spinlocks in all of the functions if possible. We just need to make sure
we can use mutex in the future if we need to.

 Tomi


--=-ldue1md+xnJfDyvXtwzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPmPngAAoJEPo9qoy8lh71ZrIP/3LHvXLlz3gYAwF2uJfIT0MI
q3crrKfuapHvjqVU+ouSZRY+Ck9nDSg3dfWs/XliK79vVs9ByVJMwD9RkzeliXCx
JfUsohstV/yBxRRZflXpXsH5q6evL3yXSiAsTofyddVILHT84eST9PPi2Z3HKIPC
YBjbT/j08KM8lzDIs6AHPDnEFxBNHHg4bhioCFqGX/sHlnHlGAoYf3HCT8+F+tB7
3HjeRkL9+nJB1uqaW6/QWZo1cJ86JYMYy1/82vTgZZRSnFzbh+Y77DMlD5VafxfM
alr2/5m5nuOO0hySoIvpJFy2VF9tZwZ03cG0r7H6HR1OtdjBCJ4lrBdHZcdwt21V
Aq3MHJODCsGx7MOAMNQNsdCka53AvKW50xRnZnrS5tu31TFXPW6QAM08M6JaELcO
qqnelEAB5RptUtel3P24OXnwwr2vdaB3RxQGfAo/3XSeQ5NYMNLkFyipZuZFBmRR
GKC7sKyMrPtYJ+N3T7eY9aoE304JTha8ENEu+7e6wt9UjfAhq4pyuVh2uDGB9Hn7
eCz5kepfjIZizls6+nWmInNoX0lzMXZciVB/zPDh6JT3EQ1ebyiERkDV91LPXKeD
ybNNGpvB+aKw9hijn56p50uNoiR0YdHVUROezMJ4A4HXliMXzFd/b5x6JeO9VdyK
fz5YDLd0ezebrYLnd3Ov
=IW/b
-----END PGP SIGNATURE-----

--=-ldue1md+xnJfDyvXtwzU--

