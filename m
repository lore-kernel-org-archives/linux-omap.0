From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: clocks: Delay clk inits atleast until slab
 is initialized
Date: Tue, 19 Mar 2013 11:04:52 -0700
Message-ID: <20130319180452.GC16413@atomide.com>
References: <1363689525-14584-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:44351 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933258Ab3CSSE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 14:04:58 -0400
Content-Disposition: inline
In-Reply-To: <1363689525-14584-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, phaber@broadcom.com, mturquette@linaro.org, santosh.shilimkar@ti.com

* Rajendra Nayak <rnayak@ti.com> [130319 03:43]:
> clk inits on OMAP happen quite early, even before slab is available.
> The dependency comes from the fact that the timer init code starts to
> use clocks and hwmod and we need clocks to be initialized by then.
> 
> There are various problems doing clk inits this early, one is,
> not being able to do dynamic clk registrations and hence the
> dependency on clk-private.h. The other is, inability to debug
> early kernel crashes without enabling DEBUG_LL and earlyprintk.
> 
> Doing early clk init also exposed another instance of a kernel
> panic due to a BUG() when CONFIG_DEBUG_SLAB is enabled.
> More details on the issue reported can be found here,
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85932.html

I suggest you paste the BUG info here to the commit too so it's clear
that this needs to go in as a fix. Also can you please describe how
this regression got introduced?

Other than that looks good to me as a fix for the -rc cycle. We could
add a struct for similar function pointers and SoC specific addresses,
but probably for the -rc cycle we should just keep this patch to the
minimum.

Regards,

Tony
