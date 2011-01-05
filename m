From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] arm: omap4: panda: remove usb_nop_xceiv_register
Date: Wed, 5 Jan 2011 21:40:19 +0800
Message-ID: <AANLkTik3Mw3fTZ6TPv4aiiWet-dARVQOLtUv_DAMqoNo@mail.gmail.com>
References: <1294148397-26582-1-git-send-email-tom.leiming@gmail.com>
	<87ipy442i7.fsf@ti.com>
	<20110105065643.GE2458@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56656 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab1AENkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 08:40:21 -0500
Received: by wyb28 with SMTP id 28so15344621wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 05:40:20 -0800 (PST)
In-Reply-To: <20110105065643.GE2458@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org

Hi,

2011/1/5 Felipe Balbi <balbi@ti.com>:
> On Tue, Jan 04, 2011 at 04:29:04PM -0800, Kevin Hilman wrote:
>> tom.leiming@gmail.com writes:
>>
>> > From: Ming Lei <tom.leiming@gmail.com>
>> >
>> > Panda uses twl6030 otg phy instead of internal phy,
>
> This is wrong, it uses both. TWL6030 handles VBUS and ID pin
> and the internal PHY handles Data Lines. I know it's a bit
> crazy but this kind of design is becoming more and more usual
> on different boards.

I see now after your explanation.

>
> What truly needs to happen is that we allow for multiple PHYs
> to be added to otg_transceiver (BTW, that's a mis-naming as
> transceiver aren't only for OTG use-cases).
>
> Anyway, change this phrasing.
>
>> > so removes usb_nop_xceiv_register to make musb working.
>> >
>> > Cc: Felipe Balbi <balbi@ti.com>
>> > Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>
> Considering you change the commit log above:
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
>
> This is ok, but can only go after 2.6.38 merge window. There are patches
> to add support for internal PHY. Ideally we would actually register both
> PHYs and it would work. They would have different capabilities, though.

The current otg only supports one global transceiver, so we have to remove
the nop on Panda.

thanks,
-- 
Lei Ming
