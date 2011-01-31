From: Paul Walmsley <paul@pwsan.com>
Subject: Re: handling clock nodes with both parent and divider selection
Date: Mon, 31 Jan 2011 16:12:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101311610060.16671@utopia.booyaka.com>
References: <045d24bba9bbbe9fa47f0f8aa9901b7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49492 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779Ab1AaXM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 18:12:59 -0500
In-Reply-To: <045d24bba9bbbe9fa47f0f8aa9901b7e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 31 Jan 2011, Rajendra Nayak wrote:

> Hi Paul,
> 
> On OMAP4, some aux clk nodes (part of SCRM) have control
> for both parent and divider selection. Is there a way in the
> current clock framework for OMAP's to handle this?

For these clocks on OMAP3, we split the clock into two struct clks.  For 
example, clkout2_src_ck handles source selection, and sys_clkout2 handles 
rate selection.  clock3xxx_data.c has the details.

At some point in the future, hopefully we'll be able to split all of the 
multiplexers and dividers into their own struct clks, or struct omap_clks, 
or something, so we don't have to implement these hacks.  As I understand 
it, that would be closer to the actual hardware, anyway.  The right time 
to do that would be after the clktype conversion...


- Paul
