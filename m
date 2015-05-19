From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] arm: boot: dts: add DTS for Baltos IR5221
Date: Tue, 19 May 2015 10:33:13 +0200
Message-ID: <CAGm1_kvc+PiK8CbpaEWR-1vGLs5F0hMoWaEGXokg97+6q5mOUg@mail.gmail.com>
References: <1431468917-27697-1-git-send-email-balbi@ti.com>
 <20150513074002.0b7b8dda@ipc1.ka-ro> <20150513152904.GC4201@saruman.tx.rr.com>
 <20150513155012.GI15563@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32868 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbESIde convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2015 04:33:34 -0400
Received: by padbw4 with SMTP id bw4so14334848pad.0
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2015 01:33:33 -0700 (PDT)
In-Reply-To: <20150513155012.GI15563@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Wed, May 13, 2015 at 5:50 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Felipe Balbi <balbi@ti.com> [150513 08:32]:
>> On Wed, May 13, 2015 at 07:40:02AM +0200, Lothar Wa=C3=9Fmann wrote:
>> > >
>> > Should these be ordered alphabetically?
>>
>> why ?
>
> In general the alphabetical ordering helps to avoid merge
> conflicts when new things are added later on as they are
> not all added to the end. So yeah I have a slight sorting
> preference there too to make my life easier in the future :)

I've sent v2, but I left network components order as is. It was
borrowed from am335x-evmsk and represents somehow the hierarchy of
CPSW: at first MAC, then MDIO and then slaves with their own settings.

Regards,
Yegor
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
