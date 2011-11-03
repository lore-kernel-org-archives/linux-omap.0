From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Linux 3.0 DSS support
Date: Thu, 03 Nov 2011 11:46:18 +0200
Message-ID: <1320313578.1859.55.camel@deskari>
References: <CANLagX8WaHGkqOZ2UnLR1ihOABbdDy1ZAyW19yO=f-JNUaLKfw@mail.gmail.com>
	 <4E9BD71A.90703@ti.com>  <4EA5A677.3050704@logicpd.com>
	 <1319528229.1684.20.camel@lappyti>
	 <49A85CFF-CB0B-435C-BB54-12D247ABB6BE@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2w8SL13W62f6VQObPrQv"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:36136 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754452Ab1KCJq2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 05:46:28 -0400
Received: by mail-bw0-f50.google.com with SMTP id zu17so943762bkb.9
        for <linux-omap@vger.kernel.org>; Thu, 03 Nov 2011 02:46:27 -0700 (PDT)
In-Reply-To: <49A85CFF-CB0B-435C-BB54-12D247ABB6BE@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Peter Barada <peter.barada@logicpd.com>, Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--=-2w8SL13W62f6VQObPrQv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-11-03 at 10:35 +0100, Koen Kooi wrote:
> Op 25 okt. 2011, om 09:37 heeft Tomi Valkeinen het volgende geschreven:
>=20
> > Hi,
> >=20
> > On Mon, 2011-10-24 at 13:55 -0400, Peter Barada wrote:
> >>=20
> >> In the above case (and my case where I'm looking for a 9Mhz pixel=20
> >> clock), fck_div is calculated at higher than 16 - and the video
> >> output=20
> >> is wrong (i.e. no pixel clock and hsync runs at 32x the requested
> >> rate).=20
> >=20
> > DM37x TRM says:
> >=20
> > "DSS1_ALWON_FCLK: Issued from DPLL4. Its frequency can be a division by
> > 1 to 16 of the frequency of the DPLL4 synthesized clock."
> >=20
> > I take it that DM37x is detected as cpu_is_3630()?
> >=20
> > The DSS driver currently handles only OMAPs, so for other SoCs the
> > driver may contain lots of bugs like this.
>=20
> dm3730 is just a different marketing name for omap3630, it should not hav=
e any functional changes.

According to the TRM and experiments by Peter, it does.

 Tomi


--=-2w8SL13W62f6VQObPrQv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOsmLqAAoJEPo9qoy8lh71fBEQAJX9j2FznCnhAIQMyp8LWxXi
eL8p2+67pgqR1kHCiPxbPKUhFVgLDids3Hdf/9NPpsGPSKpOLx/G4dPnAOtB+8fx
cY0ESTxVGj6VcJ2pw6KASuJA5yBEjtxXQPmf55AbwwSCiJEPqQJVqu45+ehePF/4
5AcbB2xREtHkkdgR9r/VuR9ywp7PpALXMz/jkArV1ZTAvmtpyNcrX+LYITDigLXJ
C9WA8UujOZwZJ3sAhhngpslViFgKscLh/d9TL8tU/82yJCzDPLP1jr+hc6yprj+u
7z+FP2V5ksOn2t6HEl01heVrKJPoBfWSXlK2VxFDRsZxluXjmDv9/CGYWBNBwaP5
UAfLmzrMSA1WchCYLHAcvWYg6Z4VsQKeBzM7AloM3NzS4rHgGFQQS+XURj8loDP9
9PmLixD/ZAt6ERi+3BsqiPTE6unPaiOf3eRxnkbny1yHGWtvi/arbrE9m11gT99n
IvLB5bFVHXsa6wakKan9knEHRTV+mWIam+Akq7XfOfS4nz63PNq8GwjPn4Y9YLoV
YSYVQ8f4TDz3C1oG4rG1y1XScfeyMNrb+q7jxe3qi2chHsG4WIYpHdm5Dqkq0H+Y
BHQUmEuwnsisOtoZRLunlli6g4/AGsM9KPw9GmpbOREpUo1lscVyuue355h3E52R
ZoKFRGZkby1LytPHr4v8
=T631
-----END PGP SIGNATURE-----

--=-2w8SL13W62f6VQObPrQv--

