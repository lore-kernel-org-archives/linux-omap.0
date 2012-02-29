From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: OMAP4 HDMI PHY bug work-around for stable
Date: Wed, 29 Feb 2012 06:57:25 -0800
Message-ID: <20120229145725.GA26024@kroah.com>
References: <1328787865.1909.64.camel@deskari>
 <1330416193.2123.4.camel@deskari>
 <20120228164702.GB11021@kroah.com>
 <1330506444.1934.20.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52192 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031080Ab2B2PFy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 10:05:54 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BA0A920851
	for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 10:05:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1330506444.1934.20.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, Feb 29, 2012 at 11:07:24AM +0200, Tomi Valkeinen wrote:
> On Tue, 2012-02-28 at 08:47 -0800, Greg KH wrote:
> 
> > Sorry, but I don't accept pull requests.  I need patches in email form,
> > as described in the file, Documentation/stable_kernel_rules.txt.  Please
> > feel free to send them from your git tree that way.
> 
> Ah, I somehow missed that txt when googling about the stable kernel.
> Thanks for pointing it out.
> 
> > That seems like a lot of backporting for a single fix, but I'll be glad
> > to review them when you send them.
> 
> This is something that is not quite clear to me:
> 
> Should I strive for keeping the patches for stable as close as possible
> to the ones in mainline, and thus possibly being forced to take other
> extra patches with the actual fix as I did here

Yes.  If that is what is happening here, that's fine, just tell me.

> or
> 
> should I just rather cook up a new patch which just fixes the problem
> without caring about any cleanups etc. that are in the mainline, and
> thus possibly creating a rather different patch compared to mainline's
> version?

No, the first one.

thanks,

greg k-h
