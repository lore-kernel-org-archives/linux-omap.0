From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] ARM: OMAP2: Use hwmod to initialize mmc for 2420
Date: Wed, 9 May 2012 14:27:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205091426230.28088@utopia.booyaka.com>
References: <20120424000607.17783.81686.stgit@muffinssi.local> <20120424000835.17783.50945.stgit@muffinssi.local> <alpine.DEB.2.00.1205081844530.28088@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59944 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272Ab2EIU13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 16:27:29 -0400
In-Reply-To: <alpine.DEB.2.00.1205081844530.28088@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Tony,

On Tue, 8 May 2012, Paul Walmsley wrote:

> On Mon, 23 Apr 2012, Tony Lindgren wrote:
> 
> > This allows us to pass dma request lines in platform data to
> > MMC driver the same way as we already do for omap2430 and later.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This might save you some time, I updated this patch to move the device 
> creation code to arch/arm/mach-omap2/msdi.c and to change the hwmod name 
> to 'msdi1' to conform with the new data.  Updated patch below.

One other thing, the version that was sent yesterday was the 
second-to-last revision.  Also needed are the following includes in 
arch/arm/mach-omap2/msdi.c:

#include <linux/err.h>

#include "control.h"


- Paul
