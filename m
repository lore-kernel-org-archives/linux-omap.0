From: David Woodhouse <dwmw2@infradead.org>
Subject: RE: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
 read/write
Date: Mon, 25 Oct 2010 11:11:30 +0100
Message-ID: <1288001490.26820.46.camel@i7.infradead.org>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	 <1285063280-4057-10-git-send-email-manjugk@ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
	 <20101007185630.GA26435@n2100.arm.linux.org.uk>  <4CAE2475.4090607@ti.com>
	 <1287964909.5674.22.camel@macbook.infradead.org>
	 <E0D41E29EB0DAC4E9F3FF173962E9E9402DBDDEFAA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54015 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab0JYKLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 06:11:40 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBDDEFAA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, 2010-10-25 at 11:04 +0530, G, Manjunath Kondaiah wrote:
> David,
> 
> > -----Original Message-----
> > From: David Woodhouse [mailto:dwmw2@infradead.org] 
> > Sent: Monday, October 25, 2010 5:32 AM
> > To: Menon, Nishanth
> > Cc: Russell King - ARM Linux; G, Manjunath Kondaiah; 
> > linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; 
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v2 09/10] OMAP2/3: Convert write/read 
> > functions to raw read/write
> > 
> > On Thu, 2010-10-07 at 14:50 -0500, Nishanth Menon wrote:
> > > my comment being that by moving {read,write}[wlb] to __raw versions 
> > > dont solve the real issue of namespace here. fix should be in 
> > > arch/arm/include/asm/io.h IMHO. so that there are no 
> > overlaps as this.
> > 
> > Indeed. This patch is complete nonsense.
> 
> nonsense? There are two types of fixes proposed to fix these sparse warnings.
> 1. with this patch
> 2. fixing in io.h
> https://patchwork.kernel.org/patch/250171/
> 
> 1st option is already merged with 2.6.37 merge window.
> 
> If 2 get accepted, all __raw_read/write will get replaced with readl/writel.
> 
> Apart from those two, do you have any other alternate idea to fix these sparse warnings?

The latter is obviously the better approach. The problem that sparse is
complaining about is the fact that you have two nested C blocks, both of
which contain a local variable called '__v'. By changing the variable
names so that they're actually unique, we fix the real problem.

The answer is not that *all* drivers which call cpu_to_le16(readw())
must be changed, which is what you seem to have assumed. And you
*certainly* can't change them to use __raw_readw(), which has
*different* semantics (and endianness in some cases), without a clear
comment in the changelog entry saying *why* that change was OK.

-- 
dwmw2

