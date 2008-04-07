From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Help 1/2] MUSB: ZiO! CF card reader will trigger a change
	from MUSB host mode to MUSB peripheral mode
Date: Mon, 7 Apr 2008 20:48:30 +0300
Message-ID: <20080407174830.GA4464@kedavra.cpe.vivax.com.br>
References: <386072610804070408q16c5ffa1u6a0c2e35295aa327@mail.gmail.com> <af73f7a75d15439b4761e7b0baa612cf@felipebalbi.com> <200804070905.10048.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52096 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYDGRqj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 13:46:39 -0400
Content-Disposition: inline
In-Reply-To: <200804070905.10048.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, Bryan Wu <cooloney@kernel.org>, tony@atomide.com, linux-omap@vger.kernel.org

On Mon, Apr 07, 2008 at 09:05:09AM -0700, David Brownell wrote:
> On Monday 07 April 2008, Felipe Balbi wrote:
> > I recall having some issues on 100mA devices. During enumeration some
> > current spikes a few mAs above 100mA were occuring and we couldn't
> > enumerate the device due to vbus_err interrupt.
> 
> Yeah, I think the Mentor core is unduly sensitive to voltage
> fluctuation during enumeration.  There's supposed to be about
> 100 msec before VBUS must stabilize ... but the silicon doesn't
> seem to accept routine instabilities in that period, and then
> reports inappropriate VBUS errors.
> 
> 
> > If you check drivers/usb/musb/tusb6010.c you'll see that we've 
> > implemented a retry condition for those cases. The same retry can
> > be found in musb_core.c
> 
> The DaVinci support needed the same kind of logic.  All in
> all this is painful stuff to sort out, and it seems that
> each platform rediscovers it.  It would be better if the
> silicon itself weren't fighting back so hard...

Good point.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
