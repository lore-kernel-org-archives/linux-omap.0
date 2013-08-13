From: Sebastian Reichel <sre@ring0.de>
Subject: Re: RX51: kernel message spam from CPUfreq driver
Date: Tue, 13 Aug 2013 14:25:51 +0200
Message-ID: <20130813122551.GA10082@earth.universe>
References: <20130811141336.GA24034@earth.universe>
 <520880C8.1040907@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:53337 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757351Ab3HMMZ4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 08:25:56 -0400
Content-Disposition: inline
In-Reply-To: <520880C8.1040907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 12, 2013 at 11:59:28AM +0530, Rajendra Nayak wrote:
> Whats the system clock frequency used on RX-51? I guess omap2_dpll_round_=
rate()
> for some reason thinks that with the given sys clock its not possible to
> lock the DPLL at 125Mhz. If you can send the debug logs from omap2_dpll_r=
ound_rate()
> that should probably help know whats going wrong.

It's also not possible to lock the DPLL at other frequencies. During
the boot process at least 125MHz, 250MHz and 550MHz cannot be locked.

I uploaded a full serial dump from the n900 with debug output from=20
omap2_dpll_round_rate to the following url:

http://paste.debian.net/24628/

-- Sebastian

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSCiXOAAoJENju1/PIO/qadrUQAICF+98rWyGo96Z/spZr1Ky0
BD0N8qhWdc1USD5XrR8OIQRogrJlVVVmisx9JNS3H56xGaK7JK4CpskicHqY8Kl9
Rna7EvWFuQSUMJwRvNTtLqzfRqQvxZOpFuw9v3v7Nvn/OTT/mEVRda6YrLDtarG0
3QczqWZCTUqypx+UtDpSaVNh2CNyE9b5TZA3vTjK+vjJP/NG6qHezLNeAfYRki4O
J/d6HgOekWvGXtBZBEiDRbRnqg6MqfqJM05DAqXiiUDXhrEqqV9/Kl2/d5ZHDiPQ
paEPCfIwNdgmH1h1PsZHgcDN9xDfctLH2Fm8gpjqY1jw+uVR9WfCoDGFNDD2dcDH
u80d+AVsKMx4/BXpOkEIzoQxsS/PP50xwb3ot8D8UoxyDukD03bVnAOWMxLgik57
L82zJUAJhodY+L58xCtUT+HudDVEGNP+KUuZjqqto6ETsAnYl+glKGIvuq3QMUGb
8mkp4AwJc7KpHwPs4HKP2oIV/xlq0xyFPl9mULOF1NDvnl4vr9vo4LVkeJnR9VRN
qXrsFtOnwyoecfxU1ErVtosk30+ZwpEhcD3VR2APuIPkYH0sNGOIuMFB8U6FjsVW
J+IK7Ig+n3lRiVTV3jdGBD4oCPRTCAlzMPK9c2R+uTIXGG0SqFuldwWc6Ea546ua
HjpTY0EDDrA2V79KRB3n
=85Vn
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
