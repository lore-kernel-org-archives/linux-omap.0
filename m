From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Tue, 25 Feb 2014 08:54:22 +0100
Message-ID: <530C4C2E.8040606@epfl.ch>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>	<1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>	<20140224180336.GU27282@n2100.arm.linux.org.uk> <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:50189 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbaBYHyc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Feb 2014 02:54:32 -0500
In-Reply-To: <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ash Charles <ash@gumstix.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Russell, Javier,

On 02/24/2014 09:22 PM, Javier Martinez Canillas wrote:
> Hi Russell,
> 
> On Mon, Feb 24, 2014 at 3:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Feb 24, 2014 at 06:07:49PM +0100, Florian Vaussard wrote:
>>> +     hdmi0: connector@0 {
>>> +             compatible = "hdmi-connector";
>>
>> This looks way to generic a compatible string.  Are you sure it's
>> correct?
>>
> 
> That compatible string is correct according to the latest series
> posted by Tomi Valkeinen to add DT bindings for the OMAP Display
> SubSystem (DSS) [0].
> 

Indeed, this compatible string comes from the DSS series.

> The property is added on this patch [1] and as far as I understood the
> idea is that it could be a generic DT binding that can be used by
> platform specific HDMI connectors like the omap dss HDMI connector
> [2].
> 

On the other side, looking at
drivers/video/omap2/displays-new/connector-hdmi.c from the DSS series
[1], the compatible string is "omapdss,hdmi-connector", which makes me
wonder which one should be used :) BTW, "omapdss" seems a strange
prefix, isn't it?

Tomi, any inputs?

Regards,
Florian

[1]
https://git.kernel.org/cgit/linux/kernel/git/tomba/linux.git/tree/drivers/video/omap2/displays-new/connector-hdmi.c?h=work/dss-dt-review-3
