From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [Letux-kernel] [PATCH 2/2] DTS: ARM: gta04: introduce legacy
 spi-cs-high to make display work again
Date: Tue, 17 Sep 2019 00:52:39 +0200
Message-ID: <CACRpkdZQgPVvB=78vOFsHe5n45Vwe4N6JJOcm1_vz5FbAw9CYA@mail.gmail.com>
References: <cover.1562597164.git.hns@goldelico.com> <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com>
 <20190724194259.GA25847@bogus> <2EA06398-E45B-481B-9A26-4DD2E043BF9C@goldelico.com>
 <CAL_JsqLe_Y9Z6MRt7ojgSVKAb9n95S8j=eGidSVNz2T83j-zPQ@mail.gmail.com>
 <CACRpkdY0AVnkRa8sV_Z54qfX9SYufvaYYhU0k2+LitXo0sLx2w@mail.gmail.com>
 <20190831084852.5e726cfa@aktux> <ED6A6797-D1F9-473B-ABFF-B6951A924BC1@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <ED6A6797-D1F9-473B-ABFF-B6951A924BC1@goldelico.com>
Sender: stable-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 16, 2019 at 12:59 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> ping.
>
> Device omap3-gta04 is neither working with v5.3 nor linux-next quite a while and we need a solution.

Can't we just apply the last part of the patch in this thread:

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi
b/arch/arm/boot/dts/omap3-gta04.dtsi
index 9a9a29fe88ec..47bab8e1040e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -124,6 +124,7 @@
                        spi-max-frequency = <100000>;
                        spi-cpol;
                        spi-cpha;
+                       spi-cs-high;

                        backlight= <&backlight>;
                        label = "lcd";


Surely this fixes the problem?

Yours,
Linus Walleij
