From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in
 omap3_defconfig
Date: Tue, 04 May 2010 10:26:03 +0300
Message-ID: <1272957963.1978.25.camel@tubuntu.research.nokia.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
	 <20100430203411.25812.30019.stgit@baageli.muru.com>
	 <20100430205003.GG29604@atomide.com>  <20100504005222.GD29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29073 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab0EDH0a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 03:26:30 -0400
In-Reply-To: <20100504005222.GD29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2010-05-04 at 02:52 +0200, ext Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [100430 13:47]:
> > * Tony Lindgren <tony@atomide.com> [100430 13:32]:
> > > Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> > > at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> > > omap FB code is fixed.
> > 
> > This one I'll drop as soon as the problem is sorted out with
> > CONFIG_FB_OMAP.
> 
> This one seems to be something under drivers/video/omap, so
> I'll change CONFIG_FB_OMAP to be a module now. Updated patch
> below.
> 
> I'll update omap for-next accordingly, then Tomi can figure
> it out :)

This sounds... interesting... =) Any more info on what happens? Does it
also affect new omapfb driver?

 Tomi


