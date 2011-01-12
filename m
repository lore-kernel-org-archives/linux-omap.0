From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: OMAP DSS Enable clocks in dss_setup_partial_planes
Date: Wed, 12 Jan 2011 15:10:56 +0200
Message-ID: <1294837856.15030.33.camel@tubuntu>
References: b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com <fd876042b2837b7dd3eaea2257dcbd6f@mail.gmail.com>
	 <1294413238.3968.110.camel@nubuntu>
	 <78677181845a6577fe0955a1984ac16a@mail.gmail.com>
	 <c08bf1989fbe2e704960116748c416f3@mail.gmail.com>
	 <1294823658.4156.18.camel@tubuntu>
	 <93718b46f4f9309fb4b87599040a432f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:17312 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125Ab1ALNK7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jan 2011 08:10:59 -0500
In-Reply-To: <93718b46f4f9309fb4b87599040a432f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ben Tucker <btucker@mpcdata.com>
Cc: linux-omap@vger.kernel.org

On Wed, 2011-01-12 at 11:20 +0000, ext Ben Tucker wrote:
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: 12 January 2011 09:14
> > To: ext Ben Tucker
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: OMAP DSS Enable clocks in dss_setup_partial_planes
> >
> > Hi,
> >
> > On Tue, 2011-01-11 at 17:41 +0000, ext Ben Tucker wrote:
> > > From 086e3454c8f154cd90a4669899f2179f16ef32cd Mon Sep 17 00:00:00
> > 2001
> > > From: Ben Tucker <btucker@mpc-data.co.uk>
> > > Date: Thu, 13 Jan 2011 12:56:45 +0000
> > > Subject: [PATCH] OMAP DSS Enable clocks in dss_setup_partial_planes
> > >  Enable the interface clocks while calling>
> > >  >  configure_dispc().
> >
> > This description doesn't really tell anything which isn't selfevident
> > from the code below. Please check
> > http://who-t.blogspot.com/2009/12/on-commit-messages.html
> >
> > But I presume this is about RFBI. If so, correct place to enable the
> > clocks would be in rfbi.c.
> >
> >  Tomi
> >
> 
> Apologies for the commit message. Updated patch below.
> 
> Are you sure the code to enable clocks should be placed in rfbi.c? The DSI
> code (dsi.c) uses dss_setup_partial_planes() in the same way as rfbi.c and
> there is no clock enable code there. Also omap_dss_mgr_apply() within
> manager.c enables clocks for the configure_dispc() call.

Usually the user should enable the clocks, in this case rfbi.c. DSI
handles this so that the clocks are always enabled when the display is
enabled. This could be easier for RFBI also, but due to legacy reasons
RFBI currently tries to keep clocks disabled except when its actually
doing something.

As for omap_dss_mgr_apply(), that function is also a "user" in this
case. Apply is called from outside DSS driver, usually from omapfb.

If the clk_enable/disable calls would be in the lower levels, this would
mean a) greater overhead from clk_enable/disable calls and b) context
saves and restores, as the DSS HW could go into OFF mode when the clocks
are disabled.

 Tomi


