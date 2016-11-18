From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC 1/6] drm/etnaviv: add binding for the gc320 found in ti socs
Date: Thu, 17 Nov 2016 20:53:38 -0600
Message-ID: <0bf288ee-33bc-c3b5-389f-08d9bb89ccb5@ti.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161118024436.13447-1-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/17/2016 08:44 PM, Robert Nelson wrote:

Could we write at least a oneline commit message? :)

Might want to state that since the TI gpu systems are a mixed bunch 
and  certain SoCs may have more than 1 GPU integrated, we indicate 
clearly the rev here?
> Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> CC: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> CC: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> CC: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt | 1 +
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c                             | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> index ed5e0a7..9fa259d 100644
> --- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> +++ b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> @@ -8,6 +8,7 @@ Required properties:
>  - compatible: Should be one of
>      "fsl,imx-gpu-subsystem"
>      "marvell,dove-gpu-subsystem"
> +    "ti,gc320-gpu-subsystem"
>  - cores: Should contain a list of phandles pointing to Vivante GPU devices
>
>  example:
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index a6799b0..ce51270 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -653,6 +653,7 @@ static int etnaviv_pdev_remove(struct platform_device *pdev)
>  static const struct of_device_id dt_match[] = {
>  	{ .compatible = "fsl,imx-gpu-subsystem" },
>  	{ .compatible = "marvell,dove-gpu-subsystem" },
> +	{ .compatible = "ti,gc320-gpu-subsystem" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
>


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
