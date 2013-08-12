From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 8/8] ARM: DRA7: dts: Add the dts files for dra7 SoC
 and dra7-evm board
Date: Mon, 12 Aug 2013 12:44:02 +0100
Message-ID: <20130812114402.GB6616@e106331-lin.cambridge.arm.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-9-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1375183546-12758-9-git-send-email-rnayak@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@linaro.org" <khilman@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "benoit.cousson@gmail.com" <benoit.cousson@gmail.com>, "r.sricharan@ti.com" <r.sricharan@ti.com>, "ambresh@ti.com" <ambresh@ti.com>, "sourav.poddar@ti.com" <sourav.poddar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 30, 2013 at 12:25:46PM +0100, Rajendra Nayak wrote:
> From: R Sricharan <r.sricharan@ti.com>
>
> Add minimal device tree source needed for DRA7 based SoCs.
> Also add a board dts file for the dra7-evm (based on dra752)
> which contains 1.5G of memory with 1G interleaved and 512MB
> non-interleaved. Also added in the board file are pin configuration
> details for i2c, mcspi and uart devices on board.
>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  arch/arm/boot/dts/Makefile     |    3 +-
>  arch/arm/boot/dts/dra7-evm.dts |  163 ++++++++++++++
>  arch/arm/boot/dts/dra7.dtsi    |  488 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 653 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/dra7-evm.dts
>  create mode 100644 arch/arm/boot/dts/dra7.dtsi

[...]

> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> new file mode 100644
> index 0000000..8a0c08e
> --- /dev/null
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -0,0 +1,488 @@
> +/*
> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + * Based on "omap4.dtsi"
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +       compatible = "ti,dra7xx";
> +       interrupt-parent = <&gic>;
> +
> +       aliases {
> +               serial0 = &uart1;
> +               serial1 = &uart2;
> +               serial2 = &uart3;
> +               serial3 = &uart4;
> +               serial4 = &uart5;
> +               serial5 = &uart6;
> +       };
> +
> +       cpus {
> +               cpu@0 {
> +                       compatible = "arm,cortex-a15";
> +                       timer {
> +                               compatible = "arm,armv7-timer";
> +                               /*
> +                                * PPI secure/nonsecure IRQ,
> +                                * active low level-sensitive
> +                                */
> +                               interrupts = <1 13 0x308>,
> +                                            <1 14 0x308>;
> +                               clock-frequency = <6144000>;
> +                       };
> +               };

The cpu nodes should have a reg matching their unit-address, and a
device_type = "cpu".

The timer nodes should *not* be under the CPU nodes. They should be
under under the root node. I realise that it makes intuitive sense to
describe per-cpu resources this way, but that's not the way the bindings
are intended to be used (does thei DT even work?).

No virtual/hypervisor interrupts?

Do you really need the clock-frequency property? It's far preferrable to
have your bootloader do the right thing and program CNTFRQ with the
correct value.

> +
> +       gic: interrupt-controller@48211000 {
> +               compatible = "arm,cortex-a15-gic";
> +               interrupt-controller;
> +               #interrupt-cells = <3>;
> +               reg = <0x48211000 0x1000>,
> +                     <0x48212000 0x1000>;

Similarly, no GICH/GICV registers?

Thanks,
Mark.
