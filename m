From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 01/12] mfd: twl-core: don't depend on pdata->irq_base/end
Date: Mon, 19 Mar 2012 17:07:38 +0200
Message-ID: <20120319150736.GM25935@arwen.pp.htv.fi>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-2-git-send-email-b-cousson@ti.com>
 <87pqcegapk.fsf@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DheUW4aQn8WJk6WR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:46708 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753290Ab2CSPII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 11:08:08 -0400
Received: by mail-lb0-f175.google.com with SMTP id gi4so4704172lbb.34
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 08:07:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87pqcegapk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>


--DheUW4aQn8WJk6WR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 14, 2012 at 01:59:51PM -0700, Kevin Hilman wrote:
> Benoit Cousson <b-cousson@ti.com> writes:
>=20
> > From: Felipe Balbi <balbi@ti.com>
> >
> > With sparse IRQs the driver shouldn't depend at all on
> > any IRQ values coming from board-file.
> >
> > Remove every occurences of pdata->irq_base/end.
>=20
> Well, not quite *every*. :)
>=20
> If the driver isn't going to use those fields anymore, they should also
> be removed from the pdata struct too[1].  Also, the remaining board/init
> code that is initializing those fields should be removed as well[2], since
> it obviously has no effect.

indeed, but the idea was to decouple driver changes from arch/arm/*omap*
changes minimizing the oportunity of conflicts. So, e.g. on v3.4 we
change driver and on v3.5 we change board files.

--=20
balbi

--DheUW4aQn8WJk6WR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZ0u4AAoJEIaOsuA1yqRE5FAQAIODNfL1WfaI65K+PXR/0HSs
b1ar5XfBSrp9YNBOoFdKlxvn37XPsH5cFhBicg6Y0+Z5PvACC4tiVlsYu3nfeC2S
XUhrY3shKEyU6OhWefsB4udFBeiFmueTMxko5qFWCYu1tauiyiffW0fVIpXdCIpD
zHzuTsR3QDCYuI3MHLb4Aav33t96KUPMBrwH3t/POCVz9cG+5uVQwTnGDbRTscqZ
xFSImxIAaGu3jf8kCu3MeApck3+1WlB62ycOElZFO71u21r/2/aIH9uHOSFPskcu
1aG8Izjy+dsuNtbRG6sYTQ9dgHsj2MmyfFyUwMPesE0IsQcnLQ+4XimVyHO+sBFE
ed9YahyEuc2N3DnxYSuaiDd34fbf1C8ECJK7us1Efkk6h+3QltcDLTIkF7q1zhUz
pCZGOLvtNAKaFyBa9vcOPey7xCUZJJeUfpLm6ZSN1jiXl+OQ3Dm6M9BE4HW9f86v
5zw76gytyXZciHwVQPyjqhQqK9ZIyjOJ7HA+RepDhB5ENUabAk5semiO2XLNadbU
qUncPRCOFpd4rX6kCOmgmUPi0DDRu6aks9RQte+h5ZkcK1ZkP+9r28ZPIHfpFd85
Yw8EcQO1VtwMeQqIbakHVB72XMPkka+MdM/+QfvR1M3I6mfyEOkjgIreebe5nxXe
qdkM24LgMm5+HeHjc+hE
=DjCV
-----END PGP SIGNATURE-----

--DheUW4aQn8WJk6WR--
