From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/7] usb: musb: omap2430: turn off vbus on cable disconnect
Date: Tue, 12 Mar 2013 17:03:31 +0200
Message-ID: <CANOLnOP+wh344jZT_yqnxdQwmhqJ2U+eAs=cvsywLSUe+gP-9A@mail.gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
	<1362877681-8102-7-git-send-email-notasas@gmail.com>
	<513F2F7C.3040803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <513F2F7C.3040803-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 12, 2013 at 3:37 PM, kishon <kishon-l0cyMroinI0@public.gmane.org> wrote:
> Hi,
>
>
> On Sunday 10 March 2013 06:38 AM, Grazvydas Ignotas wrote:
>>
>> On USB_EVENT_ID event the musb glue enables VBUS by calling
>> omap2430_musb_set_vbus(musb, 1) that sets the session bit, but on
>> USB_EVENT_NONE reverse action is never made, and that breaks PM.
>>
>> Disable VBUS unconditionally on USB_EVENT_NONE to be sure musb
>> session is ended on cable unplug so that PM works.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>   drivers/usb/musb/omap2430.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430=
=2Ec
>> index 2a39c11..d430677 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -296,6 +296,7 @@ static void omap_musb_set_mailbox(struct omap243=
0_glue
>> *glue)
>>                         pm_runtime_put_autosuspend(dev);
>>                 }
>>
>> +               omap2430_musb_set_vbus(musb, 0);
>>                 if (data->interface_type =3D=3D MUSB_INTERFACE_UTMI)=
 {
>>                         if (musb->xceiv->otg->set_vbus)
>>                                 otg_set_vbus(musb->xceiv->otg, 0);
>
> Shouldn't this otg_set_vbus be done inside omap2430_musb_set_vbus? An=
y idea
> why they were doing this only for UTMI?

I would think so too, there is otg_set_vbus() in
omap2430_musb_set_vbus() for enable but not for disable.
I don't know history of this code and didn't want to break existing
functionality.

>
> Thanks
> Kishon



--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
