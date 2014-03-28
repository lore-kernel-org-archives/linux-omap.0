From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/75] ARM: l2c: omap2: remove ES1.0 support
Date: Fri, 28 Mar 2014 08:54:43 -0700
Message-ID: <20140328155443.GA24308@atomide.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYUR-0004W9-RD@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11249 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaC1PzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2014 11:55:05 -0400
Content-Disposition: inline
In-Reply-To: <E1WTYUR-0004W9-RD@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:18]:
> Santosh says:
> > But we should kill all of that since we long back decided to remove
> > ES1.0 related code. The mach-omap code alreasy has removed the ES1.0
> > compatibility so feel free to remove any specific ES1.0
> > related stuff. That silicon is long dead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Makes sense to me to make the handling generic:

Acked-by: Tony Lindgren <tony@atomide.com>
