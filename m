From: "Matcovschi, Oleg" <oleg.matcovschi-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 2/5] usb: musb: twl: use mailbox API to send VBUS or
 ID events
Date: Fri, 6 Jul 2012 05:52:42 +0000
Message-ID: <E0D6B3D7803B1A49AC7CEA9958379F630375C1E7@DFLE36.ent.ti.com>
References: <1340367055-19835-1-git-send-email-kishon@ti.com>
	<1340367055-19835-3-git-send-email-kishon@ti.com>
	<E0D6B3D7803B1A49AC7CEA9958379F630375BD5A@DFLE36.ent.ti.com>
 <CAAe_U6+3sf5Nm5bQeY=Pi=sYMPp3GfXWxfbbbo1mSH2u9xjTyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAe_U6+3sf5Nm5bQeY=Pi=sYMPp3GfXWxfbbbo1mSH2u9xjTyQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Kishon,


>-----Original Message-----
>From: ABRAHAM, KISHON VIJAY=20
>Sent: Tuesday, July 03, 2012 10:48 PM
>To: Matcovschi, Oleg
>Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kern=
el-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; >Balbi, Felipe
>Subject: Re: [PATCH v3 2/5] usb: musb: twl: use mailbox API to send VB=
US or ID events

>Hi Oleg,

>On Tue, Jul 3, 2012 at 11:09 PM, Matcovschi, Oleg <oleg.matcovschi@ti.=
com> wrote:
>>>From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
>>>[linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] on behalf of ABRAHAM, KISHON VIJA=
Y
>>>Sent: Friday, June 22, 2012 5:10 AM
>>>To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; ABRAHAM, KISHON VIJAY;=20
>>>linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;=20
>>>linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Balbi, Felipe
>>>Subject: [PATCH v3 2/5] usb: musb: twl: use mailbox API to send VBUS=
=20
>>>or ID events
>>
>>>The atomic notifier from twl4030/twl6030 to notifiy VBUS and ID=20
>>>events, is replaced by a direct call to omap musb blue.
>>
>>>Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>---
>>> drivers/usb/musb/omap2430.c =A0 | =A0 94=20
>>>+++++++++++++++++++++++++---------------
>>> drivers/usb/otg/twl4030-usb.c | =A0 46 ++++++++++---------- =20
>>>drivers/usb/otg/twl6030-usb.c | =A0 47 +++++++++----------- =20
>>>include/linux/usb/musb-omap.h | =A0 30 +++++++++++++
>>> 4 files changed, 133 insertions(+), 84 deletions(-)  create mode=20
>>>100644 include/linux/usb/musb-omap.h
>> .....
>> +enum omap_musb_vbus_id_status {
>> + =A0 =A0 =A0 OMAP_MUSB_UNKNOWN =3D 0,
>> + =A0 =A0 =A0 OMAP_MUSB_ID_GROUND,
>> + =A0 =A0 =A0 OMAP_MUSB_ID_FLOAT,
>> + =A0 =A0 =A0 OMAP_MUSB_VBUS_VALID,
>> + =A0 =A0 =A0 OMAP_MUSB_VBUS_OFF,
>> +};
>> +
>>
>> Why did you choose to introduce OMAP_MUSB specific VBUS, ID events?
>> IMHO, it makes more sense to introduce mailbox functionality only wi=
thout extra translation layer.
>> Same mailbox glue layer could be used for other PHY drivers, not jus=
t twl.

>We've decided to make twl as a comparator driver since we have a separ=
ate phy driver (not yet merged). Hence we dint >want twl to use usb_phy=
 specific events. So if you have other PHY drivers, you can still use t=
he OMAP_MUSB specific >events.
>Thanks
>Kishon

In other words: you are proposing to have 2 flavors of other phy driver=
s(OMAP and not-OMAP platform specific)...
Do you think it is necessary?
Could you please provide full description of your original problem?

Regards,
 Oleg
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
