From: jung songtan <jungsongtan@gmail.com>
Subject: Re: Mini USB to Host convertor on OMAP3530
Date: Thu, 28 Jan 2010 18:16:15 +0800
Message-ID: <c27069991001280216m4c7e53efua61b1c80e7df21c@mail.gmail.com>
References: <c27069991001280031h28439cdeqb0ac84e0122a939a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48464 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab0A1KQQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 05:16:16 -0500
Received: by vws12 with SMTP id 12so140300vws.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 02:16:15 -0800 (PST)
In-Reply-To: <c27069991001280031h28439cdeqb0ac84e0122a939a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jungsongtan <jungsongtan@gmail.com>

I am trying to make the issue more clear and heve more test,

There is Omap3530 , DM6xx, and Convertor (Type A) , convertor (Type B),

Both A type and B type convertor can  work on Dm6xx,

A type convertor can work on Omap3530.

If B type convertor plugging on Omap while the board bootup, no device
can detected.
It seems there is no power supply under B type, or there must be
unsuccessfully session happened.


If using A type first , then plug B type, the B type can be used too.

But why, is the power supply weeker under Omap35x than Dm6xx? That
seems not possible,
I use Rev G and with external powered hub.

Is there any thing I missed in the hardware configuration on Omap board=
?

Thanks,
Jung



2010/1/28 jung songtan <jungsongtan@gmail.com>:
> Hi experts,
>
> What kind of convertor are you using? or do you have any recommended?
>
> I am using one kind of such convertor to connect the Musb OTG port to=
 device.
> But no devices can be detected.
>
> =A0if I change another kind of convertor, It works.
> I check the convertor on other board such as DM6xx, it works fine.
>
> Has anyone met such issue before?
> or I have any thing missing to configure the usb?
>
> Thanks very much,
>
> --
> K T Jung
>



--=20
K T Jung
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
