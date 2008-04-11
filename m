From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Help 1/2] MUSB: ZiO! CF card reader will trigger a change
	from MUSB host mode to MUSB peripheral mode
Date: Fri, 11 Apr 2008 17:59:09 +0300
Message-ID: <20080411145909.GA4457@kedavra.cpe.vivax.com.br>
References: <386072610804070408q16c5ffa1u6a0c2e35295aa327@mail.gmail.com> <af73f7a75d15439b4761e7b0baa612cf@felipebalbi.com> <200804070905.10048.david-b@pacbell.net> <386072610804080006g588c7ad9ya4dd8c9c9c6cf827@mail.gmail.com> <386072610804100424l46273f0en9cc531dd7ec876ee@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47807 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbYDKO5S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 10:57:18 -0400
Content-Disposition: inline
In-Reply-To: <386072610804100424l46273f0en9cc531dd7ec876ee@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <me@felipebalbi.com>, tony@atomide.com, linux-omap@vger.kernel.org

On Thu, Apr 10, 2008 at 07:24:50PM +0800, Bryan Wu wrote:
> I think this kind of devices maybe should be added to the blacklist of
> the musb otg driver.
> 
> Do you guys have some idea about that?

overcurrent protection is triggering fine, that's why you're getting
vbus_err. Blacklist shouldn't be in the kernel, what we should do is
just notify the user about this error (needed for otg certification)
but never blacklist anything.

On the other hand, musb core seems to behave in a quite silly way when
it comes to current spikes on read/write operations (after enumeration
and after you can access the device). It should rely on its capacitors
on case of vbus drop and only trigger vbus_err interrupt if it really
couldn't recover from it after capacitors are discharged otherwise it
should stay silently and filter out such current spikes.

I'm still looking into how to filter this out in software but it's been
quite a challenge as you noticed yourself.

Let's try to keep going on this, otherwise user experience will be
awful with several mass storage devices.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
