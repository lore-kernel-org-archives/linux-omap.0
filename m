From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] ARM: dts: omap: Fix some DTC warnings
Date: Fri, 1 Apr 2016 13:38:13 -0700
Message-ID: <20160401203812.GP9329@atomide.com>
References: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@osg.samsung.com> [160401 13:21]:
> Hello Tony
> 
> DTC reports a lot of warnings on omap DTS due a mismatch between unit
> names and reg properties in different device nodes. This series tries
> to fix at least some of them, but there are still a lot remaining.

Great, adding Tero to Cc as I think he is already looking at fixing
the clock related warnings.

Regards,

Tony


> Javier Martinez Canillas (5):
>   ARM: dts: omap: add missing unit name to pbias regulator nodes
>   ARM: dts: n8x0: remove unneeded unit name for i2c node
>   ARM: dts: omap3: add missing unit name to PMU node
>   ARM: dts: omap: remove unneeded unit name for sound nodes
>   ARM: dts: omap: add missing unit names to bandgap nodes
> 
>  arch/arm/boot/dts/am437x-gp-evm.dts         | 2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts        | 2 +-
>  arch/arm/boot/dts/am57xx-beagle-x15.dts     | 2 +-
>  arch/arm/boot/dts/am57xx-cl-som-am57x.dts   | 2 +-
>  arch/arm/boot/dts/dra7-evm.dts              | 2 +-
>  arch/arm/boot/dts/dra7.dtsi                 | 2 +-
>  arch/arm/boot/dts/dra72-evm.dts             | 2 +-
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 2 +-
>  arch/arm/boot/dts/omap2430.dtsi             | 2 +-
>  arch/arm/boot/dts/omap3.dtsi                | 4 ++--
>  arch/arm/boot/dts/omap34xx.dtsi             | 2 +-
>  arch/arm/boot/dts/omap36xx.dtsi             | 2 +-
>  arch/arm/boot/dts/omap4-var-som-om44.dtsi   | 2 +-
>  arch/arm/boot/dts/omap4.dtsi                | 2 +-
>  arch/arm/boot/dts/omap443x.dtsi             | 2 +-
>  arch/arm/boot/dts/omap4460.dtsi             | 2 +-
>  arch/arm/boot/dts/omap5.dtsi                | 2 +-
>  17 files changed, 18 insertions(+), 18 deletions(-)
> 
> -- 
> 2.5.0
> 
