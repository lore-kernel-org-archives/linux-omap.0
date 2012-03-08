From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/7] OMAPDSS: HDMI: hot plug detect fix
Date: Thu, 8 Mar 2012 07:29:49 -0800
Message-ID: <20120308152949.GB5277@kroah.com>
References: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
 <1330604795-29156-8-git-send-email-tomi.valkeinen@ti.com>
 <20120307200146.GA26451@kroah.com>
 <1331192113.2354.2.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51521 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756738Ab2CHP3v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 10:29:51 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0E7B521011
	for <linux-omap@vger.kernel.org>; Thu,  8 Mar 2012 10:29:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1331192113.2354.2.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: stable@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Rob Clark <rob@ti.com>

On Thu, Mar 08, 2012 at 09:35:13AM +0200, Tomi Valkeinen wrote:
> On Wed, 2012-03-07 at 12:01 -0800, Greg KH wrote:
> > On Thu, Mar 01, 2012 at 02:26:35PM +0200, Tomi Valkeinen wrote:
> > > From: Rob Clark <rob@ti.com>
> > > 
> > > The "OMAPDSS: HDMI: PHY burnout fix" commit switched the HDMI driver
> > > over to using a GPIO for plug detect.  Unfortunately the ->detect()
> > > method was not also updated, causing HDMI to no longer work for the
> > > omapdrm driver (because it would actually check if a connection was
> > > detected before attempting to enable display).
> > > 
> > > Signed-off-by: Rob Clark <rob@ti.com>
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > 
> > You forgot to tell me what the git commit id is for this patch (it's
> > ca888a7958b3d808e4efd08ceff88913f4212c69, right?)
> 
> Yes, that's the one. It wasn't in Linus's tree yet, only in fbdev tree,
> so I wasn't sure what the commit id is.

Then you should not have sent it to me, as if I were to take it then, I
could not have :(

> > And why isn't this needed for the 3.0 kernel as well?
> 
> The detect() function is not present in 3.0, so there was nothing to
> break.

Ok, so everything I've queued up is all that is needed, right?

greg k-h
