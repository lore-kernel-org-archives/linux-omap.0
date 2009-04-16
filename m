From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Fwd: dss2 with dsi
Date: Thu, 16 Apr 2009 12:58:56 +0300
Message-ID: <1239875936.6696.125.camel@tubuntu>
References: <aed62de90904151916h5a218e9bgf3419ea96c3ed262@mail.gmail.com>
	 <aed62de90904151917l21419edo12df2dc3ad5c707c@mail.gmail.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51907 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbZDPJ71 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Apr 2009 05:59:27 -0400
In-Reply-To: <aed62de90904151917l21419edo12df2dc3ad5c707c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rebecca Schultz Zavin <rebecca@android.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Please send DSS2 issues directly to me (cc l-o if you want to). I may
miss them otherwise.

On Thu, 2009-04-16 at 04:17 +0200, ext Rebecca Schultz Zavin wrote:
> I'm using dss2 on a dsi panel and I've run into a few limitations in
> the present implementation.  I'd like to post the fixes, but I'd
> appreciate some guidance, especially since I'm working without the
> mipi spec so it isn't always clear to me what's a function of the
> implementation vs. the spec.

The DSI implementation is generally quite limited currently. I have only
one DSI display configuration to test it with, so I opted to leave out
the complexity of full VC control for now. There has been enough
problems just to get it working properly with one DSI peripheral =).

> 1- I think the destination vc set in dsi.vc[n].dest_per should be
> specifiable from either the dsi controller or the board file?  Any
> preference on which?  Could be added to omap_ctrl or to
> omap_dss_display_type.

I believe it should be in the board file. As I said I have only one DSI
display with hardcoded vc-id, but I imagine it would be possible to have
DSI peripherals that can respond to a configurable vc-id. Thus board
file would be the only place where they can be spesified.

> 
> 2- The code hard codes vc0 for L4 and v1 for dispc.  My controller
> exepects the reverse.  Again I think this should come from some struct
> in either the controller or the board file.  Preferences?

The OMAP DSI virtual channel implementation is a bit confusing at first.
The VC register sets do not say where the packets go. So if you send
data with VC0, it doesn't mean that the packets go to the peripheral
with vc-id 0.

So even if L4 and DISPC code use different VC register sets, they both
go to the same peripheral with id 0. This id is defined in the dest_per
field mentioned above.

I used two separate VCs just to make debugging simpler, as I only need
to configure the VC once and thats it. Otherwise I would need to change
the VC0 back and forth between L4 mode to DISPC mode. I don't see why
this wouldn't work, and my plan is to use just one VC register set for
one peripheral at some point.

> 
> 3- The code hard codes the complexio timing values used for setting
> DSIPHY_CFG0, 1 and 2.  I think these values should be specified in the
> omap_ctrl the way rfbi_timings are.

I don't remember what settings there is but aren't they specified in
MIPI DSI spec? If so, they should be the same for all peripherals. At
least in theory =).

 Tomi


