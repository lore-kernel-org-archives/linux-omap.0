From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work
Date: Mon, 25 May 2009 14:21:28 +0100
Message-ID: <20090525142128.17675cl0tvdr0y1k@lidskialf.net>
References: <20090519232905.12760.15490.stgit@localhost>
	<20090519233732.12760.34595.stgit@localhost>
	<20090525092911.GC28195@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:41451 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbZEYNV1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 09:21:27 -0400
In-Reply-To: <20090525092911.GC28195@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Quoting Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Tue, May 19, 2009 at 04:37:32PM -0700, Tony Lindgren wrote:
>> Make 770 LCD work by passing the clock from platform data.
>> Also remove the old unused functions.
>
> I don't like this - because its passing struct clk's through platform
> data.  That's not how things are supposed to work.
>
> The way PXA solves this problem is to have clock aliases - see
> clk_add_alias().

Interesting idea - I now have a prototype patch implementing this,  
which I'll send when I get home (otherwise it would be an "it  
compiles" "test" :)

There isn't a common definition of clk_add_alias() though - that  
symbol is defined in arch/arm/mach-pxa/clock.c, so I had to copy it  
into arch/arm/plat-omap/clock.c


