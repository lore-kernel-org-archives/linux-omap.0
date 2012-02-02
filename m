From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Thu, 2 Feb 2012 13:02:05 -0800
Message-ID: <20120202210205.GA4356@kroah.com>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
 <20120126042155.GA3185@suse.de>
 <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56514 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757084Ab2BBVD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 16:03:27 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 74584218CC
	for <linux-omap@vger.kernel.org>; Thu,  2 Feb 2012 16:03:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jan 26, 2012 at 12:34:50PM -0700, Paul Walmsley wrote:
> On Thu, 26 Jan 2012, Greg KH wrote:
> 
> > Ok, I've just reverted both of these patches for now, please send new
> > ones when you have them.
> 
> Thanks.  A pull request is at the bottom of this message.  The patches 
> are also available from the mailing list archives here:
> 
> http://marc.info/?l=linux-arm-kernel&m=132754676014389&w=2
> http://marc.info/?l=linux-arm-kernel&m=132754677914395&w=2
> http://marc.info/?l=linux-arm-kernel&m=132754676014388&w=2

Now applied.

greg k-h
