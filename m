From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 0/7] ARM: OMAP2+: System timer updates
Date: Mon, 4 Feb 2013 11:47:36 -0600
Message-ID: <510FF438.9090103@ti.com>
References: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50073 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754416Ab3BDRrn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Feb 2013 12:47:43 -0500
In-Reply-To: <1359999786-8740-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>


On 02/04/2013 11:42 AM, Jon Hunter wrote:
> This series consists mainly of clean-ups for clockevents and
> clocksource timers on OMAP2+ devices. The most significant change
> in functionality comes from the 5th patch which is changing the
> selection of the clocksource timer for OMAP3 and AM335x devices
> when gptimers are used for clocksource. This change came about from
> Vaibhav Bedia's series for AM335x [1]. See patch for more details on
> the exact nature of the change.
> 
> Boot tested with and without  device-tree on OMAP2420 H4, OMAP3430 SDP,
> OMAP3430 Beagle Board, OMAP4430 SDP and AM335x EVM (AM335x only
> supports device-tree boot). Also boot tested boards with kernel boot
> parameter "clocksource=gp_timer".
> 
> This series is based upon ARM-SoC next branch.
> 
> V2 changes:
> - Fixed bug in patch that updates clocksource and clockevents timer
>   names to use the hwmod timer names (thanks Vaibhav Bedia!)
> - Updated patch that removes the hard-coded ID test to return an error
>   as soon as clk_set_parent fails instead of waiting for the end of the
>   function.
> - Fixed bug in patches that "simplify system timer clock definitions"
>   and "simplify system timer definitions" that was prevent omap4/5
>   boards from booting with kernel boot parameter "clocksource=gp_timer".
> - Updated changelog for patch "simplify system timer definitions" per
>   feedback received from Igor.
> - Added new patch to store the timer ID in the omap_dm_timer structure
>   to clean-up the code.
> - Added new patch to fix a sparse warning seen in ARM-SOC next.
> 
> [1] https://patchwork.kernel.org/patch/1921421/
> 
> 
> Jon Hunter (7):
>   ARM: OMAP2+: Fix selection of clockevent timer when using device-tree

Ugh, sorry something got screwed up here. This was not meant to be
included and I am missing another patch. Will resend this series.

Jon
