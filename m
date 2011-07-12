From: Dima Zavin <dima-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: omap2430: handle charger OTG xceiver event
Date: Tue, 12 Jul 2011 10:44:19 -0700
Message-ID: <CAPz4a6C_Y797S5kQVVdUyN-xiuEaz415nEcp-CDOYPwZ4xzNuA@mail.gmail.com>
References: <1310424197-22909-1-git-send-email-dima@android.com>
	<20110712060126.GB2588@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110712060126.GB2588-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 11, 2011 at 11:01 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
> On Mon, Jul 11, 2011 at 03:43:17PM -0700, Dima Zavin wrote:
>> Set a flag on OTG charger event and check it on cable
>> remove event (i.e. USB_EVENT_NONE). This way we will
>> not need to power up the PHY when an external charger
>
> s/PHY/LINK

Actually it's both, I should update the commit message.

>
>> is detected by the transceiver itself.
>
> ... your logic is inversed. Link shouldn't be powered up to start with.
> We should only power up the Link after we know it *will* be needed. The
> way you're doing this is:

The link *isn't* being powered up by my patch. On an already detected
charger you should do nothing at all in musb. That's the whole point
of the patch: add the ability to process the USB_EVENT_CHARGER event
in musb from the otg_transceiver that has already detected the
charger. Today, on USB_EVENT_VBUS, you'd resume your link and then
call otg_init, which would powerup the phy on omap4, which we do not
need to do for USB_EVENT_CHARGER.

>
> connect cable -> resume PHY -> resume Link -> if is_charger suspend
> Link.

Not at all. Have even you looked at the patch? With the patch,

1) "connect cable", detected by otg_transceiver.
2) otg_transceiver does the detection of ID pin and/or VBUS and/or
dedicated charger.
3) otg_transceiver sends USB_EVENT_xxx
4) In musb_otg_notification(), check if the transceiver detected a
charger (USB_EVENT_CHARGER).
4.1) If yes, then do nothing and leave the LINK *and* the PHY in their
off states.

>
> Where it should be:
>
> connect cable -> resume PHY -> if is_charger goto done.

We only have to resume the PHY if the transceiver didn't do the
charger detection. The TWL6030 doesn't do that, but depending on your
board, you may have other devices upstream from the OMAP on the USB
lines that may have done the detection for you.

--Dima

>
> Now, to make a generic solution (which is what we want in the long run)
> we still need a few changes on the OTG support and otg_transceiver on
> Linux.
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
