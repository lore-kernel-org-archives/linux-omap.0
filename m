From: Greg KH <greg@kroah.com>
Subject: Re: USB driver issue
Date: Sat, 2 Aug 2008 19:56:00 -0700
Message-ID: <20080803025600.GB8304@kroah.com>
References: <20080802182717.GA12051@kroah.com> <636531.20956.qm@web53210.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45546 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYHCDAR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Aug 2008 23:00:17 -0400
Content-Disposition: inline
In-Reply-To: <636531.20956.qm@web53210.mail.re2.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emanoil Kotsev <deloptes@yahoo.com>
Cc: me@felipebalbi.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Sat, Aug 02, 2008 at 05:11:51PM -0700, Emanoil Kotsev wrote:
> Greg, the discussion is getting out of control.

Hm, looks normal to me :)

> I think you are one of the few that understand what we are talking
> about (may be not compleetly but at least you are not confronting with
> statements that make me angry) and it seems that you are trying to
> find a compromise. So I'll write only this one mail and get out of
> this discussion.
> 
> First I do not consider 2.6.22 new, but it would be nice to have
> longer life cycles.

Why?  What good would that do?  How would we, as a community, support
such a thing?  Do you really understand how the kernel development
process works and how fast it moves?

> The problem is that we talk to different 3rd party vendors who re
> willing to help but can not follow this speed and the changes you do.

No, there is no "problem" here.  The 3rd party vendors are EXPLICITLY
not wanting to work within our development process for a variety of
reasons.  Again, there is _NOTHING_ that we can do about this.

They are the ones who do not want to work with us, or abide by our
license.  They are the leaches on our community and investment and cause
us nothing but pain and problems.  We have offered to do their work for
them, for free, for the rest of time, and they do not take us up on it.
What else can we do except ignore them as they really do not want to do
ANYTHING to help change the current situation?

> At the other hand the kernel needs more testing to step to next level
> of development.

"next level"?  What do you mean by this?  What would this level entail?

Is Linux somehow not working properly for the world?  It's in over 80%
of the TOP500 supercomputers and in all of Motorola's new phones,
a flexibility never before achieved by any type of operating system in
the history of computing.

And why do you not think we have a lot of testing?  There is a TON of
testing that happens for new releases.  Sure, we can always use more,
and welcome you to help out if possible.

Take a moment to try to understand how we do development here.  After
that, please try to describe exactly what you feel we are doing wrong,
and how we could change to make you feel better, in detail, given our
constraints.

thanks,

greg k-h
