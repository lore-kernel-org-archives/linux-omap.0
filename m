From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/1] ARM: dts: OMAP3: Add gpio-twl4030 properties for
 Overo
Date: Mon, 10 Sep 2012 16:07:39 +0200
Message-ID: <504DF42B.1060307@epfl.ch>
References: <1347282996-31190-1-git-send-email-florian.vaussard@epfl.ch> <1347282996-31190-2-git-send-email-florian.vaussard@epfl.ch> <504DEA4E.7080109@ti.com> <504DEC36.4020704@epfl.ch> <504DEDB4.1070804@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:48341 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752862Ab2IJOHn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 10:07:43 -0400
In-Reply-To: <504DEDB4.1070804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Steve Sakoman <steve@sakoman.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

>>>
>>> BTW, I'm just wondering. Cannot we use overo without tobi?
>>>
>>> In that case, the model and compatible should probably be used as well:
>>>
>>>      model = "TI OMAP3 Gumstix Overo";
>>>      compatible = "ti,omap3-overo", "ti,omap3";
>>
>> No, it cannot. The Overo needs to be plugged into an expansion board, at
>> least to get the power. Hence the absence of model and compatible in
>> omap3-overo.dtsi.
>
> OK, cool. I was wondering because we already have a board-overo.c in the
> kernel, and there is no mention of tobi.

In board-overo.c, the various features of each expansion board are
configured using CONFIG_* options, which is not possible when booting
with a device tree.

Regards,
Florian
