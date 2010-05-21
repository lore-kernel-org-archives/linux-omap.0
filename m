From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host
 only and OTG roles.
Date: Fri, 21 May 2010 09:52:18 +0300
Message-ID: <20100521065218.GG925@nokia.com>
References: <1274360966-9974-1-git-send-email-x0082077@ti.com>
 <602675.31449.qm@web180309.mail.gq1.yahoo.com>
 <19F8576C6E063C45BE387C64729E7394044E535E9B@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63382 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab0EUGzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 02:55:05 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E535E9B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>

On Fri, May 21, 2010 at 07:15:37AM +0200, ext Gupta, Ajay Kumar wrote:
>Hi,
>> > +#ifdef CONFIG_USB_MUSB_OTG
>> > +=A0=A0=A0 .mode
>> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_OTG,
>> > +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
>> > +=A0=A0=A0 .mode
>> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_HOST,
>> > +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>> >  =A0=A0=A0 .mode
>> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
>> > +#endif
>>
>> > =A0=A0=A0 =A0=A0=A0 =3D MUSB_PERIPHERAL,
>> > +#endif
>>
>> By the way ... the #ifdeffery should indeed vanish from all board
>> configs except the Davinci DM6446 EVM.
>
>If we are claiming to support:
>	A. Same kernel would work on multiple boards
>	B. Single kernel for one single board
>
>Then I think these #ifdefferys are required in all the board files.
>
>Let's consider the OMAP3EVM which supports all the three modes and

you don't support "all three modes" you support OTG. If you want to=20
build for peripheral only, that's your choice, but the board is wired s=
o=20
that it has OTG support.

>If these #ifdefferys are not present and .mode is set to OTG.
>Then if I choose to compile the Kernel only for peripheral mode
>(Case-B above) then I would get below error from musb_core.c.
>
>"incompatible Kconfig role setting"

there's a patch making that a warning instead of an #error if I'm not=20
wrong.

--=20
balbi

DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
