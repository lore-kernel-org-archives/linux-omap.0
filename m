From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Fri, 19 Sep 2014 16:30:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409191606310.22526@utopia.booyaka.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com> <20140918171650.GK14505@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58607 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757428AbaISQaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2014 12:30:13 -0400
In-Reply-To: <20140918171650.GK14505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 18 Sep 2014, Tony Lindgren wrote:

> * Tero Kristo <t-kristo@ti.com> [140901 11:09]:
> > Hi,
> > 
> > This set contains PRCM related cleanups meant for 3.18 merge window.
> > These are based on top of 3.17-rc1 + the PRM set from Nishanth Menon
> > (http://article.gmane.org/gmane.linux.ports.arm.kernel/350305.) Nishanth's
> > set is used as basis to avoid merge issues.
> > 
> > Purpose of this work is to eventually convert the PRCM code into a
> > separate driver, but this is done in incremental parts as the amount
> > of changes is substantial. Expected conclusion of this work is 3.19
> > if everything goes fine.
> > 
> > This part of the work mostly moves some of the SoC specific PRCM driver
> > calls under generic version of the same, and adds SoC-ops to support
> > these on the driver level.
> > 
> > Working branch posted here:
> > 
> > tree: https://github.com/t-kristo/linux-pm.git
> > branch: for-v3.18/prcm-cleanup
> 
> Paul, any comments on this series?

Patches 1, 3, 5, 8, 10, 13, 17, 18, 20, 21, 22, 23, 24 are:

Acked-by: Paul Walmsley <paul@pwsan.com>

Here are some specific comments on a few other patches:

Regarding patch 7:  The kerneldoc-nano function comments are good, but 
should begin with "/**" rather than "/*".  When that's fixed, it can be 
considered acked by me.

Regarding patches 14, 15, 16: Non-static prm_* functions really should 
start with omap*_ to avoid potential naming conflicts with other drivers 
when these are moved to drivers/.  (Obviously the same would apply for any 
CM function names in other, future patches.)  When that's fixed, it can be 
considered acked by me.

Regarding patch 25: What are "I/O wakeup gaes" -- gates?  When that's 
fixed, an acked-by for me can be added.

Regarding patch 26: It seems wise to ensure that omap_prm_reset_system() 
ends with a 'while(1) { cpu_relax(); }' or something similar, to ensure 
that execution flow does not proceed past that point. At that point, it 
should be possible to remove the "while(1) {}"s from omap44xx_restart(), 
omap2xxx_restart(), etc.  When that's fixed, an acked-by for me can be 
added.

...

And some general comments: none of which should probably block this 
series, but seemed worth noting:

Regarding patches 6 and 19: Tero, could you please share the DT node data 
that you're planning to submit for the PRM, CM1, and CM2 on the OMAP4* 
platforms? According to the TRM, these are separate IP blocks, with 
separate OCP header register areas.  So these should probably have 
separate DT nodes, regs, etc. if the DTS files are to match the hardware.  
The planned DTS data may impact the way these patches are written, at 
least, if more patches are to be avoided later.

As far as patches 2, 4, 9, 11, and 12 go, I'll let those go without 
comment.


- Paul
