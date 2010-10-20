From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Wed, 20 Oct 2010 12:23:13 +0300
Message-ID: <AANLkTikom=eRFqCJmYE+k1zn5K2MR9s8HhNXtjOvUqvr@mail.gmail.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
	<1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
	<4CBD9FD5.506@nokia.com>
	<AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>
	<4CBE9E69.6060803@nokia.com>
	<AANLkTinOYDBMVZ3ibG3Md7jdOuOC6NkGWaugvHwT6uqF@mail.gmail.com>
	<4CBEB312.7060400@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CBEB312.7060400-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 20, 2010 at 12:14 PM, Roger Quadros <roger.quadros-xNZwKgViW5g@public.gmane.org=
m> wrote:
> On 10/20/2010 11:53 AM, ext felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>>
>> On Wed, Oct 20, 2010 at 10:46 AM, Roger Quadros<roger.quadros@nokia.=
com>
>> =C2=A0wrote:
>>>
>>> On 10/19/2010 05:33 PM, ext Felipe Contreras wrote:
>>>>
>>>> On Tue, Oct 19, 2010 at 4:40 PM, Roger Quadros<roger.quadros@nokia=
=2Ecom>
>>>> =C2=A0wrote:
>>>>>>
>>>>>> @@ -843,6 +841,7 @@ config USB_CDC_COMPOSITE
>>>>>> =C2=A0config USB_G_NOKIA
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Nokia composite gadget"
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on PHONET
>>>>>> + =C2=A0 =C2=A0 =C2=A0 depends on USB_GADGET_MUSB_HDRC
>>>>>
>>>>> This is wrong. Is there a build problem or run-time problem witho=
ut
>>>>> this?
>>>>
>>>> Try:
>>>> CONFIG_USB_G_NOKIA=3Dy
>>>> CONFIG_USB_GADGET_MUSB_HDRC=3Dn
>>>>
>>>> At least g_nokia doesn't seem to work correctly on my N900.
>>>>
>>> It won't work on N900 because N900 has MUSB USB gadget controller a=
nd it
>>> needs to be selected somehow while building for N900.
>>>
>>> You should set CONFIG_USB_GADGET_MUSB_HDRC to y somewhere else whil=
e
>>> building for N900 and not here because g_nokia is not MUSB specific=
=2E
>>
>> How do you expect people to know that? The Kconfig should define wha=
t
>> USB_G_NOKIA needs to work, so that people can enable those things
>> without go Googling hunting for a workable defconfig. Right now peop=
le
>> can build g_nokia modules that don't work, and that shouldn't be
>> allowed by the Kconfig.
>>
>
> USB_G_NOKIA just needs a USB gadget controller to work. The gadget
> controller used for the board should come from the board's Kconfig wh=
ich
> will ideally be supplied by the board's vendor.

Ok, but USB_OMAP is not supposed to work on the N900? (I tried and it d=
idn't)

> For example, can't USB_GADGET_MUSB_HDRC be selected in MACH_NOKIA_RX5=
1 in
> arch/arm/mach-omap2/Kconfig? or is there a better place to put it?

I don't think so, because people might not want USB at all. The ideal
case would be for USB_GADGET_MUSB_HDRC to be selected automatically
when the user selects USB and USB_GADGET, but that's not happening
because USB_GADGET_OMAP is selected first (all the dependencies are
met).

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
