From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/2] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 25 Mar 2011 14:24:46 +0100
Message-ID: <201103251424.47141.arnd@arndb.de>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <201103251249.32578.arnd@arndb.de> <4D8C85DB.6060001@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54114 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab1CYNY4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 09:24:56 -0400
In-Reply-To: <4D8C85DB.6060001@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andy.green@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, x0132446@ti.com, s-jan@ti.com, tony@atomide.com

On Friday 25 March 2011, Andy Green wrote:
> Having a proper MAC from IEEE assigned for each interface is of course 
> ideal.
> 
> But even if that happened today though, on Panda there is no "board 
> identity storage" to put the reserved MAC addresses in to bind it to the 
> physical board.  If you try to manage them on SD Card, you have the 
> problem of dealing with correct MAC addresses needing putting there 
> again every time it is nuked.  So it doesn't in itself help in the Panda 
> case.

What I meant is computing an official MAC address from the same input
data as you already do. Unfortunately that would mean having at most 24
bits available instead of the 44 or so bits you currently use, because
the upper half of the address then becomes fixed.

Also it would require
1. defining an new algorithm that computes the lower 24 bits from the
   die ID in a way that minimises the chances of collision
2. Getting an official identifier for the upper half of the address
   assigned to the OMAP3/OMAP4 CPUs
3. Documenting this method in the OMAP data sheets.

	Arnd
