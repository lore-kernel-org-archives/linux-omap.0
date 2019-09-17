From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH 2/2] DTS: ARM: gta04: introduce legacy spi-cs-high to make display work again
Date: Tue, 17 Sep 2019 16:26:15 +0200
Message-ID: <1624298A-C51B-418A-96C3-EA09367A010D@goldelico.com>
References: <cover.1562597164.git.hns@goldelico.com> <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com> <20190724194259.GA25847@bogus> <2EA06398-E45B-481B-9A26-4DD2E043BF9C@goldelico.com> <CAL_JsqLe_Y9Z6MRt7ojgSVKAb9n95S8j=eGidSVNz2T83j-zPQ@mail.gmail.com> <CACRpkdY0AVnkRa8sV_Z54qfX9SYufvaYYhU0k2+LitXo0sLx2w@mail.gmail.com> <20190831084852.5e726cfa@aktux> <ED6A6797-D1F9-473B-ABFF-B6951A924BC1@goldelico.com> <CACRpkdZQgPVvB=78vOFsHe5n45Vwe4N6JJOcm1_vz5FbAw9CYA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZQgPVvB=78vOFsHe5n45Vwe4N6JJOcm1_vz5FbAw9CYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hi Lunus,

> Am 17.09.2019 um 00:52 schrieb Linus Walleij =
<linus.walleij@linaro.org>:
>=20
> On Mon, Sep 16, 2019 at 12:59 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>=20
>> ping.
>>=20
>> Device omap3-gta04 is neither working with v5.3 nor linux-next quite =
a while and we need a solution.
>=20
> Can't we just apply the last part of the patch in this thread:
>=20
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi
> b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 9a9a29fe88ec..47bab8e1040e 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -124,6 +124,7 @@
>                        spi-max-frequency =3D <100000>;
>                        spi-cpol;
>                        spi-cpha;
> +                       spi-cs-high;
>=20
>                        backlight=3D <&backlight>;
>                        label =3D "lcd";
>=20
>=20
> Surely this fixes the problem?

yes, it is a workaround, but appears to violate some policies.
E.g. the spi-cs-high; is undocumented but DT bindings maintainer
seems to be against documenting it as I had proposed in my
other patch.

Rather he seems to have proposed a white-list in the driver code.
So that the legacy mode is only becoming active for those systems
which really need the legacy mode instead of everyone.

Then, we do not need this patch for GTA04.

So its up to you to decide which way to go. We are happy with
any one that makes mainline work again asap...

BR and thanks,
Nikolaus
