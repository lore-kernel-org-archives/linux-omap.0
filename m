From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv7 00/23]I2C big cleanup
Date: Tue, 11 Sep 2012 15:05:54 +0300
Message-ID: <20120911120552.GJ18907@arwen.pp.htv.fi>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <504F0FFA.2010200@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RUqJLqMNe5u4kDWT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:41562 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751172Ab2IKMK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 08:10:27 -0400
Received: by lahm13 with SMTP id m13so271431lah.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 05:10:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <504F0FFA.2010200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de


--RUqJLqMNe5u4kDWT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 11, 2012 at 03:48:34PM +0530, Shubhrajyoti wrote:
> On Tuesday 11 September 2012 03:11 PM, Shubhrajyoti D wrote:
> > Changes since v1:
> >        - removed tabification on patch 6/17
> >        - removed dev_err() which was introduced on patch 09/17
> > Changes since v2:
> >         - do not set full fifo depth in the RDR interrupt.
> >         - some changelog updates.
> >         - rebase to the Wolfram's tree.
> > Changes since v3:
> >         - Remove a redundant read of status register
> >         - Read the dev->buf_len variable instead of the register
> >         as the information of the remaining bytes is there.
> > Changes since v4:
> >         - Ack the arbitration lost.
> >         - Rebase to the i2c-embedded/for-next branch.
> > Changes since v5:
> >         - Rebase to latest mainline
> >         - Added some more cleanup patches so as have a consolidated ser=
ies.
> > Changes since v6:
> >         - Fix comments on setting the pdev to NULL.
> >         - Trivial changelog update
> >
> > Previous discussions can be found here=20
> > http://www.spinics.net/lists/linux-i2c/msg09482.html
> Also this gives better performance
> With the patches:
>=20
>  Performance counter stats for '/build/i2c/bin/i2cdump -y -f 1 0x48
> b':       =20
>                                                                          =
     =20
>=20
>          78.796376 task-clock                #    0.453 CPUs
> utilized         =20
>                516 context-switches          #    0.007
> M/sec                 =20
>                  0 CPU-migrations            #    0.000
> K/sec                 =20
>                114 page-faults               #    0.001 M/sec =20
>=20
>       0.174011183 seconds time elapsed =20
>=20
> Without the patches
>  Performance counter stats for '/build/i2c/bin/i2cdump -y -f 1 0x48
> b':       =20
>                                                                          =
     =20
>=20
>         123.504640 task-clock                #    0.049 CPUs
> utilized         =20
>                337 context-switches          #    0.003
> M/sec                 =20
>                  0 CPU-migrations            #    0.000
> K/sec                 =20
>                144 page-faults               #    0.001
> M/sec                 =20
>                              =20
>                                                                          =
     =20
>=20
>        2.534424040 seconds time elapsed=20
>=20
> The auto suspend is probably the one  :-)

Awesome, I didn't go as far as checking performance counters :-)

--=20
balbi

--RUqJLqMNe5u4kDWT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQTykgAAoJEIaOsuA1yqRE23oQAIWQCrqXQ2uCuQQkc87EW2X6
0G2au8XuHDcznLb3srED1mLAgAvsj32TXv+iHitWztQkaIWYc702ZdduJlOAIaMJ
3Mga97wDLHwaf7IC5WUzRloe45C6KWN9+BE/SQD6TA1Byu3JnYGaoHPU+jRlq7PZ
HtiZhQKhh17RyakE93siex7i1A9YAjSxNtWNtryUZRqkUoBnALggUuVXQ1UGUuBq
bg2Wp8fHX/49WIf4s5GRaO99MvHOHMa1N3iGyEkkLd0pEwEeT/9wTNWBb3SdmZHQ
4/4WOnR45IWjlkZefC27CuQoO3SrVMvUzxX4RrwrM8ukQT9jcB8USwU7BXA+yVPQ
XwtBn0vpAWCgiHce64vTxmPcw7VWSFopBOR5vL4rQ5EJvK+Mh0QGiU4nuqF3vBwz
mDdKKMcTwstY6qoNLSHzQ0kVHYz5cYKT2R//58pWcYAomRdBFY8Il17bBDFh39FU
K7ckvtihh0fW7sPaq7s5ZZQ9F+UgfvPgOWW6ajXAGvoNx1A8rkqSPZXisGgNvZsR
TKMuhC5kYLcTtb79x1+Ty30H7lYTzsMVT5a8h6Gpy/FHWsx6G9moLK7xQCBzzMh0
RWI20VKl5dEoLhc1wyzpEzeopChR89qRso5UPg2aTRHzlvvr+EJuyKRVO1j+5V8Z
pXJRr+ILgCZbtmHJU/Dn
=dbwF
-----END PGP SIGNATURE-----

--RUqJLqMNe5u4kDWT--
