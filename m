From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: SRAM: Fix warning: format '%08lx' expects type
 'long unsigned int'
Date: Tue, 31 May 2011 03:23:30 -0700
Message-ID: <20110531102330.GS11352@atomide.com>
References: <1301907896-30954-1-git-send-email-santosh.shilimkar@ti.com>
 <20110404091223.GA19854@n2100.arm.linux.org.uk>
 <4D9993AD.3080401@ti.com>
 <20110428140953.GD19709@n2100.arm.linux.org.uk>
 <20110503105555.GR2092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17696 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751951Ab1EaKXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 06:23:34 -0400
Content-Disposition: inline
In-Reply-To: <20110503105555.GR2092@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110503 03:52]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110428 07:06]:
> > 
> > This looks much better.
> > 
> > Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > It looks like Tony hasn't taken it...  Tony, are you going to handle
> > this patch?
> 
> I can add it into my devel-cleanup branch for next merge window
> assuming it won't conflict with your sram changes. If there's a
> conflict, then you can take it.
> 
> I'd rather not merge it in the -rc cycle this late as it's not
> in the oopses or major regressions category.

Got this one finally queued as a fix.

Tony
