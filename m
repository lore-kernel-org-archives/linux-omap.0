From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/14] ARM: v6k: select cmpxchg code sequences
 according to V6 variants
Date: Mon, 17 Jan 2011 15:18:24 -0800
Message-ID: <20110117231823.GG4957@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peug2-0003Sl-IM@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:41122 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab1AQXSg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:18:36 -0500
Content-Disposition: inline
In-Reply-To: <E1Peug2-0003Sl-IM@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:23]:
> If CONFIG_CPU_V6 is enabled, we must avoid the byte/halfword/doubleword
> exclusive operations, which aren't implemented before V6K.  Use the
> generic versions (or omit them) instead.
> 
> If CONFIG_CPU_V6 is not set, but CONFIG_CPU_32v6K is enabled, we have
> the K extnesions, so use these new instructions.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
