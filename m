From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [RFC][PATCHv3 1/2] SFH7741: proximity sensor driver support
Date: Fri, 14 May 2010 14:23:22 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B320A40C@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C003B320A007@dbde02.ent.ti.com>
 <4BEAF03A.2070308@cam.ac.uk> <20100512182913.GC29366@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51028 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab0ENIxd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 04:53:33 -0400
In-Reply-To: <20100512182913.GC29366@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Wednesday, May 12, 2010 11:59 PM
> To: Jonathan Cameron
> Cc: Datta, Shubhrajyoti; linux-input@vger.kernel.org; linux-
> omap@vger.kernel.org
> Subject: Re: [RFC][PATCHv3 1/2] SFH7741: proximity sensor driver support
> 
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
In that case, I have another GPIO to switch on and off. How may I handle that case.

> --
> Dmitry
