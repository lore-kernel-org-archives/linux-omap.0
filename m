From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3xxx: clockdomain: fix software supervised
 wakeup/sleep
Date: Mon, 30 Jul 2012 10:29:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207301027310.18037@utopia.booyaka.com>
References: <alpine.DEB.2.00.1207261503290.14468@utopia.booyaka.com> <CACYZBRHmO3a3oBwbFP8GqDQj3xB7nB59TkzxAbFrZ2=h0VX3-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50932 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab2G3Q3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jul 2012 12:29:51 -0400
In-Reply-To: <CACYZBRHmO3a3oBwbFP8GqDQj3xB7nB59TkzxAbFrZ2=h0VX3-g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jon-hunter@ti.com

Hi

On Fri, 27 Jul 2012, Nayak, Rajendra wrote:

> On Fri, Jul 27, 2012 at 2:34 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > Commit 4da71ae6 ("OMAP: clockdomain: Arch specific funcs for
> > clkdm_clk_enable/disable") called the OMAP2xxx-specific functions for
> > clockdomain wakeup and sleep.  This would probably have broken
> > software-supervised clockdomain wakeup and sleep on OMAP3.
> 
> Would something like this be better than duplicating most of
> omap2_clkdm_clk_enable/disable?

Am working towards getting the cpu_is_*() calls out of there in 
preparation for the move to drivers/.  In fact there are some patches here 
that will be posted shortly to get rid of those clkdm_clk_(enable|disable) 
functions completely.


- Paul
