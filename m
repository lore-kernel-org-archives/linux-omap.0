From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] arm: omap: select HAVE_SPARSE_IRQ
Date: Tue, 4 Jan 2011 09:55:19 +0000
Message-ID: <20110104095519.GA17374@n2100.arm.linux.org.uk>
References: <1294133966-20279-1-git-send-email-balbi@ti.com> <1294133966-20279-3-git-send-email-balbi@ti.com> <20110104095410.GA17298@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45719 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab1ADJz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 04:55:29 -0500
Content-Disposition: inline
In-Reply-To: <20110104095410.GA17298@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 04, 2011 at 09:54:10AM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 04, 2011 at 11:39:26AM +0200, Felipe Balbi wrote:
> > select HAVE_SPARSE_IRQ and irq_descs can be added
> > to a radix tree instead of an array.
> 
> Please move HAVE_GENERIC_HARDIRQS to the config ARM entry, and remove
> these:
> 
> config GENERIC_HARDIRQS
>         bool
>         default y
> 
> config GENERIC_HARDIRQS_NO__DO_IRQ
>         def_bool y
> 
> as they're in kernel/irq/Kconfig, and are visible if HAVE_GENERIC_HARDIRQS
> is enabled.

Note also that should be a separate patch from adding HAVE_SPARSE_IRQ to
OMAP, as it's an independent but necessary change.
