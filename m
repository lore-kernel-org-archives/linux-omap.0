From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: Added recalculation of clock rate in
 'clk_set_rate'
Date: Fri, 6 May 2011 15:49:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105061549150.30136@utopia.booyaka.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com> <alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com> <BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50516 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab1EFVtf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 17:49:35 -0400
In-Reply-To: <BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Thu, 21 Apr 2011, Gulati, Shweta wrote:

> Yes, but in current code clk_set_rate of dpll3_m2 -
> 'omap3_core_dpll_m2_set_rate'
> doesn't update clk.rate, I will submit patch fixing that bug and will
> make sure that
> set_rate of all clocks should update clk.rate

Ping.  Do you plan to post this soon?  This should be a trivial patch.

- Paul
