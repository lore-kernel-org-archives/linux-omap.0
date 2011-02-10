From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 2/4] TI816X: Update common OMAP machine specific
 sources
Date: Thu, 10 Feb 2011 09:02:02 -0800
Message-ID: <20110210170202.GK20795@atomide.com>
References: <1297270570-32492-1-git-send-email-hemantp@ti.com>
 <20110210014557.GG20795@atomide.com>
 <20110210014826.GH20795@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036ACA3CB4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51050 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529Ab1BJRCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 12:02:40 -0500
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036ACA3CB4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

* Pedanekar, Hemant <hemantp@ti.com> [110209 20:42]:
> Tony Lindgren wrote on Thursday, February 10, 2011 7:18 AM:
> 
> > * Tony Lindgren <tony@atomide.com> [110209 17:45]:
> >> 
> >> We should just have separate struct map_desc omapti816x_io_desc[] then.
> >> Maybe have a common struct map_desc omap3_io_desc[] and then separate
> >> omap3xxx_io_desc and omapti816x_io_desc?
> > 
> > Oh and this will work just fine for map_io without having cpu_is_omap
> > macros working yet because we call set_globals from the board
> > file with
> > the processor class data.
> > 
> > Tony
> 
> So probably I need to create another function (ti816x_map_common_io()) to
> map just the L4 slow region and call it from board file (after set globals)
> as distinguishing between OMAP3xxx and TI816X is not possible at that time
> inside omap34xx_map_common_io() as they both have same class.
> 
> Does this approach look ok?

Yes that's the way to go if the io regions are different.

Regards,

Tony
