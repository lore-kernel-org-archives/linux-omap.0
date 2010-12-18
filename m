From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] OMAP4: Pandaboard: Add omap_reserve functionality
Date: Sat, 18 Dec 2010 09:20:56 -0800
Message-ID: <20101218172055.GT5941@atomide.com>
References: <20101218030406.10251.73118.stgit@baageli.muru.com>
 <20101218030521.10251.89993.stgit@baageli.muru.com>
 <20101218082703.GB3047@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16510 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977Ab0LRRVK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 12:21:10 -0500
Content-Disposition: inline
In-Reply-To: <20101218082703.GB3047@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Raghuveer Murthy <raghuveer.murthy@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101218 00:26]:
> On Fri, Dec 17, 2010 at 07:05:21PM -0800, Tony Lindgren wrote:
> >  	/* Maintainer: David Anders - Texas Instruments Inc */
> >  	.boot_params	= 0x80000100,
> >  	.map_io		= omap4_panda_map_io,
> > +	.reserve	= omap_reserve,
> 
> Please put .reserve before .map_io.

Hmm, that's the way it should be.. But we should also correct the
earlier changes too?

See 98c672cf1fa2a56f6f43e3f48b1208b83845582c (ARM: Move platform memory
reservations out of generic code) and 71ee7dad9b69917079f24d42aff796bad7932914
(ARM: OMAP: Convert to use ->reserve method to reserve boot time memory).

In these patches .reserve is also after .map_io which is
probably not intentional?

Regards,

Tony
