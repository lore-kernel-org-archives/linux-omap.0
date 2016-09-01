From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: fix HDMI LS_OE GPIO
Date: Thu, 1 Sep 2016 17:57:11 +0300
Message-ID: <cfa4ea2c-444c-a814-cbea-b183f4214c93@ti.com>
References: <1472737901-26494-1-git-send-email-tomi.valkeinen@ti.com>
 <b8647621-197c-97d5-8291-26c079e5eae8@ti.com>
 <CAOCHtYhF2KfeK3ccEzZcePbU5H1kwi1tKThZN3NRwXgPsW_bSA@mail.gmail.com>
 <c69aadbf-90e4-7aaf-2b90-4d5b543c252a@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2818405876791710039=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c69aadbf-90e4-7aaf-2b90-4d5b543c252a@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "beagleboard-x15@googlegroups.com" <beagleboard-x15@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============2818405876791710039==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SWemCujggbbdU5kkSdwuHO7JbK7msbkJo"

--SWemCujggbbdU5kkSdwuHO7JbK7msbkJo
Content-Type: multipart/mixed; boundary="tAgaGRQC3MgMdELDuseh5hItjAcMwwUKo";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "beagleboard-x15@googlegroups.com" <beagleboard-x15@googlegroups.com>
Message-ID: <cfa4ea2c-444c-a814-cbea-b183f4214c93@ti.com>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: fix HDMI LS_OE GPIO
References: <1472737901-26494-1-git-send-email-tomi.valkeinen@ti.com>
 <b8647621-197c-97d5-8291-26c079e5eae8@ti.com>
 <CAOCHtYhF2KfeK3ccEzZcePbU5H1kwi1tKThZN3NRwXgPsW_bSA@mail.gmail.com>
 <c69aadbf-90e4-7aaf-2b90-4d5b543c252a@ti.com>
In-Reply-To: <c69aadbf-90e4-7aaf-2b90-4d5b543c252a@ti.com>

--tAgaGRQC3MgMdELDuseh5hItjAcMwwUKo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/16 17:14, Nishanth Menon wrote:

>>> I believe we have A2s being shipped as well. we dont want to break A2=
s
>>> either -> I propose we refactor the dts to introduce revb1 X15.
>>
>> There are at-least 200 A2's that have been shipped to end users.
>>
>> http://uk.rs-online.com/web/p/processor-microcontroller-development-ki=
ts/8874764/
>>
>=20
>=20
> Thanks. Tomi: if you are ok - I already do have a refactoring code from=

> older kernel. I will rebase to latest and repost.

Sounds good to me.

 Tomi


--tAgaGRQC3MgMdELDuseh5hItjAcMwwUKo--

--SWemCujggbbdU5kkSdwuHO7JbK7msbkJo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyEHIAAoJEPo9qoy8lh715NcP/0RZ1RkcabANUpkBiE5LNpcD
zLXrJSqN/rNXxEHjq6KenVz1B8EAuat51RLRLHKJKoYBYYUxqlVZPVxeGw2tRhtx
DF6W/2DaHlDiF97yHdvcFSKwzZMWpbWP4GyagJuj6m/J2yYzjKDjvgXD6BdvN1lv
U2RB/DKBdoiN3GAD4Nur1zYWAGniCUpkaRwpFNeWK/ZMsl9CiHhw2GmOq/5RTL9S
br89cyYHEGY7MMs/MBN3GHE1b97fpsWfeqXXqqAZUibA5Qm8dC/+MotnfUE91sSp
3Q2Hrck6GlMwA/ZNkXOZYC9lysi6wt+YnBIfSMogjZdqYjQwshjyCLswgXlh2FJG
Ydr30GJDCBxPeyd1J1W7DU407tKYL/GakkwZ7flM/ia3ppHbxhHSQ7VZGAMuzZze
xd05Vm/SoV+ArJLbILrE6LFfytOApq3RempUsrZKAO3cEHiHhuPqSWllpZvELGy/
IRgv9IkewGCKV4lBexxw3lBrhb1RN71em1ca1kNYw7rwRaFf6WgyiuzupvrOXnau
paNY7w5ItosW2YPnXnzwamesUJEObi8763r2TUlgGR8vzEsfYFTcliY/r1kgglbo
cMFvBMH7zZGgzCt9u9cYc5fHf/kmf3+g5cFwL4Rf9jwv7sS/RIWghb4QQhGAU/3R
CkR81Nq+NOEvuAGXxdMC
=dDEt
-----END PGP SIGNATURE-----

--SWemCujggbbdU5kkSdwuHO7JbK7msbkJo--


--===============2818405876791710039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2818405876791710039==--
