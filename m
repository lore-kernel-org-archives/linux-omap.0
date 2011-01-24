From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Mon, 24 Jan 2011 12:26:29 -0800
Message-ID: <20110124202629.GE13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110123174814.GI30094@n2100.arm.linux.org.uk>
 <20110124201731.GC13589@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16249 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1AXU0u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 15:26:50 -0500
Content-Disposition: inline
In-Reply-To: <20110124201731.GC13589@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110124 12:16]:
> 
> So far tested on zoom3 only, but the following gets it booting
> on top of your patch.

Looks like there are some other patches needed too.. At least
omap4 still fails with these.

Tony
