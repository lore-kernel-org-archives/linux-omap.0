From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC] possible removal of omap-serial
Date: Fri, 21 Mar 2014 10:44:48 -0700
Message-ID: <20140321174448.GA4716@kroah.com>
References: <20140320235210.GB26964@saruman.home>
 <20140321001228.GA18131@kroah.com>
 <20140321013557.GB29691@saruman.home>
 <20140321013729.GC29691@saruman.home>
 <20140321023646.GB17404@kroah.com>
 <CAOCHtYhwuAJy-=LJV=eFwzwqzDDPv5RngQ2dVJDOPhYT+J_Mvw@mail.gmail.com>
 <20140321025238.GA31610@saruman.home>
 <20140321171029.GC3842@atomide.com>
 <20140321173653.GP12310@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45967 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaCURmm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Mar 2014 13:42:42 -0400
Content-Disposition: inline
In-Reply-To: <20140321173653.GP12310@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Robert Nelson <robertcnelson@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Fri, Mar 21, 2014 at 12:36:53PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Mar 21, 2014 at 10:10:30AM -0700, Tony Lindgren wrote:
> > > > On the support side, I'm not looking forward to this for beagle/panda
> > > > users.  We've already converted them once from ttySx -> ttyOx back in
> > > > 2.6.33/2.6.34? days.  That was an irc/email/u-boot/kernel nightmare...
> > > 
> > > that's exactly why we're talking about ways to maintain backwards
> > > compatibility here. But I'm more interested in finding a way to switch
> > > over to ttyS and have a symlink to ttyO, that way a simple debootstrap
> > > (or any other ARM distro minimal rootfs) would work out of the box,
> > > without any changes, just like in "normal" systems.
> > 
> > Yeah let's not break things. The symlink solution won't work for kernel
> 
> again. Let's not break things again.
> 
> > console output so it needs to be dealt with some other way.
> 
> it would if kernel itself would create the symlink, but that might not
> be doable in a clean way.

The kernel isn't going to create the symlink, sorry, no.
