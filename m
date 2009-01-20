From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: BUG: LDP - smc911x region too small
Date: Tue, 20 Jan 2009 14:36:43 +0800
Message-ID: <1232433403.31748.8.camel@localhost>
References: <20090119223750.GL18301@n2100.arm.linux.org.uk>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:65221 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbZATG17 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Jan 2009 01:27:59 -0500
In-Reply-To: <20090119223750.GL18301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

On Mon, 2009-01-19 at 22:37 +0000, Russell King - ARM Linux wrote:
> At the moment:
> 
>         ldp_smc911x_resources[0].start = cs_mem_base + 0x0;
>         ldp_smc911x_resources[0].end   = cs_mem_base + 0xf;
> 
> However, the SMC911x driver wants to claim 256 bytes from this region.
> Indeed, its register set definitions appears to indicate that its needs
> more than 16 bytes of address space.
> 
> So, the question is what is the right fix?
> 
> Unfortunately, fixing this will cause problems with the SMSC911x patches,
> so I'd like to get an answer on this sooner rather than later please.

Here should be 0x100. Fixing this won't cause problems with smsc911x
patches.

Stanley.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
