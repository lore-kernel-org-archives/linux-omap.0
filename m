From: Tony Lindgren <tony@atomide.com>
Subject: Re: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for
 3630
Date: Mon, 7 Jun 2010 13:06:57 +0300
Message-ID: <20100607100656.GE15515@atomide.com>
References: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
 <871vcmq08s.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64496 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab0FGKGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 06:06:55 -0400
Content-Disposition: inline
In-Reply-To: <871vcmq08s.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [100604 18:30]:
> 
> > +	w &= ~0x7;
> > +	w |= OMAP_MUX_MODE2;
> > +	omap_ctrl_writew(w, uart->padconf);

Generic NAK for tinkering with the mux registers directly. 

Instead, Govindraj, please add omap_mux_request_signal() into mux.c:

void __iomem * __init omap_mux_request_signal(char *muxname);

Which returns the address of the mux register in question based
on the signal name. Then in the platform init code you can request
the pins for all the UARTs in use, and provide functions to remux
them as needed for the idle modes.

This will work for omap2 also at some point once it's converted to
use the common mux framework. And it will work in a generic way
for all omaps under mach-omap2 eventually.

You can take a look at the omap_mux_get_gpio() in mux.c for a
similar example.

Regards,

Tony
