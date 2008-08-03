From: Greg KH <greg@kroah.com>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 21:57:17 -0700
Message-ID: <20080803045717.GA9526@kroah.com>
References: <20080803041837.GA9216@kroah.com> <782550.35205.qm@web53206.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35448 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYHCE7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Aug 2008 00:59:35 -0400
Content-Disposition: inline
In-Reply-To: <782550.35205.qm@web53206.mail.re2.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emanoil Kotsev <deloptes@yahoo.com>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>


A: No.
Q: Should I include quotations after my reply?

On Sat, Aug 02, 2008 at 09:33:19PM -0700, Emanoil Kotsev wrote:
> Thanks for fast response
> 
> lsmod
> ...
> usb_storage            44932  0
> ub                     18976  8
> ...
> 
> both are loaded but devices hang on ub you are right.
> 
> I think linux decided to use ub on it's own  ... how do I change this
> (ub is new to me  -  I am a kernel time traveler :-D  - I tought it's
> normal - some kind of new feature)

Just don't build it, or rmmod it and then plug your device back in.

> Is there any sense to install 2.6.26 in this case (would it help me -
> I know it would please you, but I'm trying to avoid work and fears)?

What kernel version is this problem happening on?

thanks,

greg k-h
