From: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/5] usb: musb: twl: use mailbox API to send VBUS or ID events
Date: Wed, 4 Jul 2012 11:17:36 +0530
Message-ID: <CAAe_U6+3sf5Nm5bQeY=Pi=sYMPp3GfXWxfbbbo1mSH2u9xjTyQ@mail.gmail.com>
References: <1340367055-19835-1-git-send-email-kishon@ti.com>
	<1340367055-19835-3-git-send-email-kishon@ti.com>
	<E0D6B3D7803B1A49AC7CEA9958379F630375BD5A@DFLE36.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E0D6B3D7803B1A49AC7CEA9958379F630375BD5A-yhyrjsqURdeIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Matcovschi, Oleg" <oleg.matcovschi-l0cyMroinI0@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Oleg,

On Tue, Jul 3, 2012 at 11:09 PM, Matcovschi, Oleg
<oleg.matcovschi-l0cyMroinI0@public.gmane.org> wrote:
>>From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [linux-omap-owner-u79uwXL29TasMV2rI37PzA@public.gmane.org=
org] on behalf of ABRAHAM, KISHON VIJAY
>>Sent: Friday, June 22, 2012 5:10 AM
>>To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; ABRAHAM, KISHON VIJAY; linux-omap@vge=
r.kernel.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; =
Balbi, Felipe
>>Subject: [PATCH v3 2/5] usb: musb: twl: use mailbox API to send VBUS =
or ID events
>
>>The atomic notifier from twl4030/twl6030 to notifiy VBUS and ID event=
s,
>>is replaced by a direct call to omap musb blue.
>
>>Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>---
>> drivers/usb/musb/omap2430.c =A0 | =A0 94 +++++++++++++++++++++++++--=
-------------
>> drivers/usb/otg/twl4030-usb.c | =A0 46 ++++++++++----------
>> drivers/usb/otg/twl6030-usb.c | =A0 47 +++++++++-----------
>> include/linux/usb/musb-omap.h | =A0 30 +++++++++++++
>> 4 files changed, 133 insertions(+), 84 deletions(-)
>> create mode 100644 include/linux/usb/musb-omap.h
> .....
> +enum omap_musb_vbus_id_status {
> + =A0 =A0 =A0 OMAP_MUSB_UNKNOWN =3D 0,
> + =A0 =A0 =A0 OMAP_MUSB_ID_GROUND,
> + =A0 =A0 =A0 OMAP_MUSB_ID_FLOAT,
> + =A0 =A0 =A0 OMAP_MUSB_VBUS_VALID,
> + =A0 =A0 =A0 OMAP_MUSB_VBUS_OFF,
> +};
> +
>
> Why did you choose to introduce OMAP_MUSB specific VBUS, ID events?
> IMHO, it makes more sense to introduce mailbox functionality only wit=
hout extra translation layer.
> Same mailbox glue layer could be used for other PHY drivers, not just=
 twl.

We've decided to make twl as a comparator driver since we have a
separate phy driver (not yet merged). Hence we dint want twl to use
usb_phy specific events. So if you have other PHY drivers, you can
still use the OMAP_MUSB specific events.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
