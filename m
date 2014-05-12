From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree support
Date: Mon, 12 May 2014 11:34:07 +0200
Message-ID: <CABxcv=kwhodeFTHoVpn1nHeh9+kV5fwMN9s3Kbk6h7_xJp4UYA@mail.gmail.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
	<1398815562-24113-4-git-send-email-tony@atomide.com>
	<5369EAE7.3030705@ti.com>
	<20140507150343.GA9502@atomide.com>
	<536A5920.1020908@ti.com>
	<20140507175919.GH9502@atomide.com>
	<20140508233300.GI2198@atomide.com>
	<536C8293.4070506@ti.com>
	<20140509155504.GE17814@atomide.com>
	<53707A64.2060203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:62080 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbaELJeI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 05:34:08 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so5181523wib.2
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 02:34:07 -0700 (PDT)
In-Reply-To: <53707A64.2060203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Tomi,

On Mon, May 12, 2014 at 9:38 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 09/05/14 18:55, Tony Lindgren wrote:
>
>>> Although if the MO gpio is not controlled by the driver, we should tell
>>> the driver whether that gpio is high or low.
>>
>> What do you have in mind for telling that? We should also tell the
>> orientation of the panel:
>>
>> EVM   VGA     omapfb.rotate=3
>> LDP   QVGA    omapfb.rotate=0
>>
>> Do you have something in mind for that?
>
> Hmm, right. I guess all we can do is have boolean flags in the .dts for
> MO, LR and UD, which tells if the respective pins are hard-wires high or
> low. And say in the documentation that you must either have a proper
> GPIO, or use the flag, but not both.
>
> The panel mounting orientation is a different matter. But I think it is
> also something we should specify in the .dts. However, we don't have any
> SW support to handle it, and it's a bit unclear to me how it should be
> handled, so I think that has to be left for later.
>
>>> At the moment our display drivers are OMAP specific, and for that reason
>>> we should prefix the compatible strings with "omapdss,". For example,
>>> drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c:
>>>
>>>      { .compatible = "omapdss,panel-dsi-cm", },
>>>
>>> But we should still have the right compatible string in the .dts, so we
>>> convert the compatible name in arch/arm/mach-omap2/display.c, with
>>> 'dss_compat_conv_list' array, to which this panel's name should be added.
>>
>> Oh so what do you want to have in the .dts file then?
>
> The .dts should have the proper names. The idea of this hackery is that
> in the .dts we can have the proper compatible string. So in the .dts, we
> have, say:
>
> "sony,panel-foobar"
>
> Then, at boot time, omap's platform code changes that to:
>
> "omapdss,sony,panel-foobar".
>
> And our (omap specific) panel-foobar driver use that
> "omapdss,sony,panel-foobar" string.
>
> This way some other platform could do the same, and have their platform
> specific drivers handle the panel.
>
> At some point in the future we hopefully will have common panel drivers,
> and at that point we can remove that hackery. The .dts files will
> already be correct.
>

Maybe we can remove this hackery by relying on the fact that a
compatible string can have a set of values that goes from more
specific to more general. So you can have something like:

compatible = "sony,panel-foobar", "omapdss,panel-foobar"

So right now only "omapdss,panel-foobar" will be matched and later
when we have common panel drivers then that driver could handle the
"sony,panel-foobar" compatible string.

Other platforms could do something similar and have

compatible = "sony,panel-foobar", "baz,panel-foobar"

That way you won't break DT backward compatible but still not require
hacks on arch/arm/mach-omap2/display.c.

We do the same for OMAP boards, we now have the following compatible string:

compatible = "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";

There isn't a struct machine_desc that matches "isee,omap3-igep0020"
but later if we find that we need some board specific initialization
we could add one without breaking existing DTS. In fact it used to be
a single machine_desc that matched "ti,omap3" for both omap36xx and
omap34xx but later when some DT clocks changes were introduced we
needed to split both SoC families.

>  Tomi
>
>

Best regards,
Javier
