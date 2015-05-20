From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 00/27] ARM: OMAP2+: clock code migration to
 drivers/clk/ti
Date: Wed, 20 May 2015 22:40:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1505202234330.7960@utopia.booyaka.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1505111747460.19833@utopia.booyaka.com> <5551D178.3000904@ti.com> <alpine.DEB.2.02.1505122019220.21747@utopia.booyaka.com> <5552F32C.7060606@ti.com>
 <alpine.DEB.2.02.1505131438430.7921@utopia.booyaka.com> <555B8DC0.5080905@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51211 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbETWkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2015 18:40:16 -0400
In-Reply-To: <555B8DC0.5080905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Tue, 19 May 2015, Tero Kristo wrote:

> Any news on this? As noted previously, I am not able to reproduce the issue
> you are seeing currently, can you give DEBUG_LL a shot?

Yeah I just bisected it, it was caused by this:

commit cc4a5fe972ad7834e8662b49b3a5fdb597e9e15e
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Jan 30 11:18:56 2015 -0600

    arm: config: omap2plus_defconfig: switch over to LZMA compression
    
    LZMA compression makes about 33% smaller zImage
    with just a slight extra decompression time.
    
    Before this patch, zImage built with o2+_dc
    is 4.5MiB and after it's about 3.3MiB.
    
    Suggested-by: David Cohen <david.a.cohen@linux.intel.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>


and the timeouts on the testbed being set to fail if a kernel takes longer 
than five seconds to start.  Seems that the part about a "slight extra 
decompression time" probably only applies to relatively recent chips.


- Paul
