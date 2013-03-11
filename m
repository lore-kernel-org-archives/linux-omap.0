From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] usb: musb: log VBUS error
Date: Mon, 11 Mar 2013 19:08:36 +0200
Message-ID: <CANOLnOOp0xHq6KP3yNPYhneuxUtCy4w1tBQjw1kW7UHibV1_0A@mail.gmail.com>
References: <1362876568-7082-1-git-send-email-notasas@gmail.com>
	<20130311162409.GH26093@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:55700 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab3CKRIh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 13:08:37 -0400
In-Reply-To: <20130311162409.GH26093@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

On Mon, Mar 11, 2013 at 6:24 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Grazvydas Ignotas <notasas@gmail.com> [130309 16:53]:
>> VBUS_ERROR is a serious error that the driver often doesn't recover =
from
>> in my tests, so we should at least inform the user about it.
>
> Patch makes sens to me, just a related question..
>
> Do you get this when trying to enable the host mode, right? Or have y=
ou seen
> this in other situations too?

I sometimes see it when booting with cable connected to PC or
connecting cable to PC after using a host adapter. In those cases OTG
port dies completely until a powercycle :(

> If the error happens when enabling the host mode, my experience is th=
at
> the VBUS_ERROR is caused by the musb trying to be too smart and doing=
 the
> timeouts automatically. If the VBUS on the hardware does not raise fa=
st
> enough to the right range for whatever reason, musb can produce this
> error.

Yeah the driver seems to expect that and has a "ignore" variable, I
use KERN_DEBUG level in case it's set.

>
> Regards,
>
> Tony
>

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
