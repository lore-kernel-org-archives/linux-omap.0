From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
Date: Mon, 28 Oct 2013 15:25:54 +0100
Message-ID: <CABxcv==91JA9Fb_LUBX57YCgwYwgx6FMGdw39==1tGtDPtUKYA@mail.gmail.com>
References: <20130517191304.468.73487.stgit@localhost>
	<20130517191751.468.89202.stgit@localhost>
	<20130520095447.GR21614@n2100.arm.linux.org.uk>
	<20130706131057.GU21614@n2100.arm.linux.org.uk>
	<20130706133627.GV21614@n2100.arm.linux.org.uk>
	<20130708093410.GT5523@atomide.com>
	<20130708142103.GX21614@n2100.arm.linux.org.uk>
	<51ECFDFD.60102@ti.com>
	<CAAwP0s2pGM6RRhkzhZ+_8BsCKP0posFrn7buTwUzLWWC5apE2A@mail.gmail.com>
	<526E6765.3030403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:61696 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab3J1OZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Oct 2013 10:25:55 -0400
Received: by mail-we0-f177.google.com with SMTP id x55so6437738wes.8
        for <linux-omap@vger.kernel.org>; Mon, 28 Oct 2013 07:25:54 -0700 (PDT)
In-Reply-To: <526E6765.3030403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, arm@kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 28, 2013 at 2:32 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 27/10/13 15:26, Javier Martinez Canillas wrote:
>
>> When booting with DT the omapfb's probe is deferred several times but
>> it always fails on dpi_connect() due not being able to get the
>> VDDS_DSI regulator:
>
> The problem with DT boot is that the VDDS_DSI is not linked to the DPI
> device. For omap4, we have a few hacks to go around this (see dsi.c,
> dsi_regulator_init()).
>

I see, I'll add a dpi_regulator_init() to
drivers/video/omap2/dss/dpi.c to workaround this.

>> So I tried adding this to my DT with no luck.
>>
>> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
>> b/arch/arm/boot/dts/omap3-igep0020.dts
>> index 17a6fc1..eaae935 100644
>> --- a/arch/arm/boot/dts/omap3-igep0020.dts
>> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>> @@ -256,3 +256,8 @@
>>  &usbhsehci {
>>         phys = <&hsusb1_phy>;
>>  };
>> +
>> +&vpll2 {
>> +        supply-dev = "omapdss_dpi.0";
>> +        supply = "vdds_dsi";
>> +};
>
> I didn't see "supply-dev" defined in dt bindings documentation, is that
> supposed to work? If it should work, then the problem could be solved
> with the above. Otherwise I guess we must add more hacks to omapdss
> driver, to all places where it uses regulator_get...
>

Yes I didn't find on the DT binding documentation either but saw it
before on a DTS someone shared on linux-omap so I thought it was just
a matter of outdated documentation. But I guess it was the other way
around, that DTS was for a vendor kernel which added that supply-dev
property.

>  Tomi
>
>

Thanks a lot for your help!
Javier
