From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/26] ARM: OMAP2+: PRCM cleanups for 3.18 merge window
Date: Fri, 19 Sep 2014 15:47:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1409191547070.22526@utopia.booyaka.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com> <20140918171650.GK14505@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58082 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969AbaISPrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2014 11:47:18 -0400
In-Reply-To: <20140918171650.GK14505@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

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

Yeah, I'll send a few comments today.


- Paul
