From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 08/12] DSS: support for Beagle Board
Date: Tue, 13 Jan 2009 13:37:46 +0200
Message-ID: <1231846666.900.52.camel@tubuntu>
References: <20090112114718.1003.23643.stgit@tubuntu>
	 <20090112114811.1003.38871.stgit@tubuntu>
	 <200901130314.03906.david-b@pacbell.net>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32729 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbZAMLnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 06:43:18 -0500
In-Reply-To: <200901130314.03906.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Tue, 2009-01-13 at 03:14 -0800, ext David Brownell wrote:
> On Monday 12 January 2009, Tomi Valkeinen wrote:
> >  arch/arm/configs/dss_omap3_beagle_defconfig | 1437 +++++++++++++++++++++++++++
> 
> This is a complete replacement.  The patch would be a lot
> more comprehensible if changed the standard config to just
> add support for this board's video options (DVI and S-Video).

The dss_* defconfigs were actually just for my own use. I seem to have
forgotten them there. Well, they can serve as examples though.

> 
> Also it'd be good to have a brief textual summary of what
> each board's default video config is; maybe one of those
> little multicolumn charts as in your first patch, with a
> one sentence summary.  (In the board-*.c file.)

Well, perhaps. But on the other hand, there are no descriptions of other
hardware components either. But I agree that, at least for the time
being, we could have description of the boards display interfaces to
make validation and review easier.

> Note that after this merges, some work will be needed to
> make the regulator framework handle the power switching.
> Such logic should move out of board files (except for
> setting up "S-Video is supplied using the twl VDAC").
> It's not quite time for that yet; heads-up, that's all.
> 
> - Dave
> 

 Tomi


