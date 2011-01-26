From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v7] OMAP2+: PM: omap device: API's for handling mstandby
 mode
Date: Wed, 26 Jan 2011 12:05:27 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101261159070.16671@utopia.booyaka.com>
References: <1291298392-28729-1-git-send-email-manjugk@ti.com> <4CF8AC8B.9040800@ti.com> <20101203092514.GA10048@GLPP-machine> <4CF8E03A.4010000@ti.com> <20101214014822.GA3858@manju-desktop> <20110124093349.GC16582@m-desktop>
 <20110126004128.GA8524@manju-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52725 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab1AZTF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 14:05:28 -0500
In-Reply-To: <20110126004128.GA8524@manju-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, adrian.hunter@nokia.com, peter.ujfalusi@nokia.com, tony@atomide.com

On Wed, 26 Jan 2011, G, Manjunath Kondaiah wrote:

> On Mon, Jan 24, 2011 at 03:03:49PM +0530, G, Manjunath Kondaiah wrote:
> > Paul/Benoit,
> > 
> > On Tue, Dec 14, 2010 at 07:18:22AM +0530, G, Manjunath Kondaiah wrote:
> > > Paul/Benoit,
> > > 
> > > On Fri, Dec 03, 2010 at 01:19:06PM +0100, Cousson, Benoit wrote:
> > > > On 12/3/2010 10:47 AM, G, Manjunath Kondaiah wrote:
> > > > >* Cousson, Benoit<b-cousson@ti.com>  [2010-12-03 09:38:35 +0100]:
> > > > 
> > > > [...]
> > > > 
> > > > >>>v7: replaced mutex lock with spin lock. Added use count for controlling
> > > > >>>access to sysconfig registers in case if overlapping request/release API's
> > > > >>>are used.
> > > > >>
> > > > >>I'm not sure it should be done here. I'd rather keep that code in
> > > > >>the DMA, since this is the only user of that feature.
> > > > >
> > > > >Are you referring to spin lock or usage count?
> > > > 
> > > > The spinlock is needed, I was referring to the usage count.
> > > > 
> > > > That being said, the API proposed by Paul (request/release
> > > > ) sound like a get/put, so maybe he had that kind of usage in mind.
> > > > 
> > > > I'm still not convince it should be done at hwmod API level.
> > > > 
> > > > 
> > > > Paul,
> > > > Any thoughts on that?
> > > 
> > > How do we proceed further?
> > Gentle reminder!
> > 
> > Can we please align on this so that DMA sysconfig patches can be
> > upstreamed?
> > 
> > Discussion on this topic can be accessed at:
> > https://patchwork.kernel.org/patch/372231/
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39728.html
> 
> As there is no response from paul on this topic, I will go ahead with usage
> count logic proposed by Adrian Hunter <adrian.hunter@nokia.com> at:
> https://patchwork.kernel.org/patch/366831/
> Above logic has got:
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Yes, that's probably a good idea for right now.  There's a wider spectrum 
of opinion than I had thought on whether this type of thing belongs in the 
hwmod code.  I'd like to have a greater degree of alignment on that before 
we merge something into the hwmod code.

So, unless there is some reason why it will cause problems not to have 
this in the hwmod code for right now, please just go ahead and deal with 
it in your DMA code, and then we will move it to the hwmod code later as 
needed.


- Paul
