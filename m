From: Greg KH <greg@kroah.com>
Subject: Re: USB driver issue
Date: Thu, 31 Jul 2008 09:36:34 -0700
Message-ID: <20080731163634.GA9606@kroah.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E7@dbde02.ent.ti.com> <527235.45700.qm@web53204.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49783 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbYGaTlK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jul 2008 15:41:10 -0400
Content-Disposition: inline
In-Reply-To: <527235.45700.qm@web53204.mail.re2.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Emanoil Kotsev <deloptes@yahoo.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, SUBHRANIL CHOUDHURY <subhra85@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Thu, Jul 31, 2008 at 08:30:26AM -0700, Emanoil Kotsev wrote:
> I think everything is getting pretty messy recently - I was pretty
> satisfied with 2.6.20 and then tried 2.6.24. In fact I can not compile
> 2.6.20 right now because after an upgrade debian testing comes with
> gcc-4.3 that has a background struggle about who's wrong between gcc
> people and Linus Torvalds and the issue is still open.

That's an issue between you and Debian, just downgrade your version of
gcc if you don't like this.  Or use a distro that allows multiple
versions of gcc to be installed at the same time (I trivially switch
between 4 versions of gcc on my box.)

Either way, it's not a kernel issue, how could you blame 2.6.20 for gcc
4.3 issues when gcc 4.3 was not even released when .20 was released?
Are us kernel people time travellers?

> So what I'm pleading for is to focus on stability!

What exactly do you propose for such a "focus"?  How do you see this
happening?

> And yes I'm planing to try 2.6.26, but I'm pretty sure that there
> would be issues with drivers like uvcview, the proprietary ATI and
> NVidia and apps like skype

Closed source drivers have issues, film at 11.  Bah, take it up with
them, there is NOTHING that us developers can do about that, sorry.

Applications are a different story, they should "just work" with
different kernel versions, there should not be any problems there.  If
there are, let the kernel developers know, we take backwards userspace
compatiblity VERY seriously.

thanks,

greg k-h
