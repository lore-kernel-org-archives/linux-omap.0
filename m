From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 04/13] OMAP2/3 clock: ensure each clock has a unique
 name
Date: Mon, 17 Aug 2009 03:14:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908170259250.18309@utopia.booyaka.com>
References: <20090815111704.7384.31564.stgit@localhost.localdomain> <20090815111944.7384.13541.stgit@localhost.localdomain> <20090817084704.GN7278@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35106 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554AbZHQJOp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 05:14:45 -0400
In-Reply-To: <20090817084704.GN7278@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org

Hi Tony,

On Mon, 17 Aug 2009, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [090815 14:26]:
> > After the clkdev conversion, struct clk .name fields are free to be
> > unique and to reflect the underlying hardware naming convention.  This
> > is important since it is useful for some core code that is unrelated
> > to the platform_device subsystem, such as the clock debugfs code and
> > the omap_hwmod code, to be able to address clocks by a single unique
> > identifier, since platform drivers are only weakly bound to clocks.
> > So, update all of the non-unique clock names in OMAP2/3 to be unique
> > names.  In the future it might be ideal to ensure that the names match
> > the hardware information exactly, for ease of debugging and reference.
> 
> Giving up on the name + id combination is against what we've tried to
> do with the clock framework in general.

This already happened with the clkdev conversion a few months ago.  At 
that point, device drivers address clocks with a clock alias string, e.g., 
"fck", plus a struct device pointer.  This patch doesn't change that.  

What it does remove is the need for internal core code to fake up a struct 
device simply to access a clock.  It also allows us to harmonize the 
clock names, used internally in core code, with the hardware reality, 
which uses unique names to identify clocks.


- Paul
