From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: Re: [PATCH 12/18] OMAP3 clock: split out DPLL3 M2 divider functions
 into clkt3xxx_dpll3m2.c
Date: Wed, 20 Jan 2010 19:26:46 +0530
Message-ID: <4B570B9E.9060104@ti.com>
References: <20100115090613.30690.49355.stgit@localhost.localdomain> <20100115090703.30690.171.stgit@localhost.localdomain> <20100115125014.GK29059@shisha.kicks-ass.net> <alpine.DEB.2.00.1001191128120.3977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41396 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694Ab0ATN5I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 08:57:08 -0500
In-Reply-To: <alpine.DEB.2.00.1001191128120.3977@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Alexander Shishkin <virtuoso@slind.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?ISO-8859-1?Q?Jouni_H=F6gander?= <jouni.hogander@nokia.com>

Paul,

On Wed, 20-Jan-10 12:06 AM +0530, Paul Walmsley wrote:
> (cc'ing Ranjith)
> 
> Hi Alexander,
> 
> On Fri, 15 Jan 2010, Alexander Shishkin wrote:
> 
>> On Fri, Jan 15, 2010 at 02:07:04 -0700, Paul Walmsley wrote:
>>> Split the DPLL3 M2 divider clock functions out of clock34xx.c and move them
>>> into clkt3xxx_dpll3m2.c to improve maintainability.
>> I'm not very familiar with maintainability issues of dpll3m2, so
>> forgive me if it is ignorant for me to ask you to elaborate on this.
> 
> That is a very good point, those original patch changelogs are pretty 
> crappy.  "OMAP clock code - same great taste, now with more 
> maintainability!"  I will update them and repost with more detail.
> 
>> It does look like a bit of an overkill to have a separate file for
>> a divider. But again, I might well be missing the point.
> 
> Yep, this is definitely a borderline case where it might be more 
> appropriate to keep it in the clock34xx.c file.  What ultimately motivated 
> splitting it out was the thought that the AM3517/3505 chips probably won't 
> need this function, since I don't believe they support DVFS [1], so we 
> could skip compiling this function for kernels built for those devices via 
> the Makefile, and not need #ifdefs. 
> 
> Ranjith, could you correct me if I am wrong about the DVFS part?

You are right, AM35xx devices do not support DVFS. In fact, the only
power management support planned is for the suspend/resume capability
with retention (no off mode)

> 
> 1. AM35x ARM Microprocessor Technical Reference Manual, 
>    http://www.ti.com/litv/pdf/sprugr0

 - Ranjith
