From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
Date: Thu, 3 Dec 2015 16:54:40 -0800
Message-ID: <20151204005440.GE23396@atomide.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
 <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444979892-31626-14-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [151016 00:23]:

I noticed something while changing dm81xx to use the edma_xbar..

> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> +
> +		edma_xbar: dma-router@44e10f90 {
> +			compatible = "ti,am335x-edma-crossbar";
> +			reg = <0x44e10f90 0x40>;
> +
> +			#dma-cells = <3>;
> +			dma-requests = <32>;
> +
> +			dma-masters = <&edma>;
>  		};

The edma_xbar should now be just a child at offset 0xf90 under the
scm: scm@210000. Can you please check the other patches too?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
