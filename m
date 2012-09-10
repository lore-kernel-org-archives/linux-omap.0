From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/1] ARM: dts: OMAP3: Add gpio-twl4030 properties for
 Overo
Date: Mon, 10 Sep 2012 15:40:04 +0200
Message-ID: <504DEDB4.1070804@ti.com>
References: <1347282996-31190-1-git-send-email-florian.vaussard@epfl.ch> <1347282996-31190-2-git-send-email-florian.vaussard@epfl.ch> <504DEA4E.7080109@ti.com> <504DEC36.4020704@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37676 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab2IJNkP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 09:40:15 -0400
In-Reply-To: <504DEC36.4020704@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Tony Lindgren <tony@atomide.com>, Steve Sakoman <steve@sakoman.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 09/10/2012 03:33 PM, Florian Vaussard wrote:
>>> Support the blue LED connected to the LEDB pin of the TWL4030
>>> on the Gumstix Overo.
>>>
>>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>>> ---
>>>   arch/arm/boot/dts/omap3-overo.dtsi |   15 +++++++++++++++
>>>   1 files changed, 15 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi
>>> b/arch/arm/boot/dts/omap3-overo.dtsi
>>> index d6cc5e2..89808ce 100644
>>> --- a/arch/arm/boot/dts/omap3-overo.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
>>> @@ -13,6 +13,17 @@
>>>
>>>   /include/ "omap3.dtsi"
>>>
>>> +/ {
>>
>> BTW, I'm just wondering. Cannot we use overo without tobi?
>>
>> In that case, the model and compatible should probably be used as well:
>>
>>     model = "TI OMAP3 Gumstix Overo";
>>     compatible = "ti,omap3-overo", "ti,omap3";
> 
> No, it cannot. The Overo needs to be plugged into an expansion board, at
> least to get the power. Hence the absence of model and compatible in
> omap3-overo.dtsi.

OK, cool. I was wondering because we already have a board-overo.c in the
kernel, and there is no mention of tobi.

OK, I'm adding that patch on top of the other then.

Regards,
Benoit

