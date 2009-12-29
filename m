From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 6/8] arm: omap: musb: pass power to usb_musb_init
Date: Tue, 29 Dec 2009 21:56:15 +0200
Message-ID: <1262116575.28789.84.camel@gandalf>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
	 <1261998590-6639-7-git-send-email-felipe.balbi@nokia.com>
	 <20091229195112.GF3512@atomide.com>  <1262116381.28789.83.camel@gandalf>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48742 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbZL2T4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 14:56:20 -0500
In-Reply-To: <1262116381.28789.83.camel@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, 2009-12-29 at 21:53 +0200, Felipe Balbi wrote:
> On Tue, 2009-12-29 at 11:51 -0800, Tony Lindgren wrote:
> > * Felipe Balbi <felipe.balbi@nokia.com> [091228 03:10]:
> > > each board might have a different charge pump and
> > > thus able to source more or less current on vbus
> > > so let power be easily configurable.
> > 
> > In order to justify merging this as a fix, can you please update
> > the subject and description to describe that this fixes the
> > the power value ?
> 
> for sure, doing it right now.

How about now ? (did the same to the board mode)

commit 860a17d3dc78cc8c640a83ade83dd0ec4f1217f1
Author: Felipe Balbi <felipe.balbi@nokia.com>
Date:   Mon Dec 28 00:46:19 2009 +0200

    arm: omap: musb: fix board mode by passing it to usb_musb_init
    
    each board will have a different mode which is peculiar
    to that board.
    
    Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

commit 86b92c438109a95c20fad62804b4b8040f3676b7
Author: Felipe Balbi <felipe.balbi@nokia.com>
Date:   Mon Dec 28 00:30:42 2009 +0200

    arm: omap: musb: fix board power budget by passing it to
usb_musb_init
    
    each board might have a different charge pump and
    thus able to source more or less current on vbus
    so let power be easily configurable.
    
    Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>

-- 
balbi

