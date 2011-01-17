From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/14] ARM: v6k: only allow SMP if we have v6k or v7 CPU
Date: Mon, 17 Jan 2011 15:25:14 -0800
Message-ID: <20110117232514.GM4957@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1Peui1-0003T9-6Q@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43688 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab1AQXZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:25:19 -0500
Content-Disposition: inline
In-Reply-To: <E1Peui1-0003T9-6Q@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:25]:
> SMP extensions are only supported on ARMv6k or ARMv7 architectures, so
> only offer the option if we're building for such an architecture.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
