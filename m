From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
Date: Mon, 6 May 2013 20:20:16 -0400
Message-ID: <518848C0.2020808@ti.com>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <5188212D.3030904@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8131715160548579829=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5188212D.3030904@wwwdotorg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>, tony@atomide.com, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8131715160548579829==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2NXHNXUMXQXHPKVCUCSQC"

------enig2NXHNXUMXQXHPKVCUCSQC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06-05-2013 17:31, Stephen Warren wrote:
> On 05/06/2013 03:00 PM, Eduardo Valentin wrote:
>> Introduce HAS_BANDGAP config entry. This config is a
>> boolean value so that arch code can flag is they
>> feature a bandgap device.
>=20
> What does this patch have to do with device tree (there's "dts" in the
> subject)? What's a BANDGAP device?
>=20
>=20
In fact, this one has nothing to do with DT. dts in the title is a typo..=





------enig2NXHNXUMXQXHPKVCUCSQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGISMAACgkQCXcVR3XQvP3S1QD/WHvBdG04DHsv66nQnrJ2Sdum
ABTkgeWhZfFVeUzJMv0A/i+m4TpvsVlpK2NdUuDO3IkxF0DGKxbsCaH4IaejVXtf
=b43u
-----END PGP SIGNATURE-----

------enig2NXHNXUMXQXHPKVCUCSQC--


--===============8131715160548579829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8131715160548579829==--
