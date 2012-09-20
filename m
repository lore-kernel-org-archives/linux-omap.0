From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [RFC PATCH v2 2/5] ARM: mm: rename jump labels in
 v7_flush_dcache_all function
Date: Thu, 20 Sep 2012 12:01:19 +0100
Message-ID: <20120920110119.GA2117@linaro.org>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1347986135-17979-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20120919135155.GB2111@linaro.org>
 <20120920103212.GE4588@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38369 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2ITLBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 07:01:30 -0400
Received: by eaac11 with SMTP id c11so644025eaa.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 04:01:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120920103212.GE4588@e102568-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nicolas.pitre@linaro.org>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Thu, Sep 20, 2012 at 11:32:12AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 19, 2012 at 02:51:56PM +0100, Dave Martin wrote:
> > On Tue, Sep 18, 2012 at 05:35:32PM +0100, Lorenzo Pieralisi wrote:
> > > This patch renames jump labels in v7_flush_dcache_all in order to define
> > > a specific flush cache levels entry point.
> > > 
> > > TODO: factor out the level flushing loop if considered worthwhile and
> > >       define the input registers requirements.
> > 
> > In the context of this series, this patch seems to do nothing at all (?)
> 
> Agreed, it is just replacing some labels. I thought that something like:
> 
> b flush_levels
> 
> is clearer than:
> 
> b loop1
> 
> If I manage to factor out the cache level flushing loop I think things
> are even better, I just did not want to change v7_flush_dcache_all, I would
> avoid doing that, unless, as I mentioned, it is considered worthwhile.
> 
> > Maybe it would make sense to defer this patch until you post something
> > that uses it.
> 
> v7_flush_dcache_louis uses it, I have no problem in deferring it though.

I don't think it's necessary to defer it -- I just wanted to understand
whether there was some context here I wasn't aware of.

Cheers
---Dave
