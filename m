From: "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Wed, 20 Oct 2010 11:53:15 +0300
Message-ID: <AANLkTinOYDBMVZ3ibG3Md7jdOuOC6NkGWaugvHwT6uqF@mail.gmail.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
	<1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
	<4CBD9FD5.506@nokia.com>
	<AANLkTinRRyrXzqEu=u+CCYkmSNGm03SSo1tVG=5_wdpo@mail.gmail.com>
	<4CBE9E69.6060803@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46048 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab0JTIxR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 04:53:17 -0400
In-Reply-To: <4CBE9E69.6060803@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <roger.quadros@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On Wed, Oct 20, 2010 at 10:46 AM, Roger Quadros <roger.quadros@nokia.co=
m> wrote:
> On 10/19/2010 05:33 PM, ext Felipe Contreras wrote:
>> On Tue, Oct 19, 2010 at 4:40 PM, Roger Quadros<roger.quadros@nokia.c=
om>
>> =C2=A0wrote:
>>>>
>>>> @@ -843,6 +841,7 @@ config USB_CDC_COMPOSITE
>>>> =C2=A0config USB_G_NOKIA
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Nokia composite gadget"
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on PHONET
>>>> + =C2=A0 =C2=A0 =C2=A0 depends on USB_GADGET_MUSB_HDRC
>>>
>>> This is wrong. Is there a build problem or run-time problem without=
 this?
>>
>> Try:
>> CONFIG_USB_G_NOKIA=3Dy
>> CONFIG_USB_GADGET_MUSB_HDRC=3Dn
>>
>> At least g_nokia doesn't seem to work correctly on my N900.
>>
> It won't work on N900 because N900 has MUSB USB gadget controller and=
 it
> needs to be selected somehow while building for N900.
>
> You should set CONFIG_USB_GADGET_MUSB_HDRC to y somewhere else while
> building for N900 and not here because g_nokia is not MUSB specific.

How do you expect people to know that? The Kconfig should define what
USB_G_NOKIA needs to work, so that people can enable those things
without go Googling hunting for a workable defconfig. Right now people
can build g_nokia modules that don't work, and that shouldn't be
allowed by the Kconfig.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
