From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [RFC][PATCHv3 1/2] SFH7741: proximity sensor driver support
Date: Wed, 12 May 2010 22:08:15 +0200
Message-ID: <1273694895.15717.4.camel@lovely>
References: <0680EC522D0CC943BC586913CF3768C003B320A007@dbde02.ent.ti.com>
	 <4BEAF03A.2070308@cam.ac.uk>
	 <20100512182913.GC29366@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47925 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab0ELUCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 16:02:07 -0400
In-Reply-To: <20100512182913.GC29366@core.coreip.homeip.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-05-12 at 11:29 -0700, Dmitry Torokhov wrote:
> On Wed, May 12, 2010 at 07:15:22PM +0100, Jonathan Cameron wrote:
> > Hi,
> > 
> > I was wondering if you could provide a bit more detail on what this
> > driver is actually doing?  My appologies if I have missed a
> > previous explanation.  If so, please add a Documentation file
> > to explain what is going on.
> > 
> > The driver you have here does virtually nothing itself.  It takes
> > both its source of interrupt and read function from platform
> > data. Given the value is always 0 or 1, I'm guessing you are
> > simply reading a gpio pin. That makes this effectively a button
> > and doesn't require any specific code.  The fact it is a
> > proximity sensor isn't relevant to anything other than perhaps
> > the name.
> 
> Excellent point. Maybe it should simply use gpio_keys driver with
> SW_FRONT_PROXIMITY code.
> 

I had a look into the datasheet, this SFH 7741 has one Schmitt trigger
output: So yes, it's a "key" even without chatter.


