From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/6] ARM: pm: convert samsung platforms to generic
	suspend/resume support
Date: Thu, 17 Feb 2011 23:29:47 +0000
Message-ID: <20110217232947.GA4110@n2100.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk> <E1Pnvhv-0002yp-A0@rmk-PC.arm.linux.org.uk> <017901cbce9b$7b405ee0$71c11ca0$%kim@samsung.com> <20110217140621.GC24989@n2100.arm.linux.org.uk> <01b001cbcef7$3e7f5f90$bb7e1eb0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52172 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab1BQXaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 18:30:07 -0500
Content-Disposition: inline
In-Reply-To: <01b001cbcef7$3e7f5f90$bb7e1eb0$%kim@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Eric Miao' <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Feb 18, 2011 at 08:05:57AM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > 
> > On Thu, Feb 17, 2011 at 09:09:02PM +0900, Kukjin Kim wrote:
> > > Hi Russell,
> > >
> > > I tested on SMDKV210(S5PV210) and SMDKC110(S5PC110).
> > 
> > Thanks for testing.  It looks like I'm missing a load for r3 in the
> > s5pv210 code.  The replacement patch below should resolve this.
> > 
> 
> Hooray, it works fine ;)
> 
> Tested-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.  I'm assuming that applies to:

"ARM: pm: add generic CPU suspend/resume support"

too as you can't test this without that patch.
