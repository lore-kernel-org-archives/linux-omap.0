From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH 01/13] OMAP: DSS2: enable VDDS_DSI when using DPI
Date: Mon, 15 Feb 2010 14:32:07 +0200
Message-ID: <1266237127.2433.366.camel@tubuntu.research.nokia.com>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044A96DE7B@dbde02.ent.ti.com>
	 <1266231454.2433.357.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044A96DF16@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30805 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab0BOM3X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 07:29:23 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A96DF16@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Mon, 2010-02-15 at 13:11 +0100, ext Hiremath, Vaibhav wrote:
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > Sent: Monday, February 15, 2010 4:28 PM
> > To: Hiremath, Vaibhav
> > Cc: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org
> > Subject: RE: [PATCH 01/13] OMAP: DSS2: enable VDDS_DSI when using
> > DPI
> > 
> > On Mon, 2010-02-15 at 11:22 +0100, ext Hiremath, Vaibhav wrote:
> > > > -----Original Message-----
> > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> > > > Sent: Monday, February 08, 2010 9:26 PM
> > > > To: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org
> > > > Cc: Tomi Valkeinen
> > > > Subject: [PATCH 01/13] OMAP: DSS2: enable VDDS_DSI when using
> > DPI
> > > >
> > > > It looks like on OMAP3 some DSS pins need VDDS_DSI to function
> > > > properly.
> > > >
> > > > This has not been confirmed from TI, but looking at figure 15-1
> > > > "Display
> > > > subsystem highlight" from the TRM, some data pins come near the
> > DSI
> > > > and SDI
> > > > blocks. This is not very hard evidence, but the fact remains
> > that
> > > > with the
> > > > power on, pixels are ok, and with the power off, pixels are not
> > ok.
> > > >
> > > [Hiremath, Vaibhav] Tomi, sorry for delayed response. As usual
> > stuck with some other issues. Below are some quick comments -
> > >
> > > I am not regulator expert, but as per my finding I believe it is
> > nothing to do with pins position closure to each other. The actual
> > root cause is TWL4030 Ownership bit. Please refer to the below mail-
> > chain -
> > >
> > > http://marc.info/?l=linux-omap&m=126045146600334&w=2
> > 
> > But why is there a dependency on a regulator, if it has nothing to
> > do
> > with the pins? Why is vdds_dsi/vdds_sdi needed to get all pixels
> > through?
> [Hiremath, Vaibhav] I am not sure, what role ownership bit is playing here.

But it doesn't matter. If DSS does not need any regulators, it shouldn't
matter how the TWL is configured. And if it does, and TWL config
matters, then why does DSS need the regulators?

 Tomi


