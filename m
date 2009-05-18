From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/6] omap iommu: simple virtual address space management
Date: Mon, 18 May 2009 14:10:39 +0100
Message-ID: <20090518131039.GF3067@n2100.arm.linux.org.uk>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com> <20090505124705.4583.28674.stgit@oreo.research.nokia.com> <20090516092248.GE15328@n2100.arm.linux.org.uk> <20090518.093126.193701587.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41497 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbZERNKu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:10:50 -0400
Content-Disposition: inline
In-Reply-To: <20090518.093126.193701587.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Mon, May 18, 2009 at 09:31:26AM +0300, Hiroshi DOYU wrote:
> Right. In this change for better performance, I have to expose "struct
> mem_type" and "get_mem_type()" a bit more as below. Is this change
> acceptable, or do you have a better idea?

You don't need to expose struct mem_type at all.  You only need to
tell the compiler that it exists and is valid by:

struct mem_type;

Then you can use it in function prototypes without complaint.  I'd also
prefer to hide ioremap_page() and get_mem_type() outside of the normal
Linux headers - maybe in asm/mach/map.h.
