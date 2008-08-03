From: Emanoil Kotsev <deloptes@yahoo.com>
Subject: Re: USB driver issue
Date: Sun, 3 Aug 2008 02:46:20 -0700 (PDT)
Message-ID: <464270.3859.qm@web53208.mail.re2.yahoo.com>
References: <20080803045717.GA9526@kroah.com>
Reply-To: deloptes@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from web53208.mail.re2.yahoo.com ([206.190.49.78]:39230 "HELO
	web53208.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753023AbYHCJqV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Aug 2008 05:46:21 -0400
In-Reply-To: <20080803045717.GA9526@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Hello,

thanks a lot, this solved the problem I think, because there are no such messages anymore. The answer - question I couldn't understand what you mean

The kernel version is 2.6.24.7.

I have just blacklisted the ub driver now, so it's never auto loaded.

I think it is the "Low Performance USB Block driver" is it correct?

thanks and regards again


--- On Sun, 8/3/08, Greg KH <greg@kroah.com> wrote:

> From: Greg KH <greg@kroah.com>
> Subject: Re: USB driver issue
> To: "Emanoil Kotsev" <deloptes@yahoo.com>
> Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
> Date: Sunday, August 3, 2008, 6:57 AM
> A: No.
> Q: Should I include quotations after my reply?
> 
> On Sat, Aug 02, 2008 at 09:33:19PM -0700, Emanoil Kotsev
> wrote:
> > Thanks for fast response
> > 
> > lsmod
> > ...
> > usb_storage            44932  0
> > ub                     18976  8
> > ...
> > 
> > both are loaded but devices hang on ub you are right.
> > 
> > I think linux decided to use ub on it's own  ...
> how do I change this
> > (ub is new to me  -  I am a kernel time traveler :-D 
> - I tought it's
> > normal - some kind of new feature)
> 
> Just don't build it, or rmmod it and then plug your
> device back in.
> 
> > Is there any sense to install 2.6.26 in this case
> (would it help me -
> > I know it would please you, but I'm trying to
> avoid work and fears)?
> 
> What kernel version is this problem happening on?
> 
> thanks,
> 
> greg k-h


      
