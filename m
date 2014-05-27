From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/7] mfd: twl4030-power: Enable off-idle configuration
 when booted with device tree
Date: Tue, 27 May 2014 10:13:52 -0700
Message-ID: <20140527171351.GA18063@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <20140527165234.GF4227@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11124 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751615AbaE0RN6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 May 2014 13:13:58 -0400
Content-Disposition: inline
In-Reply-To: <20140527165234.GF4227@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [140527 09:53]:
> > Here's an updated set of patches to enable low-power idle modes
> > for some omap3 boards when booted with device tree.
> > 
> > This series when applied on top of the patches in tread                                                                                                       
> > "[PATCH 00/11] Fixes for omap PM for making omap3 DT only",
> > or omap-for-v3.16/pm branch.
> > 
> > Lee, if these patches look OK to you, please feel free to 
> > pick them, preferrably to the immutable branch you already
> > have set up so I can also merge them in to be able to have
> > things working in my branch properly for PM.
> 
> Whoops, nearly forgot about this patchset.
> 
> Tony, can you resend it with all your fix-ups please.  The 8< doesn't
> work well with my patch application 'system'.

Sure I'll do that. FYI, these kind of patches should apply just
fine when piped to git-am --scissors.

Regards,

Tony
