From: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: Enable earlycon stdout path for LogicPD torpedo
Date: Mon, 22 May 2017 13:30:05 -0500
Message-ID: <CAHCN7xLgRQvcs2sWP=ovjKVrxuEmnDa1K5eLCycM4fku6Dw7Pg@mail.gmail.com>
References: <20170522161346.10591-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170522161346.10591-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 22, 2017 at 11:13 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> As long as the kernel cmdline has "earlycon" in it, this allows
> seeing debug messages earlier and does not require DEBUG_LL to
> be enabled.

Thanks for doing that.  I was meaning to do that after I found it was
necessary for porting OMAP3 device tree stuff to U-Boot. I just got
distracted and forgot to do it.

>
> Cc: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Acked-by: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  arch/arm/boot/dts/logicpd-torpedo-som.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> @@ -7,6 +7,10 @@
>  #include <dt-bindings/input/input.h>
>
>  / {
> +       chosen {
> +               stdout-path = &uart1;
> +       };
> +
>         cpus {
>                 cpu@0 {
>                         cpu0-supply = <&vcc>;
> --
> 2.13.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
