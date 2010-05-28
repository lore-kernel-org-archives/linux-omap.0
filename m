From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host
	only and OTG roles.
Date: Fri, 28 May 2010 11:27:36 -0700
Message-ID: <AANLkTim7r5zq-G8iF1fxHQ9ohqfoOiuUkkMXfRYxkBQu@mail.gmail.com>
References: <1274360966-9974-1-git-send-email-x0082077@ti.com>
	<602675.31449.qm@web180309.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34356 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab0E1S1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 14:27:37 -0400
In-Reply-To: <602675.31449.qm@web180309.mail.gq1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, linux-usb@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>

On Thu, May 20, 2010 at 8:48 AM, David Brownell <david-b@pacbell.net> w=
rote:
>
>> +#ifdef CONFIG_USB_MUSB_OTG
>> +=A0=A0=A0 .mode
>> =A0=A0=A0 =A0=A0=A0 =3D MUSB_OTG,
>> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
>> +=A0=A0=A0 .mode
>> =A0=A0=A0 =A0=A0=A0 =3D MUSB_HOST,
>> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>> =A0=A0=A0=A0 .mode
>> =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
>> +#endif
>
>> =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
>> +#endif
>
> By the way ... the #ifdeffery should indeed vanish from all board
> configs except the Davinci DM6446 EVM. =A0That board is kind of quirk=
y
> in terms of USB support, and needs jumpering to get host or periphera=
l
> mode (and can't do OTG). =A0I suspect some of the other boards did a =
bad
> thing and tried emulating what that board did.

=46or Overo this patch actually makes quite a bit of sense (and I have
been using something similar for quite some time).

The Overo COM itself has no USB connector -- the customer can choose
or create a daughter card with the type of USB connector appropriate
to their application, be it host, peripheral, or OTG.  Having the mode
easily settable via a config option allows them to use the standard
board file without modification.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
