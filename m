From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] HDQ Driver for OMAP2430/3430
Date: Tue, 14 Oct 2008 07:30:58 -0700
Message-ID: <20081014073058.e5d972e6.akpm@linux-foundation.org>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D6107AF0@dbde02.ent.ti.com>
	<20081010133845.8b82fac3.akpm@linux-foundation.org>
	<062801c92d37$3413bdd0$LocalHost@wipultra1303>
	<20081013085323.f8bd7efb.akpm@linux-foundation.org>
	<015c01c92dda$1b754340$LocalHost@wipultra1303>
	<20081014055002.24ff586a.akpm@linux-foundation.org>
	<20081014134249.GA5611@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55317 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750883AbYJNOeY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 10:34:24 -0400
In-Reply-To: <20081014134249.GA5611@2ka.mipt.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: madhu.cr@ti.com, gadiyar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

> On Tue, 14 Oct 2008 17:42:49 +0400 Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> Hi.
> 
> On Tue, Oct 14, 2008 at 05:50:02AM -0700, Andrew Morton (akpm@linux-foundation.org) wrote:
> > I think it's reasonable to permit the driver's operations to be interrupted
> > in this manner.  It's done in quite a few other places.  But the problem is
> > actually *testing* it.
> 
> Why not just skipping the waiting and returning error pretending user
> really sent a signal?

Better than nothing, but because signal_pending() isn't actually true,
upper layers wil behave differently.

