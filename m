From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/14] ARM: v6k: select clear exclusive code seqences
 according to V6 variants
Date: Mon, 17 Jan 2011 15:15:22 -0800
Message-ID: <20110117231522.GF4957@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peufi-0003Sh-Ej@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26733 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab1AQXP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:15:28 -0500
Content-Disposition: inline
In-Reply-To: <E1Peufi-0003Sh-Ej@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:27]:
> If CONFIG_CPU_V6 is enabled, then the kernel must support ARMv6 CPUs
> which don't have the V6K extensions implemented.  Always use the
> dummy store-exclusive method to ensure that the exclusive monitors are
> cleared.
> 
> If CONFIG_CPU_V6 is not set, but CONFIG_CPU_32v6K is enabled, then we
> have the K extensions available on all CPUs we're building support for,
> so we can use the new clear-exclusive instruction.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
