From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/10] ARM: OMAP5: clock data: Add OMAP54XX full clock
 tree and headers
Date: Fri, 18 Jan 2013 09:19:13 -0800
Message-ID: <20130118171912.GD15361@atomide.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
 <1358522856-12180-8-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43020 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751541Ab3ARRTQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 12:19:16 -0500
Content-Disposition: inline
In-Reply-To: <1358522856-12180-8-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, rnayak@ti.com, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130118 07:30]:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> Add the clock tree related data for OMAP54xx platforms.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> [santosh.shilimkar@ti.com: Generated es2.0 data]
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> As mentioned in the summary, this patch will be updated once the
> movement of clock data to drivers/clock is clear.

Yes let's first fix up the issues prevent us from moving all the
cclock*_data.c files to live under drivers/clock/omap.

It seems that fixing this issue boils down to rearranging some
clock related headers in arch/arm/mach-omap2, and then populating
some of the clock data dynamically. Or am I missing something?

Regards,

Tony
