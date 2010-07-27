From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v2] OMAP: DSS2: Fix error path in omap_dsi_update()
Date: Tue, 27 Jul 2010 13:53:22 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305FAB574@dbde02.ent.ti.com>
References: <1279109510-12992-1-git-send-email-archit@ti.com>
	 <1280215188.2427.34.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870305FAB51E@dbde02.ent.ti.com>
 <1280216637.2427.50.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40810 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab0G0IX2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 04:23:28 -0400
In-Reply-To: <1280216637.2427.50.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] 
> Sent: Tuesday, July 27, 2010 1:14 PM
> To: Taneja, Archit
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH v2] OMAP: DSS2: Fix error path in 
> omap_dsi_update()
> 
> On Tue, 2010-07-27 at 09:34 +0200, ext Taneja, Archit wrote:
> > >
> > > Looks ok to me, I'll add it to my tree. Are you actually using 
> > > dsi_update_screen_l4?
> > > 
> > >  Tomi
> > 
> > There is a usecase in OMAP4 where we can run 4 displays in 
> parallel, 3 
> > can be run using the 3 dispc channels, and another DSI panel can be 
> > run using L4 updates.
> 
> Ok.
> 
> > It would probably be better if we can connect 2 or more 
> peripherals to 
> > one DSI PHY, but with l4 updates we don't need to introduce any 
> > hardware changes on the boards.
> > 
> > So with l4 update we can free one dispc channel. I am not sure how 
> > much the
> > 4 display usecase is going to be used. But having l4 
> updates is still 
> > a handy feature,
> 
> The current implementation of dsi_update_screen_l4() is very 
> bad performance-wise, for throughput and for being basically 
> a busy loop.
> 
> Much better would be to use system DMA for the transfer. In 
> theory this is possible, and I've made some tests with it, 
> but I wasn't able to solve the problems how to inject DSI 
> commands (write_memory_start and write_memory_continue), and 
> how to get unpacked 24bit pixels from the memory changed into 
> packed 24bit pixels for the DSI transfer.

I can try to look up more into this, I have no idea about it's
improvement in terms of performance numbers, but preventing the cpu
load makes it worth it.

Archit