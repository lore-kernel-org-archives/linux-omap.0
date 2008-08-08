From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Fri, 8 Aug 2008 08:16:30 +0100
Message-ID: <20080808071630.GA2155@flint.arm.linux.org.uk>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com> <1218016428.25235.11.camel@pc1117.cambridge.arm.com> <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com> <20080807073035.GA10255@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com> <20080807192531.GF5737@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com> <20080807212033.GH5737@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB835@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53814 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbYHHHRM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 03:17:12 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361FBB835@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, Aug 07, 2008 at 06:07:50PM -0500, Woodruff, Richard wrote:
> If I write a series of control register commands to device A, then
> write a go operation to device  B, I would hope all of A's writes
> had completed before B gets the go.  SO gives you this.  DEVICE may
> not with out barriers.

This, I think, is where the problem lies.

Device regions of the same type *are* ordered with respect to each other.

So, shared device accesses occur in program order.  Unshared device
accesses occur in program order.

However, shared device accesses may occur out of order with unshared
device accesses or memory accesses.  Unshared device accesses may
occur out of order with shared device accesses or memory accesses.

So, if both device A and device B are mapped as shared devices, then
accesses to both occur in program order.

If device A is mapped as a shared device and device B as an unshared
device, then you have to use read backs and possibly barriers to
ensure ordering.  Remember, a barrier only affects up to the CPU.
It doesn't affect write posting downstream of the CPU.
