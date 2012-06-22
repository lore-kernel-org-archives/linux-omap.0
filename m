From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 07/11] w1: omap_hdq: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 12:35:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206221234500.10198@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-8-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44723 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab2FVSfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 14:35:07 -0400
In-Reply-To: <1340372890-10091-8-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Evgeniy Polyakov <zbr@ioremap.net>

On Fri, 22 Jun 2012, Rajendra Nayak wrote:

> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> and clk_unprepare() for the hdq clocks.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Evgeniy Polyakov <zbr@ioremap.net>

This one should not be needed soon:

http://marc.info/?l=linux-omap&m=134037453807275&w=2

- Paul
