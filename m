From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: DMA: Fix DMA channel end definition for
 OMAP36xx-PLUS devices
Date: Mon, 5 Mar 2012 14:22:16 -0800
Message-ID: <20120305222216.GC12083@atomide.com>
References: <1330650621-10887-1-git-send-email-jon-hunter@ti.com>
 <4F515529.1050005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48921 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab2CEWWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 17:22:18 -0500
Content-Disposition: inline
In-Reply-To: <4F515529.1050005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Jon Hunter <jon-hunter@ti.com> [120302 14:47]:
> 
> Oops! I see that Peter has already fixed this one [1].
> 
> Peter, looking at your fix it is good for OMAP4 but should we also
> fix for OMAP5 while we are at it? I checked and the register map is
> the same for OMAP5.
> 
> Tony, I still think we should get rid of cpu_is_omap4430() altogether [2].

OK, makes sense. Applying [2] into fixes-non-critical-part2.

Thanks,

Tony 


> [1] http://www.spinics.net/lists/linux-omap/msg65459.html
> [2] http://www.spinics.net/lists/linux-omap/msg65702.html
