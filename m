From: "Taneja, Archit" <archit@ti.com>
Subject: RE: [PATCH v2] OMAP: DSS2: Fix error path in omap_dsi_update()
Date: Tue, 27 Jul 2010 13:04:28 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305FAB51E@dbde02.ent.ti.com>
References: <1279109510-12992-1-git-send-email-archit@ti.com>
 <1280215188.2427.34.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37764 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425Ab0G0Hef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 03:34:35 -0400
In-Reply-To: <1280215188.2427.34.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] 
> Sent: Tuesday, July 27, 2010 12:50 PM
> To: Taneja, Archit
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v2] OMAP: DSS2: Fix error path in 
> omap_dsi_update()
> 
> On Wed, 2010-07-14 at 14:11 +0200, ext Archit Taneja wrote:
> > In the case of an error on calling dsi_update_screen_l4(), a 
> > successful framedone callback is still sent to panel-taal. An error 
> > should be returned to taal_update() instead.
> > 
> 
> Looks ok to me, I'll add it to my tree. Are you actually 
> using dsi_update_screen_l4?
> 
>  Tomi

There is a usecase in OMAP4 where we can run 4 displays in
parallel, 3 can be run using the 3 dispc channels, and another DSI
panel can be run using L4 updates.

It would probably be better if we can connect 2 or more peripherals to
one DSI PHY, but with l4 updates we don't need to introduce any hardware changes
on the boards.

So with l4 update we can free one dispc channel. I am not sure how much the
4 display usecase is going to be used. But having l4 updates is still a handy feature,
especially if one wants to run both a DPI and a DSI display on OMAP3 :)

Archit