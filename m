From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 1/1] OMAP: DSS2: RFBI driver update
Date: Tue, 13 Oct 2009 10:56:14 +0300
Message-ID: <1255420574.27268.11.camel@tubuntu>
References: <1255122529-1721-1-git-send-email-mlc@ti.com>
	 <1255335927.4624.26.camel@tubuntu>
	 <E49DAF743FB3E9469ED423C0D3DB5F1CCEF3F692@dnce01.ent.ti.com>
	 <1255357047.27268.4.camel@tubuntu>
	 <E49DAF743FB3E9469ED423C0D3DB5F1CCEF3F75A@dnce01.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35228 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbZJMH6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 03:58:07 -0400
In-Reply-To: <E49DAF743FB3E9469ED423C0D3DB5F1CCEF3F75A@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Christensen, Mikkel" <mlc@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2009-10-12 at 17:25 +0200, ext Christensen, Mikkel wrote:
> On Mon, Oct 12, 2009 at 09:17:27, Tomi Valkeinen wrote:
> > Subject: RE: [PATCH 1/1] OMAP: DSS2: RFBI driver update
> > 
> > On Mon, 2009-10-12 at 16:03 +0200, ext Christensen, Mikkel wrote:
> > > On Mon, Oct 12, 2009 at 03:25:27, Tomi Valkeinen wrote:
> > > > Subject: Re: [PATCH 1/1] OMAP: DSS2: RFBI driver update
> > > > 
> > > > On Fri, 2009-10-09 at 23:08 +0200, ext Mikkel Christensen wrote:
> > > > > This patch adds suspend / resume functionality to the RFBI
> > > > driver along with missing callback functions needed by OMAP Frame 
> > > > buffer.
> > > > > 
> > > > > Signed-off-by: Mikkel Christensen <mlc@ti.com>
> > > > > ---
> > > > >  drivers/video/omap2/dss/rfbi.c |   76 
> > > > ++++++++++++++++++++++++++++++++++++++++
> > > > >  1 files changed, 76 insertions(+), 0 deletions(-)
> > > > > 
> > 
> > snip
> > 
> > > > > +static int rfbi_display_suspend(struct omap_dss_device
> > *dssdev) {
> > > > > +	unsigned long l;
> > > > > +
> > > > > +	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	DSSDBG("rfbi_display_suspend\n");
> > > > > +
> > > > > +	if (dssdev->driver->suspend)
> > > > > +		dssdev->driver->suspend(dssdev);
> > > > > +
> > > > > +	dispc_enable_lcd_out(0);
> > > > 
> > > > I don't think this is needed. DSS hardware disables
> > lcd_out when the
> > > > transfer has finished. Although for correct operation suspend() 
> > > > should wait until the last transfer has been done before
> > disabling
> > > > clocks, which is something it currently doesn't.
> > > 
> > > This was done with reference to the DPI and SDI files that
> > do the same thing. It can be removed if not necessary.  
> > 
> > DPI and SDI work quite differently than RFBI, you can't just copy 
> > their functionality =).
> > 
> > It is more correct without disable/enable_lcd_out, but it's not 
> > correct as there may be a transfer ongoing when suspend call comes. 
> > That's why there should be some mechanism to wait until the transfer 
> > has been done.
> > DSI tries to do this (and hopefully correctly does =).
> 
> OK. Thanks I will try to incorporate this. Where in the DSI driver is this mechanism implemented?

It's the dsi_bus_lock mechanism. But it doesn't work as such for RFBI,
because the DSI uses a bit different mechanism for updates. But somehow
the suspend function needs to wait until the transfer has been
completed, and suspend only after that (and also make sure that no new
transfer starts before the suspend).

 Tomi


