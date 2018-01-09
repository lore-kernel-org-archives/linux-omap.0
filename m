From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
Date: Tue, 9 Jan 2018 18:43:47 +0100
Message-ID: <20180109184347.28ba0a6e@aktux>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6059395284625569922=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171222124427.GI3374@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "H.
 Nikolaus Schaller" <hns@goldelico.com>, kernel@pyra-handheld.com, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6059395284625569922==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pEQl1CzGmESId=o.5bEznB6"; protocol="application/pgp-signature"

--Sig_/pEQl1CzGmESId=o.5bEznB6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Dec 2017 13:44:27 +0100
Johan Hovold <johan@kernel.org> wrote:

[...]
> I'd suggest reiterating the problem you're trying to solve and
> enumerating the previously discussed potential solutions in order to
> find a proper abstraction level for this (before getting lost in
> implementation details).
>=20
The main point here is in short words: Having a device powered on or off
when the uart it is attached to, is used or not used anymore,
so the already available userspace applications do not need to be changed.

I digged out a bit around:
alternative aproaches were:
adding hooks to the uart/tty layer:
https://marc.info/?l=3Dlinux-kernel&m=3D143333222014616&w=3D2
https://marc.info/?l=3Ddevicetree&m=3D143130955414580&w=3D2

I do not find it right now in my archive:
adding a virtual gpio for dtr to the omap_serial driver.
The driver behind the virtual io would then handle pm. One reason it was
rejected was that the devicetree should only contain real hardware and
not virtual stuff.

Regards,
Andreas

--Sig_/pEQl1CzGmESId=o.5bEznB6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEjNsZ3bHwkfCKTen3ifE1O/ULBjQFAlpU/1MACgkQifE1O/UL
BjTciw/8C3LRMdrbI6LWSLDOq8cLJB3ClyMWSG1gVpo4+lXr6yDw0jkBOo4GUJU+
PVngZhi/q5aJWD65I84xkJBYphAeVNhmMvWwrPj/RDWg5d8xWIlnY/0qOt6wDQ8r
eLcr7WzCjp89Uhe23noYyo1ioa+qGiiB+4s33/D/1mfZOWi9cM3nfrVDDpG16g49
uXyPEOhHUj7CVvhLVE3EQWlHifT2W2xULQ1iIZAq9ip7yEzr/C2t6d0JcfWYD2RW
qcXVGHptpTi9mM7L+OzKp3Th7SzlZxcqchOw0z3boL85o0gZNRaQ5hK5UHmYTORm
zvBcYD4s6RemnQtsOmtF2xGLc9oU2cTVS59kqxOiZE5KYyn17c/ftAbXS8Q5YLTz
bCI9Q4UPmLyEW1KFo8UbRIXJHy0OA3op17JFCkHTUFKOWqYZ4DXrhgfGr/CYAj4j
DHk2m74Z4QerCQoNLNLyAWduslMBmPzwPqBpRrM0/bbmSjlc9DZa5JxhH+GYoAfZ
4slaEVYwN3iaBn7U9MSB8JE8QQ6ZKL+cM+AUxtj/UnkGdraV5R42Lb7WP2z6Ej+h
qz7S7QaXIpD+r5yl0OHxVMAKIMcIQYDWOT/X9tzw9sCBLwJRoWeS+CF0wRsMaUit
vnt5EU/TwyefsoG9dEpUkDYHpO7xRpPeqorPqI1JjfdmAf9gsAs=
=W8y9
-----END PGP SIGNATURE-----

--Sig_/pEQl1CzGmESId=o.5bEznB6--


--===============6059395284625569922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6059395284625569922==--
