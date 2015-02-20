From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 9/9] RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
Date: Fri, 20 Feb 2015 14:59:28 +0200
Message-ID: <54E72FB0.6000604@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>	<1423840286-18377-10-git-send-email-tomi.valkeinen@ti.com> <CAGo_u6p89ot-eNwK65otoYsLM6NXeh929=SBG6uKAsX8Tnd_RQ@mail.gmail.com> <54DE1B7E.10505@ti.com> <54E71EA2.3030803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33508 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754010AbbBTM7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Feb 2015 07:59:44 -0500
In-Reply-To: <54E71EA2.3030803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

On 02/20/2015 01:46 PM, Tomi Valkeinen wrote:
> On 13/02/15 17:42, Tero Kristo wrote:
>> On 02/13/2015 05:25 PM, Nishanth Menon wrote:
>
>>> I would probably wait for control module to become syscon and probably
>>> model this as syscon clk - I thin we should be seeing a series
>>> sometime soon.
>>
>> Yeah, I will be posting a series in a bit, just running some final tests
>> on it.
>
> I did the above with Tero's series. Adding the DES HDCP clock works ok.
>
> However, I'm not able to do this in HWMOD framework. To enable the DSS
> IP block I need to enable both the DSS func clock and the DES HDCP
> clock, but the HWMOD framework only allows one mainclock.
>
> I added the HDCP clock as an opt clock, but those are not enabled
> intially by the HWMOD framework, and the call in omap_hwmod.c:_enable()
> to soc_ops.wait_target_ready(oh) calls fails.
>
> So... Any ideas how to proceed?

Add the clock enable at the end of dra7xx_dt_clk_init()?

You need to disable the clock at some point though.

-Tero
