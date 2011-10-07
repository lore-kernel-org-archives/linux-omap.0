From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/4] ARM: OMAP: Map SRAM later on with ioremap_exec()
Date: Fri, 07 Oct 2011 12:22:17 +0530
Message-ID: <4E8EA1A1.5070508@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local> <20111005004546.26980.31836.stgit@kaulin.local> <alpine.LFD.2.02.1110042107230.9106@xanadu.home> <20111005221320.GE6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:55383 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755700Ab1JGGwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 02:52:23 -0400
Received: by gyg8 with SMTP id 8so4362782gyg.34
        for <linux-omap@vger.kernel.org>; Thu, 06 Oct 2011 23:52:22 -0700 (PDT)
In-Reply-To: <20111005221320.GE6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 06 October 2011 03:43 AM, Tony Lindgren wrote:
> * Nicolas Pitre <nico@fluxnic.net> [111004 17:34]:
>> On Tue, 4 Oct 2011, Tony Lindgren wrote:
>>
>>> This allows us to remove omap hacks for map_io.
>>>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> Nice cleanup.
>>
>> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> This one needed minor changes for the omap1 omap_sram_init
> call. Updated patch below, still assuming I have your ack
> for this one too.
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 4 Oct 2011 13:52:57 -0700
> Subject: [PATCH] ARM: OMAP: Map SRAM later on with ioremap_exec()
> 
> This allows us to remove omap hacks for map_io.
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 

Are you considering this change for 3.2?
OMAP4 errata WA would have a conflict with the
change is sram code and hence the question ?

O.w patch looks fine to me.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	
