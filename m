From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: Beagle: fix TFP410 powerdown GPIO init
Date: Thu, 14 Jun 2012 11:20:59 +0300
Message-ID: <1339662059.2229.8.camel@deskari>
References: <1339579215-24098-1-git-send-email-tomi.valkeinen@ti.com>
	 <CA+Bv8XZHOhD1sdJvEzwwup+igWpkCf8twxWzrf2zhSd4_aj9MQ@mail.gmail.com>
	 <1339658290.2236.5.camel@deskari>
	 <CA+Bv8XbwWbdTFFo9KHoOk7Tq8XBWDOWhkEqq7Pz6by_8sE_ngA@mail.gmail.com>
	 <1339661613.2229.6.camel@deskari>
	 <CA+Bv8Xad=9dQw_4a=DZypbR2KN77mb=3thkE6syMt-E6JoDDaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-eOqJUgZD8+1RxqyQKhag"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47111 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755307Ab2FNIVF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 04:21:05 -0400
Received: by lbom4 with SMTP id m4so1916677lbo.2
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 01:21:02 -0700 (PDT)
In-Reply-To: <CA+Bv8Xad=9dQw_4a=DZypbR2KN77mb=3thkE6syMt-E6JoDDaw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>


--=-eOqJUgZD8+1RxqyQKhag
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-06-14 at 01:17 -0700, Russ Dill wrote:
> On Thu, Jun 14, 2012 at 1:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:

> > Okay. These are a bit problematic, because we're in the process of
> > removing these kinds of things from the board file, as they cannot be
> > supported with device tree. The tfp410 driver in v3.5 doesn't even have
> > the platform_enable/disable callback anymore.
> >
> > Those do not belong to tfp410 driver, but I don't really know how they
> > should be handled. This is one of the questions about device tree that
> > is unclear to me...
>=20
>=20
> Are you talking about the AUX_3V3_DIS pin? The boardfile currently
> just initializes that low, that should be too much of a problem to put
> into DT, or if someone is so inclined assign it to a regulator via DT.

Ah, sorry. You are right. The only gpio handled in the
platform_enable/disable calls is the power-down gpio, and that is
handled by the tfp410 driver properly. So there shouldn't be a problem
there.

 Tomi


--=-eOqJUgZD8+1RxqyQKhag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP2Z7rAAoJEPo9qoy8lh714voQAJS3pdZ2OlhfEoYMk+IWOkNP
pxdioK3fspRZtgu0IrWMYEb0GhWxxr2tH1FLTXG2IiOzx7FD7T/2UhZCRj/BtwgN
ypxtmz3Eu+ckeeyME6UQ3mh7enUJO2mfGarEz1bm8RhlYC2MIuYHrxbpocL6BUMn
WxYcDoeLXEbSrTCqundKp57yDVQI781HndKrbNOIXVhgFuswUM2G/rhwKC5KP5SD
qNd77msdsBIjdHZumsAvknOUHgyTleEDTkXMHDFn4mfVSmiq9UF9je9LWPJ5GlwB
VCgm+8lALGkPOfICYONJdMTaXNdxRFXCwvkEfffPxjmbvnnUyyVH/MPruh1Zv23h
ljD9lnHghgj5+6pGvvODw2fDHge+1iA+DbukNMy6RJMZ58V0rOG0C/PN9hVJMxBA
HGuoPtSdn7PYjsr+OucDZWbvpfi0BCFiEyzCyl+mTTOE86QEk/ULLMvHGvRDWPkM
M3F6QqymjOYGimrGCW+0NoJCj1r33k1GU6BAJwEyCUAMuW0bLhlryLhhXinIn6Md
a/8KZv54zrU5B4wNeze4xnqoY1bVb7PgvZDQCcZVhZ5V7s+zk+TnhgNwS+Mp0dFY
XUvQOAdz0AIgRs3Sgl3BKQ+i5INny7LsEInHvLZINV99U1KdSr/seY4EgvLVEFWZ
Q0Yl7XEbhh06stCXwNnC
=0wqd
-----END PGP SIGNATURE-----

--=-eOqJUgZD8+1RxqyQKhag--

