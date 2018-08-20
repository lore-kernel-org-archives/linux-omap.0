From: Alban <albeu@free.fr>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Date: Tue, 21 Aug 2018 00:53:27 +0200
Message-ID: <20180821005327.0d312a85@tock>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fTOdtudVp=.496+uJLgFm7d"; protocol="application/pgp-signature"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180819184609.6dcdbb9a@bbrezillon>
Sender: netdev-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Aban Bedel <albeu@free.fr>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan
List-Id: linux-omap@vger.kernel.org

--Sig_/fTOdtudVp=.496+uJLgFm7d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Aug 2018 18:46:09 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Sun, 19 Aug 2018 13:31:06 +0200
> Alban <albeu@free.fr> wrote:
>=20
> > On Fri, 17 Aug 2018 18:27:20 +0200
> > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> >  =20
> > > Hi Bartosz,
> > >=20
> > > On Fri, 10 Aug 2018 10:05:03 +0200
> > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >    =20
> > > > From: Alban Bedel <albeu@free.fr>
> > > >=20
> > > > Allow drivers that use the nvmem API to read data stored on MTD dev=
ices.
> > > > For this the mtd devices are registered as read-only NVMEM provider=
s.
> > > >=20
> > > > Signed-off-by: Alban Bedel <albeu@free.fr>
> > > > [Bartosz:
> > > >   - use the managed variant of nvmem_register(),
> > > >   - set the nvmem name]
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>     =
=20
> > >=20
> > > What happened to the 2 other patches of Alban's series? I'd really
> > > like the DT case to be handled/agreed on in the same patchset, but
> > > IIRC, Alban and Srinivas disagreed on how this should be represented.
> > > I hope this time we'll come to an agreement, because the MTD <-> NVMEM
> > > glue has been floating around for quite some time...   =20
> >=20
> > These other patches were to fix what I consider a fundamental flaw in
> > the generic NVMEM bindings, however we couldn't agree on this point.
> > Bartosz later contacted me to take over this series and I suggested to
> > just change the MTD NVMEM binding to use a compatible string on the
> > NVMEM cells as an alternative solution to fix the clash with the old
> > style MTD partition.
> >=20
> > However all this has no impact on the code needed to add NVMEM support
> > to MTD, so the above patch didn't change at all. =20
>=20
> It does have an impact on the supported binding though.
> nvmem->dev.of_node is automatically assigned to mtd->dev.of_node, which
> means people will be able to define their NVMEM cells directly under
> the MTD device and reference them from other nodes (even if it's not
> documented), and as you said, it conflict with the old MTD partition
> bindings. So we'd better agree on this binding before merging this
> patch.

Unless the nvmem cell node has a compatible string, then it won't be
considered as a partition by the MTD code. That is were the clash is,
both bindings allow free named child nodes without a compatible string.

> I see several options:
>=20
> 1/ provide a way to tell the NVMEM framework not to use parent->of_node
>    even if it's !=3D NULL. This way we really don't support defining
>    NVMEM cells in the DT, and also don't support referencing the nvmem
>    device using a phandle.

I really don't get what the point of this would be. Make the whole API
useless?

> 2/ define a new binding where all nvmem-cells are placed in an
>    "nvmem" subnode (just like we have this "partitions" subnode for
>    partitions), and then add a config->of_node field so that the
>    nvmem provider can explicitly specify the DT node representing the
>    nvmem device. We'll also need to set this field to ERR_PTR(-ENOENT)
>    in case this node does not exist so that the nvmem framework knows
>    that it should not assign nvmem->dev.of_node to parent->of_node

This is not good. First the NVMEM device is only a virtual concept of
the Linux kernel, it has no place in the DT. Secondly the NVMEM
provider (here the MTD device) then has to manually parse its DT node to
find this subnode, pass it to the NVMEM framework to later again
resolve it back to the MTD device. Not very complex but still a lot of
useless code, just registering the MTD device is a lot simpler and much
more inline with most other kernel API that register a "service"
available from a device.

> 3/ only declare partitions as nvmem providers. This would solve the
>    problem we have with partitions defined in the DT since
>    defining sub-partitions in the DT is not (yet?) supported and
>    partition nodes are supposed to be leaf nodes. Still, I'm not a big
>    fan of this solution because it will prevent us from supporting
>    sub-partitions if we ever want/need to.

That sound like a poor workaround. Remember that this problem could
appear with any device that has a binding that use child nodes.

> 4/ Add a ->of_xlate() hook that would be called if present by the
>    framework instead of using the default parsing we have right now.

That is a bit cleaner, but I don't think it would be worse the
complexity. Furthermore xlate functions are more about converting
from hardware parameters to internal kernel representation than to hide
extra DT parsing.

> 5/ Tell the nvmem framework the name of the subnode containing nvmem
>    cell definitions (if NULL that means cells are directly defined
>    under the nvmem provider node). We would set it to "nvmem-cells" (or
>    whatever you like) for the MTD case.

If so please match on compatible and not on the node name.

6/ Extend the current NVMEM cell lookup to check if the parent node of
the cell has a compatible string set to "nvmem-cells". If it doesn't it
mean we have the current binding and this node is the NVMEM device. If
it does the device node is just the next parent. This is trivial to
implement (literally 2 lines of code) and cover all the cases currently
known.

7/ Just add a compatible string to the nvmem cell. No code change is
needed, however as the nvmem cells have an address space (the offset in
byte in the storage) it might still clash with another address space
used by the main device biding (for example a number of child
functions).

> There are probably other options (some were proposed by Alban and
> Srinivas already), but I'd like to get this sorted out before we merge
> this patch.
>=20
> Alban, Srinivas, any opinion?

My preference goes to 6/ as it is trivial to implement, solves all
known shortcomings and is backward compatible with the current binding.
All other solutions have limitations and/or require too complex
implementations compared to what they try to solve.

Alban

--Sig_/fTOdtudVp=.496+uJLgFm7d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbe0ZnAAoJEHSUmkuduC289scQAOXFzKlPD8+XMV3afPc7azN0
mN8Gl+uZod6rFdLhNG5SKe1KV3sUULyNNbZq+NfS559CK0SG7NWrslLLmLZK2YL/
ivPFXppo8rLCvk6U7u4LCUVbCk0X1DDgnvgt0vtvF/7QzQOxOT6Wh6DHeKQmI7pP
x9/8Cncga2H8NFkZuBsVU91OExsLNDSBg+igIH/uat4MFBblFE42ZvBu5TPfnB4b
8bJ663P0T0C+WcQGJzOxO82146tusPdstAZgY05TyBLoomhU6sJzmv3ouAOswOyo
l/MYd5fVgXekGXpQOrw5VHFWRgcErfg0gdFrHlYByMiu08fc8cvARiYEjwT05M39
rxFP/1fjoVleqdZ5WSAxme1fygbIP5LjHaJcKeNIRusYPZuz7WVid0Ht4GXA7ure
2yr7DCrB3/HQAMBeGS7WJ3Xw+HphqPtKjZin2vSbWk6webtfUaxvwBVJRcqCGVjD
/hFyQhtP44NxpWSRQClRrQ5+wH1kz7S1jfNrgtv7T0A8RaNJ4xZDYUliwLVM9uD2
xrU9++6s4atq5vX93V3Iq5tXxZ5GThHY8z4kG9GX9sVIYfWEVKl64P3tB+ycjc0N
ecJmDO/LhI9s5HzoaY0XJ2Oq1cvqO09Mc0DdADs17UlQ5HQRTKjrLq0Nd5BkUu1+
fVmGaEuVW8MyxWMFWgs8
=9TLP
-----END PGP SIGNATURE-----

--Sig_/fTOdtudVp=.496+uJLgFm7d--
