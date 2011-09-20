From: Bjarne Steinsbo <bsteinsbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usb: musb: OMAP4430: Remove a redundant omap4430_phy_init
 call in usb_musb_init
Date: Tue, 20 Sep 2011 16:27:15 +0200
Message-ID: <CAFULf_xq8E1hvB6sXKfwxo6PS39mN0Xe15nevmNReCtfcJ90tg@mail.gmail.com>
References: <1316508629.14514.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316508629.14514.2.camel@phoenix>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Ref thread starting at http://marc.info/?l=3Dlinux-omap&m=3D13131628921=
1258&w=3D2

Bjarne Steinsbo

On Tue, Sep 20, 2011 at 10:50 AM, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Current code calls omap4430_phy_init() twice in usb_musb_init().
> Calling omap4430_phy_init() once is enough.
> This patch removes the first omap4430_phy_init() call, which using an
> uninitialized pointer as parameter.
>
> This patch elimates below build warning:
> arch/arm/mach-omap2/usb-musb.c: In function 'usb_musb_init':
> arch/arm/mach-omap2/usb-musb.c:141: warning: 'dev' may be used uninit=
ialized in this function
>
> Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =A0arch/arm/mach-omap2/usb-musb.c | =A0 =A03 ---
> =A01 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb=
-musb.c
> index a65145b..19e4dac 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -137,9 +137,6 @@ void __init usb_musb_init(struct omap_musb_board_=
data *musb_board_data)
> =A0 =A0 =A0 =A0musb_plat.mode =3D board_data->mode;
> =A0 =A0 =A0 =A0musb_plat.extvbus =3D board_data->extvbus;
>
> - =A0 =A0 =A0 if (cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4430_phy_init(dev);
> -
> =A0 =A0 =A0 =A0if (cpu_is_omap3517() || cpu_is_omap3505()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh_name =3D "am35x_otg_hs";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name =3D "musb-am35x";
> --
> 1.7.4.1
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
