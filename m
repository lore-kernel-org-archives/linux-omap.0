From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 1/6] drm/etnaviv: add binding for the gc320 found in ti socs
Date: Thu, 17 Nov 2016 20:51:54 -0600
Message-ID: <CAOCHtYgpFJ22fLWkTiVTP02onytQAD-Uzfcu7W+e2ZfXRk=RXw@mail.gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161118024436.13447-1-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Julien <jboulnois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Sorry, messed up the cover-header, patches 3 & 4 in this series where
cherry picked form ti's v4.4.x tree:

http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/commit/arch/arm/boot/dts/dra7.dtsi?h=ti-linux-4.4.y&id=8067f5a5619ce45657d3729ab3adb9e5b1294f0d

http://git.ti.com/cgit/cgit.cgi/ti-linux-kernel/ti-linux-kernel.git/commit/Documentation/devicetree/bindings/gpu/ti-bb2d.txt?h=ti-linux-4.4.y&id=ddadad0828f8e5ad7e89b11dd243249228ff2997

"ti,gc320-gpu-subsystem" seems like the best middle ground option, the
gc320 is found on one omap4770, omap5, dra7..

"ti,omap-gpu-subsystem" might clash with the naming for the sgx544 3D
core found on these devices, then some day, ti could use
"ti,sgx<num>-gpu-subsystem"

For BeagleBoard.org & BeagleBoard-x15 users we have this working in
the updated images.

For people looking to build the packages, i have it up here:

https://gist.github.com/RobertCNelson/fc6d07157b0fcc13b9c28c5832fdc74b

Regards,

On Thu, Nov 17, 2016 at 8:44 PM, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
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
>         { .compatible = "fsl,imx-gpu-subsystem" },
>         { .compatible = "marvell,dove-gpu-subsystem" },
> +       { .compatible = "ti,gc320-gpu-subsystem" },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
> --
> 2.10.2
>



-- 
Robert Nelson
https://rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
