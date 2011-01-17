From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/14] ARM: v6k: do not disable CPU_32v6K based on
 platform selection
Date: Mon, 17 Jan 2011 15:24:11 -0800
Message-ID: <20110117232410.GK4957@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
 <E1PeuhM-0003T1-Js@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34539 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1AQXYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 18:24:16 -0500
Content-Disposition: inline
In-Reply-To: <E1PeuhM-0003T1-Js@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:24]:
> CPU_32v6K controls whether we use the ARMv6K extension instructions in
> the kernel, and in some places whether we use SMP-safe code sequences
> (eg, bitops.)
> 
> MX3 prevents the selection of this option to ensure that it is not
> enabled for their CPU, which is ARMv6 only.  Now that we've split the
> CPU_V6 option, V6K support won't be offered for MX3 anymore.
> 
> OMAP prevents the selection of this option in an attempt to produce a
> kernel which runs on architectures from ARMv6 to ARMv7 MPCore.  We now
> achieve this in a different way (see the previous patches).
> 
> As such, we no longer need to offer this as a configuration option to
> the user.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Tony Lindgren <tony@atomide.com>
