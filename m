From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] board-omap3-beagle: add DSS2 support
Date: Wed, 14 Apr 2010 13:43:03 +0300
Message-ID: <1271241783.2690.218.camel@tubuntu.research.nokia.com>
References: <1271063990-12819-1-git-send-email-koen@dominion.thruhere.net>
	 <1271068631.2690.40.camel@tubuntu.research.nokia.com>
	 <h2r6ed0b2681004120415m118f3e7cy2b884cafed1cf737@mail.gmail.com>
	 <A0DD0612-FF66-475A-B1BF-FD408012A510@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18590 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758Ab0DNKnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 06:43:25 -0400
In-Reply-To: <A0DD0612-FF66-475A-B1BF-FD408012A510@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <koen@dominion.thruhere.net>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tue, 2010-04-13 at 17:24 +0200, ext Koen Kooi wrote:
> Op 12 apr 2010, om 13:15 heeft Grazvydas Ignotas het volgende geschreven:
> 
> > On Mon, Apr 12, 2010 at 1:37 PM, Tomi Valkeinen
> > <tomi.valkeinen@nokia.com> wrote:
> >> 
> >> On Mon, 2010-04-12 at 11:19 +0200, ext Koen Kooi wrote:
> >>> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV-out are supported.
> >>> 
> >>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> >> 
> >> Fiddling with TWL directly in tv enable/disable functions is a bit ugly,
> >> but I'm not sure if there's a better way for that. Otherwise:
> > 
> > It's only toggling VDAC supply, don't we already do that in DSS2 core?
> > I think beagle_panel_enable_tv and beagle_panel_disable_tv can be
> > simply removed.
> 
> I can send an updated patch with those bits removed if needed. Tomi?

Yes, all the comments from Grazvydas were valid.

 Tomi


