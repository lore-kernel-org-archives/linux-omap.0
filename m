From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Tue, 27 Jan 2015 17:12:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501271652340.7149@utopia.booyaka.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com> <1422054704-14915-2-git-send-email-balbi@ti.com> <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com> <20150126165640.GA10679@saruman.tx.rr.com> <20150126194933.GG6660@saruman.tx.rr.com>
 <20150127160143.GH14623@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40992 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758650AbbA0RMG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2015 12:12:06 -0500
In-Reply-To: <20150127160143.GH14623@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org

Hi

On Tue, 27 Jan 2015, Felipe Balbi wrote:

> On Mon, Jan 26, 2015 at 01:49:33PM -0600, Felipe Balbi wrote:
> > On Mon, Jan 26, 2015 at 10:56:40AM -0600, Felipe Balbi wrote:
> >
> > > hm... modulemode SWCTRL causes wait_target_ready to fail. Any hints ?
> > 
> > gets stuck in transition state. PRCM_CM_WKUP_DBGSS_CLKCTRL is always
> > read as 0x 12510f00 which would translate into:
> > 
> > - module disabled
> > - all opt clocks are on
> > - module is transitioning
> > - module in standby
> > - clkA as TPIU and STM trace clock
> > - all dividers set to 2
> 
> just fyi, checking with HW folks, this might be a new bug, unless
> debugss needs something special.

If that happens on DEBUGSS disable, it's probably the same issue as on 
AM33xx:

http://www.spinics.net/lists/arm-kernel/msg320801.html
http://www.spinics.net/lists/arm-kernel/msg321930.html
http://www.spinics.net/lists/arm-kernel/msg329151.html

Does adding HWMOD_INIT_NO_IDLE fix the issue you're seeing?


- Paul
