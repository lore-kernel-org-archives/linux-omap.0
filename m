From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Sun, 23 Jan 2011 17:48:14 +0000
Message-ID: <20110123174814.GI30094@n2100.arm.linux.org.uk>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60614 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab1AWRsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Jan 2011 12:48:23 -0500
Content-Disposition: inline
In-Reply-To: <20110123171344.GH30094@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sun, Jan 23, 2011 at 05:13:44PM +0000, Russell King - ARM Linux wrote:
> Move non-mapping and non-irq initialization code out of .map_io and
> .init_irq respectively into the new init_early hook.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> I think I've updated this patch correctly for the new platforms merged
> into mainline.

Grr, this breaks on OMAP because some of this stuff wants to do ioremap()
and therefore wants the kmem allocators initialized.  That's rather
annoying...
