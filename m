From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Patch for proper Cortex-A8 cache configuration output
Date: Fri, 8 Aug 2008 13:40:11 +0300
Message-ID: <20080808104007.GU24923@atomide.com>
References: <489B24DA.4020008@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62860 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbYHHKkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 06:40:13 -0400
Content-Disposition: inline
In-Reply-To: <489B24DA.4020008@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [080807 19:38]:
>
> Recent ARM kernel doesn't detect and output Cortex-A8 cache  
> configuration correctly. Result is something like this in kernel's boot 
> messages:
>
> -- cut --
> ...
> CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=00c5387f
> ...
> CPU0: D VIPT write-through cache
> CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets
> ...
> -- cut --
>
> Catalin sent a patch for this to linux-arm-kernel list:
>
> http://lists.arm.linux.org.uk/lurker/message/20080704.150532.983f01ca.en.html
>
> Result:
>
> -- cut --
> ...
> CPU0: L1 I VIPT cache. Caches unified at level 2, coherent at level 3
> CPU0: Level 1 cache is separate instruction and data
> CPU0: I cache: 16384 bytes, associativity 4, 64 byte lines, 64 sets,
>       supports RA
> CPU0: D cache: 16384 bytes, associativity 4, 64 byte lines, 64 sets,
>       supports RA WB WT
> CPU0: Level 2 cache is unified
> CPU0: unified cache: 262144 bytes, associativity 8, 64 byte lines, 512  
> sets,
>       supports WA RA WB WT
> ...
> -- cut --
>
> Some people really like this and this patch is used in some private  
> trees, e.g. for BeagleBoard.
>
> Unfortunately, RMK doesn't like the patch. He prefers to completely  
> remove 'broken' configuration output completely.
>
> What's about applying this patch locally to OMAP git until upstream ARM 
> kernel has a fix/remove solution for this?

Yeah, let's try it out next week after updating to rc2. There will be
also move of the headers to go under plat-omap, so let's get all that
done first.

Tony


>
> Many thanks
>
> Dirk
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
