From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: Added recalculation of clock rate in
 'clk_set_rate'
Date: Sat, 23 Apr 2011 11:00:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104231059050.6742@utopia.booyaka.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com> <alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com> <BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56250 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1DWRAW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Apr 2011 13:00:22 -0400
In-Reply-To: <BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Thu, 21 Apr 2011, Gulati, Shweta wrote:

> Yes, but in current code clk_set_rate of dpll3_m2 - 
> 'omap3_core_dpll_m2_set_rate' doesn't update clk.rate, I will submit 
> patch fixing that bug and will make sure that set_rate of all clocks 
> should update clk.rate

Yes, that's the right thing to do, please send that.  Such a patch was 
originally part of the series for the last merge window; it seems I 
inadvertently dropped it.


- Paul
