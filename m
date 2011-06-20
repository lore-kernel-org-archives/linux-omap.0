From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
Date: Mon, 20 Jun 2011 02:48:46 -0700
Message-ID: <20110620094846.GG23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
 <20110620092341.357.14183.stgit@kaulin>
 <4DFF1558.4020509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10616 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753275Ab1FTJsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 05:48:51 -0400
Content-Disposition: inline
In-Reply-To: <4DFF1558.4020509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110620 02:35]:
> On 6/20/2011 2:53 PM, Tony Lindgren wrote:
> >This removes the support for setting the wake-up timer for debugging.
> >
> >Later on we can reserve gptimer1 for PM code only and have similar
> >functionality.
> >
> >Signed-off-by: Tony Lindgren<tony@atomide.com>
> >Reviewed-by: Kevin Hilman<khilman@ti.com>
> >---
> 
> Kevin cleaned up this with a better patch.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg50015.html
> 
> May be we can use that patch instead of this.

The thing is that it's a omap specific debug interface.

I'd rather just get rid of it until there's some generic way
of doing it. Maybe Kevin can just carry it along in the PM
branch for now?

Tony
