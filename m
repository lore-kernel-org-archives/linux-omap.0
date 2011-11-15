From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Help with clk API
Date: Tue, 15 Nov 2011 06:45:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1111150610330.19654@utopia.booyaka.com>
References: <20111111113159.GK19090@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59398 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459Ab1KONpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Nov 2011 08:45:18 -0500
In-Reply-To: <20111111113159.GK19090@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, r-woodruff@ti.com, mturquette@ti.com

Hi Felipe

On Fri, 11 Nov 2011, Felipe Balbi wrote:

> I have a doubt about using clk API to change CLKSEL_UTMI_P1 bit for a
> silicon errata (OMAP4460 i693) implementation.
> 
> According to errata, I need to switch from external to internal clock
> during USB port suspend, wait 1ms and switch back from internal to
> external.
> 
> How can I do that with clk API ? Is it by changing clk parent ? Any tips
> would be helpful ;-) thanks

clk_set_parent() is the way to go.  There are 44xx struct clks that 
references CLKSEL_UTMI_P1 and CLKSEL_UTMI_P2: see utmi_p1_gfclk and 
utmi_p2_gfclk in mach-omap2/clock44xx_data.c.  The possible parent clocks 
are listed in utmi_p1_gfclk_sel and utmi_p2_gfclk_sel in the same file.

So you should be able to clk_get() the possible parent clocks and 
utmi_p1_gfclk during module init, then use clk_set_parent() to switch 
between them.  For example, for port 1:

new_parent = clk_set_parent(utmi_p1_clk, init_60m_clk);
/* test new_parent for error */
/* delay 1ms */
new_parent = clk_set_parent(utmi_p1_clk, xclk60mhsp1_ck);

or something similar.

Please let me know if something like the above turns out not to work for 
you.

One comment.  Erratum i693 in SWPZ017A Public is not 100% explicit on 
whether the new parent clock needs to be enabled before the 
clk_set_parent() executes.  It seems to imply that it does need to be 
enabled first.  If so, this is contrary to what we previously believed was 
a safe sequence based on Richard Woodruff's post here:

http://lkml.org/lkml/2009/2/19/416

The concern is that the parent-switching process may not be glitch-free.  
Of course, if it isn't, we're in trouble, because we may not be able to 
shut off a clock like init_60m_clk if the other port is using it.  
Perhaps it would be enough to gate the downstream clock node (e.g. 
usb_host_hs_utmi_p1_clk).  We'll need to get some clarification on this. 


- Paul
