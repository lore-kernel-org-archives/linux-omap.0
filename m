From: Mike Rapoport <mike@compulab.co.il>
Subject: Bug in omap2_nand_gpmc_retime? (was: Re: [PATCH] OMAP: fix gpmc nand
 setup when no timings supplied)
Date: Wed, 28 Apr 2010 18:05:19 +0300
Message-ID: <4BD84EAF.7010104@compulab.co.il>
References: <1271670618-5671-1-git-send-email-mike@compulab.co.il> <4BCFDC6F.6010801@compulab.co.il> <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7ADD@dbde02.ent.ti.com> <4BCFF3C1.5070005@compulab.co.il> <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7B5A@dbde02.ent.ti.com> <4BD00C9A.8050601@compulab.co.il> <20100426181448.GG7225@atomide.com> <4BD695BC.3080109@compulab.co.il> <20100427144734.GX7225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:47682 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab0D1PGf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 11:06:35 -0400
In-Reply-To: <20100427144734.GX7225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren wrote:
> * Mike Rapoport <mike@compulab.co.il> [100427 00:40]:
>> Tony Lindgren wrote:
>>> * Mike Rapoport <mike@compulab.co.il> [100422 01:41]:
>>>> Ghorai, Sukumar wrote:
>>>>
>>>> CM-T35, for instance can be assembled with different NAND flash
>>>> chips. Besides, boards that use NAND as primary boot device, we
>>>> anyway depend on proper GPMC configuration in the bootloader chain.
>>>> Having ability to define GPMC timings in the kernel and keep the
>>>> settings made by the bootloader adds flexibility level for board
>>>> designers.
>>> Not implementing the retime function for GPMC will cause issues
>>> with PM as you cannot scale the L3 frequency without breaking
>>> your GPMC timings.
>> I agree that without retime function scaling the frequency will
>> break the GPMC timings. But my point was that there should be an
>> _option_ to keep the timings defined by the bootloader rather than
>> enforce board files to specify timings.
> 
> Sure. Can you please check one more time your patch and what is
> still missing after Stanley's fix? That's now in omap-fixes and master
> branches as commit 11e1ef2d105900a302b7ca92bcaf96a96d0274a1.
> 
>> Since skipping the retime function will break gpmc timings in
>> PM-enabled  kernel, we need to implement this option in smarter way.
>> E.g. something like:
> 
> Yeah we should print some warning if the retime function is not
> implemented as it can cause mysterious bugs later on. I guess
> implementing a dummy retime function would be best as then the
> warning would be related to the actual L3 rate change.

While working on implementation of gpmc_nand_detect_timings I've seen 
that omap2_nand_gpmc_retime converts the timings supplied by the 
platform to ticks and passes it to gpmc_cs_set_timings which in turn 
converts the timings to ticks. Is it a bug or am I missing something?

> Regards,
> 
> Tony
>  
-- 
Sincerely yours,
Mike.
