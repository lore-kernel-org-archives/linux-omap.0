From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap4-panda-es: Do not reset gpio1
Date: Thu, 10 Oct 2013 09:47:02 -0700
Message-ID: <20131010164702.GF29913@atomide.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com>
 <1381423481-5920-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381423481-5920-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [131010 09:53]:
> Do not reset GPIO1 at boot-up because GPIO 7 in GPIO1 block is used on
> OMAP4460 PandaBoard-ES to select voltage register in TPS62361 which
> supplies VDD_MPU.
> 
> Without this, OMAP4460 PandaBoard-ES boards fail to boot-up because
> MPU voltage switches over to VSET0 voltage value (boot voltage) which
> is not sufficient to operate the device at OPP100.

Is this needs as a fix for the -rc series?

Tony
 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> As explained here: http://marc.info/?l=u-boot&m=133066647800872&w=2
> 
> GPIO1 reset causes PandaBoard-ES to stop functioning.
> This depends on Patch series from Rajendra:
> http://marc.info/?l=linux-doc&m=138131355520116&w=2
> Applies on Benoit's for_13/dts branch:
> https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
> 
> Tested on PandaBoard-ES without the u-boot uenv hack
> 
>  arch/arm/boot/dts/omap4-panda-es.dts |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
> index 56c4354..816d1c9 100644
> --- a/arch/arm/boot/dts/omap4-panda-es.dts
> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
> @@ -62,3 +62,7 @@
>  		gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
>  	};
>  };
> +
> +&gpio1 {
> +	 ti,no-reset-on-init;
> +};
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
