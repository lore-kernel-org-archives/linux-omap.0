From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: dra7x: Support QSPI MODE-0 operation at
 64MHz
Date: Thu, 14 Apr 2016 12:12:15 -0500
Message-ID: <20160414171215.GA9860@rob-hp-laptop>
References: <1460629101-24309-1-git-send-email-vigneshr@ti.com>
 <1460629101-24309-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460629101-24309-3-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 14, 2016 at 03:48:21PM +0530, Vignesh R wrote:
> According to Data Manual(SPRS915P) of AM57x, TI QSPI controller on
> DRA74(rev 1.1+)/DRA72 EVM can support up to 64MHz in MODE-0, whereas
> MODE-3 is limited to 48MHz. Hence, switch to MODE-0 for better
> throughput.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/ti_qspi.txt | 7 +++++++
>  arch/arm/boot/dts/dra7-evm.dts                    | 6 ++----
>  arch/arm/boot/dts/dra72-evm.dts                   | 6 ++----
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
> index cc8304aa64ac..50b14f6b53a3 100644
> --- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
> +++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
> @@ -19,6 +19,13 @@ Optional properties:
>  - syscon-chipselects: Handle to system control region contains QSPI
>  		      chipselect register and offset of that register.
>  
> +NOTE: TI QSPI controller requires different pinmux and IODelay
> +paramaters for Mode-0 and Mode-3 operations, which needs to be set up by
> +the bootloader (U-Boot). Default configuration only supports Mode-0
> +operation. Hence, "spi-cpol" and "spi-cpha" DT properties cannot be
> +specified in the slave nodes of TI QSPI controller without appropriate
> +modification to bootloader.

But these properties are properties of what the slave device supports, 
right? I don't see how you can change them based on the controller.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
