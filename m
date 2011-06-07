From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Tue, 7 Jun 2011 09:27:13 +0200
Message-ID: <4DEDD2D1.4070900@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>	 <4DECCE90.6070201@ti.com> <1307429265.1858.6.camel@deskari>	 <4DEDCF73.9030607@ti.com> <1307431291.1858.15.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48038 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab1FGH1R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jun 2011 03:27:17 -0400
In-Reply-To: <1307431291.1858.15.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On 6/7/2011 9:21 AM, Valkeinen, Tomi wrote:
> On Tue, 2011-06-07 at 09:12 +0200, Cousson, Benoit wrote:
>> On 6/7/2011 8:47 AM, Valkeinen, Tomi wrote:
>
>>> I'd rather hope the optional clock could be enabled whenever the driver
>>> needs it, between enabling and disabling the hwmod.
>>
>> Yeah, this is the case most of the time, except for you.
>
> Are you talking only about the DSS_FCLK opt-clock from PRCM, or all DSS
> opt clocks (sys clk, hdmi clk, tv clk, dac clock)?
>
> I hope the rest of the opt clocks can be enabled later. Although I guess
> all/many of them will be needed during reset, but that should be already
> handled by the hwmod fmwk.

Yes, sorry, for the confusion, but the point is that they all look the 
same to me :-)

The PRCM does not make any difference for any of these opt_clock, they 
are all under SW control.

Except that one of them must be enabled because internally it is used as 
a functional clock.

Benoit
