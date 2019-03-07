From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
Date: Thu, 7 Mar 2019 21:58:14 +0100
Message-ID: <20190307205814.GB950@kunai>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
 <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
 <20180430092947.GC2270@ulmo>
 <CAHCN7xLBa0JxcUs9i6Rr3hUNe5zymfb66icqNK0N3PMo51T-TA@mail.gmail.com>
 <20190307201807.GA950@kunai>
 <e7cadedc-b8ca-36d5-88dd-447fbeaac27a@metux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e7cadedc-b8ca-36d5-88dd-447fbeaac27a@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Adam Ford <aford173@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Hoan Tran <hotran@apm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Michal Simek <michal.simek@xilinx.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 09:53:50PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> On 07.03.19 21:18, Wolfram Sang wrote:
> >=20
> >> It's been almost a year later, and several Linux revisions, and this
> >> still seems stuck somewhere/somehow.
> >=20
> > I wanted to respin this series once rc1 is released.
> >=20
> Maybe just rebase and repost ?

Then I'd miss all the new drivers which may need this fixed. Coccinelle
makes respinning a breeze, so no problem with that.


--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyBheIACgkQFA3kzBSg
KbZj9Q/7BfZMRib+CTRXwFZJ3DHfp+wLWcSFipubqzbJkW8tAqgjyYR4X56NSUOo
lwaQ5ymhPZuHGYSPYWBhxLKZSVzVyR1XeTyn7+LLctnA2rtfPS5VxXkbYRdAOsdW
gqRCUiyz5FCuskho/7JwO82N2UBPyH+aOnhkA7nD7Xk2GoFcJXzG7nA/ECqvYOrm
s6PXZb3tYdTmeT1n5t2AA7GrD3z0U6501rulyi+fTfC5L0cE9vX/vWWZe4H1Pi6S
rGKl555Oa4tvXGYcJ2GJQXcbk9Mc2Csgch/jWR3d9mg9L5dVmVrkh1meZA/6VEgT
H/2qvV03XFyCpr9wCOghH/d7LE72MTjWRSlmEKHG52fgYV1+HQrMFGc3OPn+GU6Q
NN9IYpmVGHe0joajA638iPn+EGE+twimvV8vBDvNNXKubt7nxuFxfMNhdnQ7ZmnJ
XTeG4jMiWZx2zOnZc5J2CjKib1mPTtvViI7lLF29t3A19gTst37bsWhZJ31lyh3M
rH6qMapWa9hbkbZikW1EmP1aFRgQAv0xbzq7FnHRppqKkFNNAvQZ+tL8Gm33nUww
1wkTzDJjJljc4/kkkViSKTX+F8TGW6eUcI3upBktCvdI6j/A47wi5c5oZZ8x+dDs
uEIWFWfOkZxPnUGhly24Sd1y4O1sHBnbTwkW+793MERzqD4LwYk=
=4j4A
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
