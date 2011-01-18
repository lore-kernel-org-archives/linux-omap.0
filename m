From: Tony Lindgren <tony@atomide.com>
Subject: Re: Fwd: [RFC 4/5] ARM: P2V: introduce phys_to_virt/virt_to_phys
 runtime patching
Date: Tue, 18 Jan 2011 12:37:07 -0800
Message-ID: <20110118203706.GR4957@atomide.com>
References: <20110118183252.GJ16980@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55198 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab1ARUhT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 15:37:19 -0500
Content-Disposition: inline
In-Reply-To: <20110118183252.GJ16980@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110118 10:32]:
> A warning for OMAP.
> 
> Your use of the __virt_to_phys() in assembly code for the debug stuff
> will break with this patch... please ensure that it is resolved by the
> next merge window.

Sure thanks. I'm aware of this series, will take care of it.

Tony
