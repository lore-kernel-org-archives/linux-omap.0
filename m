From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] arm: dts: am335x-boneblack-common: fix memory size
Date: Mon, 6 Jan 2020 14:43:46 -0600
Message-ID: <CAOCHtYgyN+qXXX1YeEcO+nvRFrAL1HAVVMvjfeJ5nvxVjtFKtg@mail.gmail.com>
References: <20200106130909.7697-1-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106130909.7697-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OMAP DEVICE TREE SUPPORT" <linux-omap@vger.kernel.org>, "open list:OMAP DEVICE TREE SUPPORT" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 6, 2020 at 7:10 AM Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
>
> BeagleBone Black series is equipped with 512MB RAM
> whereas only 256MB is included from am335x-bone-common.dtsi

FYI: While all versions from the factory are 512MB, some 3rd parties
offered 1GB reballing upgrades..

and the SanCloud variant which uses this file, was built with 1GB:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/am335x-sancloud-bbe.dts

>
> This leads to an issue with unusual setups when devicetree
> is loaded by GRUB2 directly.

It's a miracle, since when did GRUB2 gain this ability?

>
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  arch/arm/boot/dts/am335x-boneblack-common.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-boneblack-common.dtsi b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
> index 7ad079861efd..91f93bc89716 100644
> --- a/arch/arm/boot/dts/am335x-boneblack-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
> @@ -131,6 +131,11 @@
>  };
>
>  / {
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x20000000>; /* 512 MB */
> +       };
> +
>         clk_mcasp0_fixed: clk_mcasp0_fixed {
>                 #clock-cells = <0>;
>                 compatible = "fixed-clock";
> --
> 2.16.4
>


-- 
Robert Nelson
https://rcn-ee.com/
