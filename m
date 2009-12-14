From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Enabling 3530 sys_clkout2
Date: Mon, 14 Dec 2009 14:59:43 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912141457110.12561@utopia.booyaka.com>
References: <e0727e900912141230q1e98d4c3ge408101664a0c712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60868 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758495AbZLNV7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 16:59:44 -0500
In-Reply-To: <e0727e900912141230q1e98d4c3ge408101664a0c712@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Faith <jfaith7@gmail.com>
Cc: linux-omap@vger.kernel.org

Hello John,

On Mon, 14 Dec 2009, John Faith wrote:

> I'm trying to enable the sys_clkout2 pin in a 2.6.29 kernel for my
> 3530EVM-like board for the main clock line of an FPGA.  I've added a
> MUX_CFG_34XX entry in mux.c, set the gpio direction in my board.c
> file, and set the rate in my driver with clk_set_parent(),
> clk_set_rate() but I do not see any output clock when probed with a
> scope.

Sounds like either the clock is not enabled (use clk_enable() for this), 
or there is a mux problem.

You might also want to make sure that you've set the parent of 
clkout2_src_ck appropriately, although you still should be able to get 
something out of it.


- Paul
