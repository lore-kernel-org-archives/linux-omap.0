From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
	read/write
Date: Thu, 7 Oct 2010 19:56:30 +0100
Message-ID: <20101007185630.GA26435@n2100.arm.linux.org.uk>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com> <1285063280-4057-10-git-send-email-manjugk@ti.com> <7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42611 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab0JGS4q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 14:56:46 -0400
Content-Disposition: inline
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 07, 2010 at 07:17:08AM -0500, Menon, Nishanth wrote:
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of G, Manjunath Kondaiah
> > Sent: Tuesday, September 21, 2010 5:01 AM
> > To: linux-omap@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org; linux-mtd@lists.infradead.org
> > Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
> > read/write
> > 
> > Following sparse warnings exists due to use of writel/w and readl/w
> > functions.
> > 
> > This patch fixes the sparse warnings by converting readl/w functions usage
> > into
> > __raw_readl/__raw_readw functions.
> 
> Apologies on bringing up an old topic here -> Is'nt it better to fix
> readl/w or writel/w than replacing it with __raw_readl/w etc?

No.  If you're getting sparse warnings its because _you_ are using
readl/writel wrongly.

They take a void __iomem pointer, not a u32, unsigned long, int, or
even a void pointer.
