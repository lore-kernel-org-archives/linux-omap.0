From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v7] OMAP2+: PM: omap device: API's for handling
 mstandby mode
Date: Mon, 24 Jan 2011 15:03:49 +0530
Message-ID: <20110124093349.GC16582@m-desktop>
References: <1291298392-28729-1-git-send-email-manjugk@ti.com>
 <4CF8AC8B.9040800@ti.com>
 <20101203092514.GA10048@GLPP-machine>
 <4CF8E03A.4010000@ti.com>
 <20101214014822.GA3858@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:59013 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751197Ab1AXJes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 04:34:48 -0500
Received: by gye5 with SMTP id 5so1393017gye.4
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 01:34:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101214014822.GA3858@manju-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Paul/Benoit,

On Tue, Dec 14, 2010 at 07:18:22AM +0530, G, Manjunath Kondaiah wrote:
> Paul/Benoit,
> 
> On Fri, Dec 03, 2010 at 01:19:06PM +0100, Cousson, Benoit wrote:
> > On 12/3/2010 10:47 AM, G, Manjunath Kondaiah wrote:
> > >* Cousson, Benoit<b-cousson@ti.com>  [2010-12-03 09:38:35 +0100]:
> > 
> > [...]
> > 
> > >>>v7: replaced mutex lock with spin lock. Added use count for controlling
> > >>>access to sysconfig registers in case if overlapping request/release API's
> > >>>are used.
> > >>
> > >>I'm not sure it should be done here. I'd rather keep that code in
> > >>the DMA, since this is the only user of that feature.
> > >
> > >Are you referring to spin lock or usage count?
> > 
> > The spinlock is needed, I was referring to the usage count.
> > 
> > That being said, the API proposed by Paul (request/release
> > ) sound like a get/put, so maybe he had that kind of usage in mind.
> > 
> > I'm still not convince it should be done at hwmod API level.
> > 
> > 
> > Paul,
> > Any thoughts on that?
> 
> How do we proceed further?
Gentle reminder!

Can we please align on this so that DMA sysconfig patches can be
upstreamed?

Discussion on this topic can be accessed at:
https://patchwork.kernel.org/patch/372231/
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39728.html

-Manjunath
