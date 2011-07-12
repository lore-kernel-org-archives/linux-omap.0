From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: omap2430: handle charger OTG xceiver event
Date: Tue, 12 Jul 2011 09:01:28 +0300
Message-ID: <20110712060126.GB2588@legolas.emea.dhcp.ti.com>
References: <1310424197-22909-1-git-send-email-dima@android.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50843 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753973Ab1GLGBf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jul 2011 02:01:35 -0400
Content-Disposition: inline
In-Reply-To: <1310424197-22909-1-git-send-email-dima@android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dima Zavin <dima@android.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 11, 2011 at 03:43:17PM -0700, Dima Zavin wrote:
> Set a flag on OTG charger event and check it on cable
> remove event (i.e. USB_EVENT_NONE). This way we will
> not need to power up the PHY when an external charger

s/PHY/LINK

> is detected by the transceiver itself.

=2E.. your logic is inversed. Link shouldn't be powered up to start with.
We should only power up the Link after we know it *will* be needed. The
way you're doing this is:

connect cable -> resume PHY -> resume Link -> if is_charger suspend
Link.

Where it should be:

connect cable -> resume PHY -> if is_charger goto done.

Now, to make a generic solution (which is what we want in the long run)
we still need a few changes on the OTG support and otg_transceiver on
Linux.

--=20
balbi

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOG+M2AAoJEAv8Txj19kN1vxEIAJjYBGfb3zlSsOzkFQR2TMNG
WeciDSmPOF+iHqrfrNMDzg26VE5hf8h4eeyGO3NTRMYdAuIa6zZXFmHHHlKVQmVr
qPWsgc4/pmZdZ0SPVC/F9XPySu2kdIEadPoDNE7inxoqQnaPuMcTW4+kHat2wxPc
xf9xEdDMDC/htYL1JE0qReRpriVDHjmzUvgfcigTMWkTtDd14Ib1Kb7gPeA9EmId
MDdInZupsErKzBAWgaCgiSbEkE+ohMWrfI4rAnaClt/cU6wP5xT9HZZ77UDxgxwe
bGCRSt1azrUZ1SzJGFuJDRdPmaNVmLtiU92SJFEcxvm4gEBAWHnF7NOEOh3Ohtc=
=mrJI
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
