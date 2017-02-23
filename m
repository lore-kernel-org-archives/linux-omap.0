From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 5/8] dt-bindings: input: move ads7846 bindings to touchscreen subdirectory
Date: Thu, 23 Feb 2017 10:54:04 +0100
Message-ID: <484A61F4-72F5-4236-8ADF-A4921EC0E6B0@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <cover.1482936802.git.hns@goldelico.com> <07298be658b70f006e6598e7888dd5b5f304f65c.1482936802.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <07298be658b70f006e6598e7888dd5b5f304f65c.1482936802.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, linux-iio@vger.kernel.org, kernel@pyra-handheld.com, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Ro
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,
this patch from the series seems to have been lost in the other =
discussions.
It is just moving a bindings document to where it should be.
I don't know if it should go through your git.
BR and thanks,
Nikolaus

> Am 28.12.2016 um 15:53 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Documentation/devicetree/bindings/input/{ =3D> =
touchscreen}/ads7846.txt | 0
> 1 file changed, 0 insertions(+), 0 deletions(-)
> rename Documentation/devicetree/bindings/input/{ =3D> =
touchscreen}/ads7846.txt (100%)
>=20
> diff --git a/Documentation/devicetree/bindings/input/ads7846.txt =
b/Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/input/ads7846.txt
> rename to =
Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
> --=20
> 2.7.3
>=20
