From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V2] ARM: OMAP2+: AM33xx: Fix missing reset status data
 to GFX hwmod
Date: Mon, 20 May 2013 14:39:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1305201439020.6174@utopia.booyaka.com>
References: <1369057116-31423-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53004 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749Ab3ETOjW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 May 2013 10:39:22 -0400
In-Reply-To: <1369057116-31423-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Mon, 20 May 2013, Vaibhav Hiremath wrote:

> GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
> so update the GFX hwmod data with .rstst_off and .st_shift
> information.
> 
> Although it doesn't have impact on kernel boot, but this is
> regression fix from original hwmod commit.
> 

Did it ever work?  If not, then it's not a regression, right?


- Paul
