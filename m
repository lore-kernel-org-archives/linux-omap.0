From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/11] crypto: omap: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 12:58:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206221257480.10198@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-9-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40240 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920Ab2FVS6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 14:58:22 -0400
In-Reply-To: <1340372890-10091-9-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Herbert Xu <herbert@gondor.hengli.com.au>

Hi

On Fri, 22 Jun 2012, Rajendra Nayak wrote:

> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> and clk_unprepare() for the omap crypto clocks.

These drivers should be converted to use runtime PM instead, since that 
needs to be done anyway.


- Paul
