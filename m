From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2 4/4] Bluetooth: btwilink: drop superseded driver
Date: Sun, 20 Oct 2019 22:59:01 +0200
Message-ID: <20191020205901.56bafijk7cu3rpaj@earth.universe>
References: <20191003134147.9458-1-sre@kernel.org>
 <20191003134147.9458-5-sre@kernel.org>
 <BC1F82AC-2988-4BC6-99EA-1C9F9289E582@holtmann.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="td6khbzgjxudi7vx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BC1F82AC-2988-4BC6-99EA-1C9F9289E582@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tony Lindgren <tony@atomide.com>, Adam Ford <aford173@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--td6khbzgjxudi7vx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 16, 2019 at 09:15:03PM +0200, Marcel Holtmann wrote:
> > All users of this driver have been converted to the serdev based
> > hci_ll driver. The unused driver can be safely dropped now.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > drivers/bluetooth/Kconfig    |  11 --
> > drivers/bluetooth/Makefile   |   1 -
> > drivers/bluetooth/btwilink.c | 337 -----------------------------------
> > 3 files changed, 349 deletions(-)
> > delete mode 100644 drivers/bluetooth/btwilink.c
>=20
> patch has been applied to bluetooth-next tree.
>=20
> However what I really like to see is that you re-introduce a
> btwilink driver that is purely serdev based and doesn=E2=80=99t rely on
> any hci_uart/hci_ldisc code. A clean serdev only driver is that
> best and easier to maintain long term.

So basically move the serdev implementation from hci_ll.c into its
own driver and make hci_ll hci_uart based only? That effectively
means, that we have two implementations of the protocol. I don't
think this will improve maintainability, since then bugs needs to
be fixed in two places? Note, that we have a couple of drivers
with serdev+hci_uart by now:

for file in $(grep -l serdev drivers/bluetooth/hci_*c) ; grep -l hci_uart_r=
egister_proto "${file}"
hci_bcm.c
hci_h5.c
hci_ldisc.c
hci_ll.c
hci_mrvl.c
hci_qca.c

-- Sebastian

--td6khbzgjxudi7vx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sypEACgkQ2O7X88g7
+pp5QQ/9HZr+yWBHDmBiphnMo30Xi90YCZ1Ov6RyGhUJWw2lvBcGkkHGCLuk8M/6
qvfk4YCI7zdqajXZkVSB7+dRp6QWkt4D5+B8ORjDC1zc103auFsIZmdTBn3c/8/O
Ed5DR6BKdGgtpdYxnsidYb3GJ5oMCHW9emRVJ603nUrbaipJTlEELjtyC8qemPtK
px9eTLAAD15WLhImFcq3vs9zP6mZV7EkTIgoIYAoUSJ6MQyapAeQbN19WTn7j+i8
YF3bB9+NCmM6Y2WJtuzBfq8n4B06OqSB8Yx2oNqRAFNlajIk7AnFwdU9JUj8rdYi
UrPzL+F0jzitbw0ES05xushHWmMXP+0I4XljEcjiq+UUd3/VkYYYegca+gXmTl+4
9DSQuITzpuhnKKgV7+VnlxIRg21KFrvC5Xib0BkDCYyTJq085hCq7b97aMlK/YJW
o04C9zu2vlvtFflQ5ENR5T/t7A6mSpUVcwCOme3o2AhhW7rWWrGZAhFhIq2PFxLp
9uOTquKl+WbW+rZM+Jx9RhrgGPivmEs+zFzV+bNESuLLcPB3v+b865NvRD+ESzZw
lFMocVKVE6zgwgy5UiX9/43dcBIdaPeSLdcgz1KoTt91ugDEwzLaaBMkeJjZtsdi
8qcw1yxVVk+sRBf4PgApEwvvaei+KF4AoNE59m4b5OIkZo4+bPQ=
=OkWc
-----END PGP SIGNATURE-----

--td6khbzgjxudi7vx--
