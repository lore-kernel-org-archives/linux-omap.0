From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: [PATCH] cbus-retu-wdt: Remove unused nonstandard interfaces
Date: Thu, 03 Mar 2011 15:18:13 +0100
Message-ID: <1299161893.31972.0.camel@maggie>
References: <1299082318.13604.14.camel@marge>
	 <20110303094251.GG2644@legolas.emea.dhcp.ti.com>
	 (sfid-20110303_104301_717489_FFFFFFFFDB9EB0D8)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:47322 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab1CCOSU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 09:18:20 -0500
In-Reply-To: <20110303094251.GG2644@legolas.emea.dhcp.ti.com> (sfid-20110303_104301_717489_FFFFFFFFDB9EB0D8)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, 2011-03-03 at 11:42 +0200, Felipe Balbi wrote: 
> On Wed, Mar 02, 2011 at 05:11:58PM +0100, Michael Buesch wrote:
> > @@ -175,9 +124,9 @@ static int retu_wdt_release(struct inode
> >  	struct retu_wdt_dev *wdev = file->private_data;
> >  
> >  #ifndef CONFIG_WATCHDOG_NOWAYOUT
> > -	retu_wdt_ping_enable(retu_wdt);
> > +	retu_wdt_ping_enable(wdev);
> >  #endif
> > -	clear_bit(0, &retu_wdt->users);
> > +	clear_bit(0, &wdev->users);
> 
> this hunk isn't part of this patch.

Well, it's a compiler warning cleanup, so I thought it would be fine
to go with the big cleanup patch.
Is it necessary to do a separate patch for this?

-- 
Greetings Michael.

