From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [RFC][PATCH] omap3: Unify omap2_set_globals_3[43,6x]x functions
Date: Wed, 30 Jun 2010 10:04:48 +0300
Message-ID: <4C2AEC90.2050709@compulab.co.il>
References: <1277843427-25596-1-git-send-email-saaguirre@ti.com> <4C2AD54A.9070101@compulab.co.il> <20100630063646.GS2822@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:50252 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab0F3HGU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jun 2010 03:06:20 -0400
In-Reply-To: <20100630063646.GS2822@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergio Aguirre <saaguirre@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Mike Rapoport <mike@compulab.co.il>

Tony Lindgren wrote:
> * Mike Rapoport <mike@compulab.co.il> [100630 08:20]:
>> Sergio Aguirre wrote:
>>> The only difference between them is the physical address of the
>>> uart4 port, which is only present in 36xx chips.
>>>
>>> We don't really need to care about keeping these 2 functions, since
>>> the decision to use uart4 is more cleanly done later when we do have
>>> access to omap_revision variable.
>>>
>>> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>>> ---
>>> arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
>>> arch/arm/mach-omap2/board-3630sdp.c        |    2 +-
>>> arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
>>> arch/arm/mach-omap2/board-cm-t35.c         |    2 +-
>>> arch/arm/mach-omap2/board-devkit8000.c     |    2 +-
>>> arch/arm/mach-omap2/board-igep0020.c       |    2 +-
>>> arch/arm/mach-omap2/board-ldp.c            |    2 +-
>>> arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
>>> arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
>>> arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
>>> arch/arm/mach-omap2/board-omap3stalker.c   |    2 +-
>>> arch/arm/mach-omap2/board-omap3touchbook.c |    2 +-
>>> arch/arm/mach-omap2/board-overo.c          |    2 +-
>>> arch/arm/mach-omap2/board-rx51.c           |    2 +-
>>> arch/arm/mach-omap2/board-zoom2.c          |    2 +-
>>> arch/arm/mach-omap2/board-zoom3.c          |    2 +-
>>> arch/arm/plat-omap/common.c                |   10 ++--------
>>> arch/arm/plat-omap/include/plat/common.h   |    3 +--
>>> 18 files changed, 19 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
>>> index dd9c031..4961f3b 100644
>>> --- a/arch/arm/mach-omap2/board-3430sdp.c
>>> +++ b/arch/arm/mach-omap2/board-3430sdp.c
>>> @@ -805,7 +805,7 @@ static void __init omap_3430sdp_init(void)
>>> static void __init omap_3430sdp_map_io(void)
>>> {
>>> -	omap2_set_globals_343x();
>>> +	omap2_set_globals_3xxx();
>>> 	omap34xx_map_common_io();
>>> }
>> Maybe we should take it one step further and replace board_map_io
>> functions with common omap3_map_io?
> 
> Could be done yeah. If special handling is needed, it can still
> be done in the board-*.c files. Care to do a patch for that?

no problem.

> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.
