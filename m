From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] Bluetooth: hci_ll: set operational frequency earlier
Date: Tue, 1 Oct 2019 00:33:56 +0200
Message-ID: <20190930223356.z6tiv4v5yrqtzu2t@earth.universe>
References: <CAHCN7xLOCC00UC4PB3vHa6Q7yyhXVEaWgx2X9D9L2dDubd_5fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2906506813605606971=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHCN7xLOCC00UC4PB3vHa6Q7yyhXVEaWgx2X9D9L2dDubd_5fA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, Philipp Puschmann <philipp.puschmann@emlix.com>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============2906506813605606971==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="niqozkc3jiirtp7i"
Content-Disposition: inline


--niqozkc3jiirtp7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 30, 2019 at 03:10:18PM -0500, Adam Ford wrote:
> Is anyone else having issues with the hci_ll after a2e02f38eff8
> ("Bluetooth: hci_ll: set operational frequency earlier") was applied?
>=20
> I have an i.MX6Q with a WL1837MOD attached to UART2. After this patch
> I git a bunch of timeouts when initializing the device using the 5.3
> and 5.3.1 kernel.   I know a bunch of omap and imx users have done
> some various tests over the years, so I thought I'd ask.
>=20
> [  195.911836] Bluetooth: hci0: command 0xff36 tx timeout
> [  206.071837] Bluetooth: hci0: command 0x1001 tx timeout
> [  214.231862] Bluetooth: hci0: Reading TI version information failed (-1=
10)
> [  214.238712] Bluetooth: hci0: download firmware failed, retrying...
> [  216.391834] Bluetooth: hci0: command 0xff36 tx timeout
> [  226.551843] Bluetooth: hci0: command 0x1001 tx timeout
> [  234.711856] Bluetooth: hci0: Reading TI version information failed (-1=
10)
> [  234.718705] Bluetooth: hci0: download firmware failed, retrying...
> [  236.871832] Bluetooth: hci0: command 0xff36 tx timeout
> [  247.031837] Bluetooth: hci0: command 0x1001 tx timeout
> [  255.191852] Bluetooth: hci0: Reading TI version information failed (-1=
10)
> [  255.198706] Bluetooth: hci0: download firmware failed, retrying...
>
> Can't init device hci0: Connection timed out (110)

I can see the same messages on OMAP4+WL1285 based Motorola Droid 4
(with the same commands resulting in a timeout).

> Revering this patch fixes the issue,

Ack.

> and subsequent patch proposals form Philipp haven't seemed
> to fix the issues for me on 5.3.

I did not do any further tests, just noticed this while working
on another patchset.

-- Sebastian

--niqozkc3jiirtp7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2SgtEACgkQ2O7X88g7
+po4/g/+IGM3j5jfpYzr+RYoNYjBkQPYgwWojq8LpIwfihDVFs6NCfjt3f1G0aJ+
zDczVpLC/Pnj6ltnfliLUAuyhOM94+unB/yOCKtKIwSWMX+wgofyITm6rSxlAM0n
SoqgY5TkNXUBv0wMoJse+6wqOBsMZ/mJg6vpP7L2IjP5s668MgoD4wPADi4mJ0p7
9L68Of5PodwjXMnTQG8FiMezaetSiLGNtFBFBnRY8R499AhldpDf/uDSafaFNNyg
U+K4fBYhFFcYECQI3UvFD6vhytH49dSzOByCNjLsf0je7g92qbm1bZV0FomTuFrJ
ni5px6yFV+svNgo+w+n+jFrDpzutkU91jp/TGJpGDHb2QaztQ8gGHb/R68ZkFPko
y9r4f3y6N6d44oJnxpEPerDw0jKyfNQ3HbLZNqHTWQPOLqVy9V3S4WGF9AZ5fgWG
Jd0tkAh2mjryNjwKv6z0JnNA6PBMSyle0C1wdwxExL2QNqmNKf6C16ada2N32anb
QqYKj/UcA86Qad0rDwdY8KLj784/7+1yUgO+LUtv3ZYv9lUgbHcb1EB+/5jaNOvv
X17dW2bTu+RXYefM3Uq/DI2wxSg6umFfjCmou/yJiqa7O8yfkmzGlmywNBESCRfZ
TcUjqJROSUaYKi6JZwsuaBsMqgeMlfsk97HgBkVF8RxiDTtNEiQ=
=P+sU
-----END PGP SIGNATURE-----

--niqozkc3jiirtp7i--


--===============2906506813605606971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2906506813605606971==--
