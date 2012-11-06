From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 03/14] ARM: OMAP5: id: Add cpu id for ES versions
Date: Tue, 6 Nov 2012 10:18:16 -0800
Message-ID: <20121106181816.GG6801@atomide.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-4-git-send-email-santosh.shilimkar@ti.com>
 <50939A81.8060508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19131 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751178Ab2KFSSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 13:18:22 -0500
Content-Disposition: inline
In-Reply-To: <50939A81.8060508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

* Roger Quadros <rogerq@ti.com> [121102 03:05]:
> Hi Santosh,
> 
> I believe the change from cpu_is_xxx() to soc_is_xxx() just for OMAP5
> leads to unnecessary confusion, even though soc_is_ is more technically
> correct.

All of them will be eventually soc_is_xxx() and private to
arch/arm/mach-omap2.

Regards,

Tony
