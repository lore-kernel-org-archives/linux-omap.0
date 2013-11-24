From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH v2 1/3] power_supply: Add power_supply notifier
Date: Sun, 24 Nov 2013 18:02:13 +0100
Message-ID: <20131124170212.GB655@earth.universe>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-1-git-send-email-pali.rohar@gmail.com>
 <1384856285-19593-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384856285-19593-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz, Jenny TC <jenny.tc@intel.com>
List-Id: linux-omap@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 19, 2013 at 11:18:03AM +0100, Pali Roh=E1r wrote:
> This patch adds a notifier chain to the power_supply.
> This notifier helps drivers in other subsystem to listen to
> changes in power supply subsystem. This would help to take some
> actions in those drivers on changing the power supply properties.
> One such scenario is to increase/decrease system performance based
> on the battery capacity/voltage. Another scenario is to adjust the
> h/w peak current detection voltage/current thresholds based on battery
> voltage/capacity. The notifier helps drivers to listen to changes
> in power_suppy susbystem without polling the power_supply properties
>
> [...]

Tested-By: Sebastian Reichel <sre@debian.org>

-- Sebastian

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSkjEUAAoJENju1/PIO/qaFYsQAJ+B17D9R/fIyhFGnGu1um5i
wjHoCog12UuFX+vcf9de+u5nCsJXoQh+u6GbbnEaYP4QK1qtYUgaC15oPanjhZXt
0egujP2Sxx4wqaLB7uCjwysgg8boes5rUyklHgdPzyB6Wq4BD3ESdMVuTdMWkZvp
nYsbqXlF+V8FoQmhzvR1/9DTtFMUEsVJER474O72neARTt3uyR9tolNZFFe0N/Jx
LR0PmbT198DTjiBbcUgd6SDnv16IpQmrto0uDRXA8IbbH1RuUbgC4AvQVPoPxAZM
g7W0RDN5gTbK1N+W3bN8W9ceutF8MvpczHTsnnRUUQBgT48GkxQyyZcCPOdJp+2y
KL6FA0bHShQTvmD4xurN/fX01fodIvCjHB1bfqu8yjm2Dl80u91ORdw38+lKpSqZ
MirJ5vk9QDTfZER8t+1T7UMmi6bJhnHoPcSyQgZivOVT+i8pbIb3VgbLjf7gPvr2
dsCu4tCDmf2+wq65I1Py0HZL7asNQMNSFD8EnsjZbz9noiFG/GICMTWF8TkN3wA7
jOL5uRMpyFfAHKAYfVozUYcYVaB0ug6GRg7HBeazNzG0KbXrF2sLJwTgB71aql2I
xmK9dKd2BxPsmJjIv0M8gx7XYfXdEfWM3szXKYIcWMdxhEP+aCvAQXDmqsW55033
8PASNsCJ4XnAiZhwMoa8
=bGYu
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
