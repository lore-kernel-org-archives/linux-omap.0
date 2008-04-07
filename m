From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old
	iPod will be reset several times in usb-storage transcation
Date: Mon, 7 Apr 2008 20:52:44 +0300
Message-ID: <20080407175244.GC4464@kedavra.cpe.vivax.com.br>
References: <386072610804070316i15ee172cue9c0cc5803f9a934@mail.gmail.com> <5bd10b9010c8281ff117f7ebb02f7d39@felipebalbi.com> <200804070903.11354.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51227 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbYDGRuw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 13:50:52 -0400
Content-Disposition: inline
In-Reply-To: <200804070903.11354.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, Bryan Wu <cooloney@kernel.org>, tony@atomide.com, linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Mon, Apr 07, 2008 at 09:03:10AM -0700, David Brownell wrote:
> On Monday 07 April 2008, Felipe Balbi wrote:
> > > e) So I hacked the usb-storage driver code, the Linux host on Blackfin
> > > will not wait for the 2nc CSW. Then this bug is gone.
> > > 
> > > This is just a workaround for that, it should not be the right way.
> > > Does anyone here meet this issue before, on Davinci or OMAP?
> > > We always need a real fix, thanks a lot
> > 
> > I've seen this already with n800/n810. It came up after a merge with
> > mainline that changed usb subsystem a bit.
> 
> Which merge was that?
> 
> My guess would be that the host side fault reporting
> changes (short packet?) didn't get fully reflected in
> the MUSB code.
> 
> How is "usbtest" behaving?  I'm not sure that would
> show errors like this, but at least it'd be good to
> know that's not an issue.

Exact to the point. I didn't have time yet to dig on this issue since
I'm kinda busy with twl4030 and omap3. Also some other drivers which I'm
planning to release soon. I2C and USB on omap3 is really sucking my life
as of these days.

But i'll try to find some spare time to dig on this during this or next
week.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
