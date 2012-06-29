From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/3] ARM: omap: hwmod: get rid of all omap_clk_get_by_name
 usage
Date: Fri, 29 Jun 2012 14:22:01 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206291420480.2338@utopia.booyaka.com>
References: <1340786915-29507-1-git-send-email-rnayak@ti.com> <1340786915-29507-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54877 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268Ab2F2UWC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 16:22:02 -0400
In-Reply-To: <1340786915-29507-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi

On Wed, 27 Jun 2012, Rajendra Nayak wrote:

> Moving to Common clk framework for OMAP would mean we no longer use
> internal lookup mechanism like omap_clk_get_by_name().
> get rid of all its usage mostly from hwmod and omap_device
> code.
> 
> Also use IS_ERR_OR_NULL() for error checking.
> 
> Moving to clk_get() also means the respective platforms
> need the clkdev tables updated with an entry for all clocks
> used by hwmod to have clock name same as the alias.
> 
> Based on original changes from Mike Turquette.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

As originally misattributed to patch 1, this patch generates checkpatch 
warnings:

http://marc.info/?l=linux-omap&m=134100139702775&w=2

Please fix.


- Paul
