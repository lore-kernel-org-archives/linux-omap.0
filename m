From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 42/75] ARM: l2c: omap2: implement new write_sec method
Date: Fri, 28 Mar 2014 08:56:11 -0700
Message-ID: <20140328155611.GB24308@atomide.com>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYXh-0007Fh-BP@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36237 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750974AbaC1P4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2014 11:56:20 -0400
Content-Disposition: inline
In-Reply-To: <E1WTYXh-0007Fh-BP@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:21]:
> With the write_sec method, we no longer need to override the default
> L2C disable method, and we no longer need the L2C set_debug method.
> Both of these can be handled via the write_sec method.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
