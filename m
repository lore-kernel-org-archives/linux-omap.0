From: Govindraj <govindraj.ti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: USB: fix the pointer type mismatch compilation warning
Date: Mon, 5 Mar 2012 16:53:34 +0530
Message-ID: <CAAL8m4x8mg5TDkEQAe-xK1XNUys8bN-AMKKgH=SmeFH3hEtsXg@mail.gmail.com>
References: <1330946376-17672-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1330946376-17672-1-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 5, 2012 at 4:49 PM, Keshava Munegowda <keshava_mgowda-Bv2c3lPp1Ag@public.gmane.org=
m> wrote:
> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>
> The compilation of usb-host.c file was resulting compilation warning
> due to pointer type mismatch in assignment of return pointer type
> of the function omap_device_build_ss to local pointer type.
> This warning is fixed.

Its fixed already.

https://lkml.org/lkml/2012/2/14/73

>
> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
> ---
> =A0arch/arm/mach-omap2/usb-host.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb=
-host.c
> index 771dc78..88d4a19 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -486,7 +486,7 @@ static void setup_4430ohci_io_mux(const enum usbh=
s_omap_port_mode *port_mode)
> =A0void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
> =A0{
> =A0 =A0 =A0 =A0struct omap_hwmod =A0 =A0 =A0 *oh[2];
> - =A0 =A0 =A0 struct omap_device =A0 =A0 =A0*od;
> + =A0 =A0 =A0 struct platform_device =A0*od;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_id =3D=
 -1;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i;
>
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
