From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 18 Jan 2012 09:13:59 +0200
Message-ID: <1326870839.1954.23.camel@deskari>
References: <WC20120109124643.880164@terrafix.co.uk>
	 <20120110080849.5a242adf@notabene.brown>
	 <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	 <20120112095940.0a54413e@notabene.brown>
	 <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	 <20120113222045.37f9b4ec@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-4MxNCEe5wbxksWRKisZg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:54838 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753852Ab2ARHOH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 02:14:07 -0500
Received: by lahl5 with SMTP id l5so1830815lah.21
        for <linux-omap@vger.kernel.org>; Tue, 17 Jan 2012 23:14:03 -0800 (PST)
In-Reply-To: <20120113222045.37f9b4ec@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org


--=-4MxNCEe5wbxksWRKisZg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-13 at 22:20 +1100, NeilBrown wrote:
> Having CPUIDLE makes the DSS2 problem worse: lots of=20
>=20
> [   21.085113] omapdss DISPC error: SYNC_LOST on channel lcd,
> restarting the output with video overlays disabled
>=20
> messages whenever the CPU isn't busy.

I'm not sure if it is the case here, but DSS has restrictions about the
max DSS clocks on different OPPs. For example, on OMAP4430 LCD clock
maximum is 186MHz at OPP100, and 93MHz at OPP50. So it's a quite big
drop, causing problems with all but the rather small displays.

And the DSS driver doesn't have any support to handle this at the
moment, as there isn't support in the PM framework to do this. I think
the only way to handle this at the moment is for the DSS driver to set
an arbitrarily high constraint on, say, mem throughput, and hope that it
keeps the OMAP in the required OPP.

 Tomi


--=-4MxNCEe5wbxksWRKisZg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPFnE3AAoJEPo9qoy8lh71ho0P/0ScC1UhhUBIFnCkuyqw8Pk5
xWrHxTKOjl9Xm9SHrfbe1S5Zf4QxLf9zwjG+IAQ0wiDD41MYA2kBJpCx5RsIbrxt
N1zkf1c46r/C8GojMSkunYqe+iYrjXwiqrsvkH5/ExL/YNtJYL1K7iXOzaDQkGIu
lGA1UqUVkTvcUdZD9Yq2/CpRG4Xu5xAhJX6rRaUm6hh8XXhQbdceGdv6pU69uvid
iZuN0ce/VHZh3A/Za6aqrmuIr77idqG3PD4+FUNUkXWnjNngucXGYwN14YKMdK/w
WcXvhfJC+JnxrwkOiJGunu/8defdOf1VpzI3+2jIHLF1litPK5OU1neEM/HnJ+nk
rIfC2KZwG7njUPVFkEChmcfB5SPIv3zgB3oVSz28K+5jeTfvekwxcIbQrLVgcoIS
68DAInpzg0tnpUHCd4dtnZtAAsqkXcwwsLGehVYAFfykV9LtVr5AhjgLI/giPkAz
QpWqHzlLqkW6OEMunTYMivpesyUTktGwE6kYGm9Js+MiW8DTSBvvyF5CCe01mYK/
iuHee7e/KE5YLPF7UKbe/LuUZR2OMChYTrYlp2yEDmgHDVPbVMCjdE6RKh2AWi6A
Kv6ApcJnF0oMEvjg8Hsp7lsAlYBKEigQePjT4XJvkB2mqlBi2kv4t17sF78nUPFF
usNzVyKwJ3oKjXsDYbmr
=uxbL
-----END PGP SIGNATURE-----

--=-4MxNCEe5wbxksWRKisZg--

