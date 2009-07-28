From: vimal singh <vimal.newwork-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] musb: fix CONFIGDATA register read issue
Date: Tue, 28 Jul 2009 11:36:58 +0530
Message-ID: <ce9ab5790907272306g40bb2447m32e976573a33e992@mail.gmail.com>
References: <1246858408-24953-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1246858408-24953-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 6, 2009 at 11:03 AM, Ajay Kumar Gupta<ajay.gupta-l0cyMroinI0@public.gmane.org> wr=
ote:
> INDEX register has to be set to '0' before reading
> CONFIGDATA register which is only present in TI musb
> platforms.
>
> Currently the default register access mode is set to
> FLAT_MODE thus INDEX register is not getting set
> properly with musb_ep_select() which is just a nop
> operation in FLAT_MODE.This invalid register read is
> causing module reinset failure.
>
> Fixing the issue by moving INDEX register write part to
> musb_read_configdata() function itself.
>
> Signed-off-by: Vikram Pandita <vikram.pandita at ti.com>

Please correct the e-mail address above.

> Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> ---
> Based on a previous patch from Anand at,
> http://marc.info/?l=3Dlinux-omap&m=3D122051303604377&w=3D2
>
> Another version of this fix by Vikram is at,
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/=
012084.html
>
> =A0drivers/usb/musb/musb_core.c | =A0 =A01 -
> =A0drivers/usb/musb/musb_regs.h | =A0 =A01 +
> =A02 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_cor=
e.c
> index 554a414..3ec68a1 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1326,7 +1326,6 @@ static int __init musb_core_init(u16 musb_type,=
 struct musb *musb)
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 i;
>
> =A0 =A0 =A0 =A0/* log core options (read using indexed model) */
> - =A0 =A0 =A0 musb_ep_select(mbase, 0);
> =A0 =A0 =A0 =A0reg =3D musb_read_configdata(mbase);
>
> =A0 =A0 =A0 =A0strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-1=
6" : "UTMI-8");
> diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_reg=
s.h
> index de3b2f1..fbfd3fd 100644
> --- a/drivers/usb/musb/musb_regs.h
> +++ b/drivers/usb/musb/musb_regs.h
> @@ -323,6 +323,7 @@ static inline void =A0musb_write_rxfifoadd(void _=
_iomem *mbase, u16 c_off)
>
> =A0static inline u8 musb_read_configdata(void __iomem *mbase)
> =A0{
> + =A0 =A0 =A0 musb_writeb(mbase, MUSB_INDEX, 0);
> =A0 =A0 =A0 =A0return musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
> =A0}
>
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---
Regards,
\/ | |\/| /-\ |_

____      __o
------   -\<,
-----  ( )/ ( )
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
