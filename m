From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 09/14] ARM: v6k: select generic atomic64 code according
 to V6 variants
Date: Mon, 17 Jan 2011 15:21:04 -0800
Message-ID: <20110117232104.GH4957@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1PeugN-0003Sp-0J@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:42170 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab1AQXVK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:21:10 -0500
Content-Disposition: inline
In-Reply-To: <E1PeugN-0003Sp-0J@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:23]:
> If CONFIG_CPU_V6 is enabled, avoid using the double-word exclusive
> instructions in the kernel's atomic implementations as these are not
> supported.  Fall back to the generic spinlock code instead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
