From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
Date: Mon, 6 May 2013 20:23:13 -0400
Message-ID: <51884971.9050508@ti.com>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
 <20130506223653.GA12089@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0912381066301832574=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130506223653.GA12089@obsidianresearch.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Russell King <linux@arm.linux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, tony@atomide.com, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0912381066301832574==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2EAAKNRALDJVHSFIXMWNU"

------enig2EAAKNRALDJVHSFIXMWNU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06-05-2013 18:36, Jason Gunthorpe wrote:
> On Tue, May 07, 2013 at 12:34:13AM +0300, Aaro Koskinen wrote:
>> On Mon, May 06, 2013 at 05:00:56PM -0400, Eduardo Valentin wrote:
>>> Introduce HAS_BANDGAP config entry. This config is a
>>> boolean value so that arch code can flag is they
>>> feature a bandgap device.
>>
>> Maybe it could be mentioned that omap-thermal already depend on this?
>> At least for a random reviewer it was not immediately clear why this i=
s
>> added, especially since there were no users for it in subsequent patch=
es.
>=20
> I looked (very briefly), and it seemed like omap-thermal is self
> contained and doesn't need arch support?
>=20

It is. At least I tried to make it, at least to the extenstion I could ge=
t.

> I get the impression it is desired to minimize driver kconfig
> dependencies to the minimum required to compile to increase build
> testing coverage, so maybe it would be appropriate to drop this
> entirely?
>=20

Well, it is also desired to compile things to the correct target right?
Thats the idea behind this config option. It follows the same design as
CONFIG_ARCH_HAS_CPUFREQ, for instance.

> Jason
>=20
>=20



------enig2EAAKNRALDJVHSFIXMWNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGISXEACgkQCXcVR3XQvP2GpgEAgnqZgHFcKy9T7f2uO57WcFrq
w4XfekxJfXM1JCrRKWMBAOzCTYLNVb02G+ILWtM9fw4h2A9OXrpgvn7MNqZkG8ll
=3ZQ/
-----END PGP SIGNATURE-----

------enig2EAAKNRALDJVHSFIXMWNU--


--===============0912381066301832574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0912381066301832574==--
