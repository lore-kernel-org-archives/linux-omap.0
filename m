From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/3] clk: Add clock driver for DRA7 ATL (Audio Tracking
 Logic)
Date: Thu, 24 Apr 2014 12:14:32 +0300
Message-ID: <5358D5F8.3010401@ti.com>
References: <1396446907-20383-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396446907-20383-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Mike,

On 04/02/2014 04:55 PM, Peter Ujfalusi wrote:
> Hi,
>=20
> Audio Tracking Logic is designed to be used by HD Radio
> applications to synchronize the audio output clocks to the
> baseband clock. ATL can be also used to track errors between
> two reference clocks (BWS, AWS) and generate a modulated
> clock output which averages to some desired frequency.
>=20
> To be able to integrate the ATL provided clocks to the clock tree we =
need
> two types of DT binding:
> - DT clock nodes to represent the ATL clocks towards the CCF
> - binding for the ATL IP itself which is going to handle the hw
>   configuration
>=20
> The reason for this type of setup is that ATL itself is a separate de=
vice
> in the SoC, it has it's own address space and clock domain. Other IPs=
 can
> use the ATL generated clock as their functional clock (McASPs for exa=
mple)
> and external components like audio codecs can also use the very same =
clock
> as their MCLK.
>=20
> With setup pm_runtime can handle the ATL clock on demand of it's use =
and
> all the IP which needs ATL clock can be sure that it is enabled for t=
hem.
>=20
> The first patch fixes the name of atl clkin3 node in dtsi file.

Can you take a look at this series?

Thanks,
P=E9ter

>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ARM: dts: dra7xx-clocks: Correct name for atl clkin3 clock
>   clk: Driver for DRA7 ATL (Audio Tracking Logic)
>   ARM: DTS: dra7/dra7xx-clocks: ATL related changes
>=20
>  .../devicetree/bindings/clock/ti/dra7-atl.txt      |  97 +++++++
>  arch/arm/boot/dts/dra7.dtsi                        |  11 +
>  arch/arm/boot/dts/dra7xx-clocks.dtsi               |  38 +--
>  drivers/clk/ti/Makefile                            |   3 +-
>  drivers/clk/ti/clk-7xx.c                           |   2 +-
>  drivers/clk/ti/clk-dra7-atl.c                      | 313 +++++++++++=
++++++++++
>  include/dt-bindings/clk/ti-dra7-atl.h              |  40 +++
>  7 files changed, 483 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/dra7-a=
tl.txt
>  create mode 100644 drivers/clk/ti/clk-dra7-atl.c
>  create mode 100644 include/dt-bindings/clk/ti-dra7-atl.h
>=20
