From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] arm: omap: musb: pass power to usb_musb_init
Date: Tue, 29 Dec 2009 12:55:54 -0800
Message-ID: <20091229205554.GK3512@atomide.com>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
 <1261998590-6639-7-git-send-email-felipe.balbi@nokia.com>
 <20091229195112.GF3512@atomide.com>
 <1262116381.28789.83.camel@gandalf>
 <1262116575.28789.84.camel@gandalf>
 <20091229200206.GJ3512@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65299 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbZL2Uz7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 15:55:59 -0500
Content-Disposition: inline
In-Reply-To: <20091229200206.GJ3512@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [091229 12:00]:
> * Felipe Balbi <me@felipebalbi.com> [091229 11:54]:
> > On Tue, 2009-12-29 at 21:53 +0200, Felipe Balbi wrote:
> > > On Tue, 2009-12-29 at 11:51 -0800, Tony Lindgren wrote:
> > > > * Felipe Balbi <felipe.balbi@nokia.com> [091228 03:10]:
> > > > > each board might have a different charge pump and
> > > > > thus able to source more or less current on vbus
> > > > > so let power be easily configurable.
> > > > 
> > > > In order to justify merging this as a fix, can you please update
> > > > the subject and description to describe that this fixes the
> > > > the power value ?
> > > 
> > > for sure, doing it right now.
> > 
> > How about now ? (did the same to the board mode)
> > 
> > commit 860a17d3dc78cc8c640a83ade83dd0ec4f1217f1
> > Author: Felipe Balbi <felipe.balbi@nokia.com>
> > Date:   Mon Dec 28 00:46:19 2009 +0200
> > 
> >     arm: omap: musb: fix board mode by passing it to usb_musb_init
> >     
> >     each board will have a different mode which is peculiar
> >     to that board.
> >     
> >     Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > commit 86b92c438109a95c20fad62804b4b8040f3676b7
> > Author: Felipe Balbi <felipe.balbi@nokia.com>
> > Date:   Mon Dec 28 00:30:42 2009 +0200
> > 
> >     arm: omap: musb: fix board power budget by passing it to
> > usb_musb_init
> >     
> >     each board might have a different charge pump and
> >     thus able to source more or less current on vbus
> >     so let power be easily configurable.
> >     
> >     Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Sounds good to me.

Oh one more thing: Can you please repost the series one more
time with LAKML Cc'd? We should have all the arch/arm/*omap*/
patches reviewed there too. Maybe Cc linux-usb too?

Regards,

Tony
