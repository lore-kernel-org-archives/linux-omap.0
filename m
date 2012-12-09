From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2 0/4] ARM: OMAP4: Clock fixes
Date: Sun, 9 Dec 2012 20:38:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212092038240.351@utopia.booyaka.com>
References: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40272 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934486Ab2LIUii (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 15:38:38 -0500
In-Reply-To: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Mon, 3 Dec 2012, Jon Hunter wrote:

> Fixes included, fixing up timer clock aliases for v3.8 and working
> around ABE DPLL issue seen with latest u-boot bootloader (v2012.10).
> 
> Testing includes:
> - Boot testing on OMAP4460 Panda and verifying that all dmtimers are
>   working.
> 
> V2 changes:
> - Updated series to latest ARM-SoC for-next branch that includes common
>   clock updates for OMAP4.
> - Added new function table for non-M4X DPLLs which is now required after
>   enhancing support for OMAP4 DPLLs for 4X multiplier.

Thanks, queued for 3.8-rc.


- Paul
