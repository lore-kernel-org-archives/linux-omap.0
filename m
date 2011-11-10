From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix map_io for Amstrad E3
Date: Fri, 11 Nov 2011 00:33:08 +0100
Message-ID: <201111110033.09159.jmkrzyszt@gmail.com>
References: <B8A6ED05-78AC-4140-A9B8-8265F1E9C32F@iki.fi> <20111110000421.GU31337@atomide.com> <B1EBACB3-C974-43B7-AE8A-61C000E285AF@iki.fi>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59473 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab1KJXdb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Nov 2011 18:33:31 -0500
Received: by fagn18 with SMTP id n18so1166460fag.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Nov 2011 15:33:30 -0800 (PST)
In-Reply-To: <B1EBACB3-C974-43B7-AE8A-61C000E285AF@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 10 of November 2011 at 01:28:58, Aaro Koskinen wrote:
> Hi,
> 
> On 10.11.2011, at 2.04, Tony Lindgren wrote:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [111109 15:25]:
> >> On 10.11.2011, at 1.39, Russell King - ARM Linux wrote:
> >>> On Wed, Nov 09, 2011 at 03:25:25PM -0800, Tony Lindgren wrote:
> >>>> Commit 7b88e62f5d219a86d81bdf4388012c97dc42e8f8 (ARM: OMAP1: Use
> >>>> generic
> >>>> map_io, init_early and init_irq) changed omap1 to use generic  
> >>>> map_io.
> >>>>
> >>>> Looks like I missed one board though. Fix this by adding a custom
> >>>> map_io for Amstrad E3.
> >>>>
> >>>> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
> >>>>
> >>>> ---
> >>>> Untested, does this help?
> >>>> --- a/arch/arm/mach-omap1/board-ams-delta.c
> >>>> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> >>>> @@ -302,8 +302,6 @@ static void __init ams_delta_init(void)
> >>>> 	omap_cfg_reg(J19_1610_CAM_D6);
> >>>> 	omap_cfg_reg(J18_1610_CAM_D7);
> >>>>
> >>>> -	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
> >>>> -
> >>>
> >>> This is definitely wrong.  Using iotable_init() after map_io has
> >>> returned
> >>> has (and remains) a serious bug - doing so may _appear_ to work
> >>> but as it
> >>> doesn't obtain its memory from the standard kernel memory
> >>> allocators, it
> >>> will lead to duplicate usage of that memory.
> >>
> >> Also, the patch did not help. It still hangs like before.
> >
> > Hmm that patch is needed for sure but sounds like there's also
> > something else wrong.. Can you try to git bisect it?
> 
> Ok, I'll try bisecting tomorrow.

Hi Aaro,
Please let me know if you think I could help, or I'll wait for your
findings, to avoid duplicating efforts.

Thanks,
Janusz
