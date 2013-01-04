From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: hwmod: rename flag to prevent hwmod
 code from touching IP block during init
Date: Fri, 4 Jan 2013 21:52:42 +0100
Message-ID: <50E7411A.1030207@ti.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com> <1357304526-21557-2-git-send-email-s-guiriec@ti.com> <alpine.DEB.2.00.1301041817460.25868@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60666 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab3ADUwv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jan 2013 15:52:51 -0500
In-Reply-To: <alpine.DEB.2.00.1301041817460.25868@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tero Kristo <t-kristo@ti.com>, Jon Hunter <jon-hunter@ti.com>

On 01/04/2013 07:19 PM, Paul Walmsley wrote:
> Hi Sebastien
>
> On Fri, 4 Jan 2013, Sebastien Guiriec wrote:
>
>> Rename HWMOD_EXT_OPT_MAIN_CLK flag to indicate that this IP block is
>> dependent on an off-chip functional clock that is not guaranteed to
>> be present during initialization. Same flag can be use for IP with
>> additional HW registers to control Auto IDLE mode.
>>
>> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
>
> We already have the HWMOD_NO_INIT_RESET flag.  Wouldn't that accomplish
> the same goal?

I am assuming that it was HWMOD_INIT_NO_RESET flag. This is not solving 
the issue. After boot with this mode some of same clocks are still not 
gated.

>
> Also I think we can reset the AESS during init.  I posted a patch for this
> a few months ago, but looks like it got lost.  Will reply to one of your
> other patches with more details.
>
>
> - Paul
>

