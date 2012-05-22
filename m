From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 0/9] ARM: OMAP: DMTIMER clean-up in preparation for device-tree
Date: Tue, 22 May 2012 15:33:05 -0500
Message-ID: <4FBBF801.1010307@ti.com>
References: <1337124914-19921-1-git-send-email-jon-hunter@ti.com> <4FB37356.9040001@ti.com> <4FB40AB5.10302@ti.com> <alpine.DEB.2.00.1205161727200.2921@utopia.booyaka.com> <4FB51FA9.7010202@ti.com> <alpine.DEB.2.00.1205171047580.2921@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58534 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614Ab2EVUdF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 16:33:05 -0400
In-Reply-To: <alpine.DEB.2.00.1205171047580.2921@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Hi Tony, Paul,

On 05/17/2012 11:48 AM, Paul Walmsley wrote:
> On Thu, 17 May 2012, Jon Hunter wrote:
> 
>> Yes that's right. What is your preference here, the options are ...
>>
>> 1. Move the clkt_clksel.c file to arch/arm/plat-omap and change the
>> omap2_xxx API names to omap_xxx.
>> 2. Add the functions in clkt_clksel.c to arch/arm/plat-omap/clock.c and
>> get rid of clkt_clksel.c altogether.
> 
> #1.

I have posted a new series here [1] to fix omap1 dmtimers and commonise
the code to set dmtimer source clock between omap1 and omap2.

My plan is to rebase this series on top of that, if you are ok with
those changes.

[1] http://marc.info/?l=linux-omap&m=133771799505501&w=2

Cheers
Jon
