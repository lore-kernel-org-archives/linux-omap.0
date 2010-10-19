From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] usb: trivial Kconfig cleanups
Date: Tue, 19 Oct 2010 21:15:21 +0300
Message-ID: <AANLkTinRCaXO1nO3sZdbiAHont+vgd4eZE9EN-snjZYg@mail.gmail.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
	<1287482608-11320-3-git-send-email-felipe.contreras@gmail.com>
	<20101019155109.GH4589@kroah.com>
	<AANLkTi=CzBriAFW2gzG68b=6wENysJZEkaO9jFrXQdnq@mail.gmail.com>
	<20101019175036.GB4618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37505 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab0JSSPX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 14:15:23 -0400
In-Reply-To: <20101019175036.GB4618@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-usb@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

On Tue, Oct 19, 2010 at 8:50 PM, Greg KH <greg@kroah.com> wrote:
> On Tue, Oct 19, 2010 at 08:15:19PM +0300, Felipe Contreras wrote:
>> On Tue, Oct 19, 2010 at 6:51 PM, Greg KH <greg@kroah.com> wrote:
>> > On Tue, Oct 19, 2010 at 01:03:27PM +0300, Felipe Contreras wrote:
>> >> Note: USB_GADGET_MUSB_HDRC is already defined in usb/gadget.
>> >>
>> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> >
>> > Please describe _what_ trivial cleanups you did, and why you did t=
hem.
>> > Care to resend?
>>
>> How about:
>> Shuffle the code a bit so the description is at the top, remove
>> duplicated configs (USB_GADGET_MUSB_HDRC), =C2=A0'default n' is redu=
ndant,
>> and USB_GADGET_SELECTED should go after USB_GADGET (on the appropria=
te
>> config).
>
> Sounds good, but you need to resend it with this information in it, n=
ot
> much I can do with it in an independant email.

I know that, I just wanted to see if it was ok before resending so I
don't resend another time.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
