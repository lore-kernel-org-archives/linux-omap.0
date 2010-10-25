From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
 read/write
Date: Mon, 25 Oct 2010 01:01:49 +0100
Message-ID: <1287964909.5674.22.camel@macbook.infradead.org>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	 <1285063280-4057-10-git-send-email-manjugk@ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
	 <20101007185630.GA26435@n2100.arm.linux.org.uk>  <4CAE2475.4090607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43828 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0JYAB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 24 Oct 2010 20:01:56 -0400
In-Reply-To: <4CAE2475.4090607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 2010-10-07 at 14:50 -0500, Nishanth Menon wrote:
> my comment being that by moving {read,write}[wlb] to __raw versions dont 
> solve the real issue of namespace here. fix should be in 
> arch/arm/include/asm/io.h IMHO. so that there are no overlaps as this. 

Indeed. This patch is complete nonsense.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

