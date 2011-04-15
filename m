From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 19:21:44 +0100
Message-ID: <20110415182144.GI4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <4DA85B49.60209@vollmann.ch> <20110415153723.GD4423@n2100.arm.linux.org.uk> <4DA88A77.6050502@vollmann.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48392 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041Ab1DOSWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 14:22:06 -0400
Content-Disposition: inline
In-Reply-To: <4DA88A77.6050502@vollmann.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Detlef Vollmann <dv@vollmann.ch>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 15, 2011 at 08:12:07PM +0200, Detlef Vollmann wrote:
>> Second point is that you'll notice that the code converts to a phys
>> address using this: phys = phys_base + (virt - virt_base).  As soon as
>> we start allowing multiple regions of SRAM, it becomes impossible to
>> provide the phys address without a lot more complexity.
> Yes, I understand that.  This either requires some intrusive changes
> to gen_pool code or quite some additional code in sram_pool_alloc.

It would require sram_pool to track each individual buffer alongside
the similar tracking that gen_pool does, and then look up the returned
address to find out which buffer it corresponds with.

As it looks though, this functionality isn't required on AT91.  So lets
not complicate the code unless we know we have to.  While the alloc/free
API is such that it'll be able to cope if we have to add it later - the
initialization will have to become a little more complex.  And then I
start to wonder if gen_pool should just be extended for the phys address.
