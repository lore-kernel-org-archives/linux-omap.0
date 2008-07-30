From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: USB driver issue
Date: Wed, 30 Jul 2008 19:42:44 +0300
Message-ID: <20080730164243.GT7275@frodo>
References: <31e679430807300505o3050a75ar2f9d8ff0cd35ea1b@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E9@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40878 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbYG3QnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jul 2008 12:43:00 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02567D91E9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Emanoil Kotsev <deloptes@yahoo.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, SUBHRANIL CHOUDHURY <subhra85@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Wed, Jul 30, 2008 at 09:56:48PM +0530, Gadiyar, Anand wrote:
> > That's plain wrong. 2.6.22 was released in July 2007. But 2.6.22.18 was not.
> > That came much later - in February this year. And people still do use 2.6.22
> > kernels. Besides, the MUSB code hasn't really changed that much in this time.
> >
> > Do you really think the problem will go away in 2.6.26? People can't always use the
> > latest kernel, you know. Embedded kernels don't get enough testing. There's always
> > a chance this is a new driver. And even if it weren't, the very act of debugging
> > a problem like this is a good learning experience.
> 
> I meant new bug.
> 
> >
> > Grr. Saying one needs to upgrade to the latest kernel before one can expect
> > support is a bit like certain proprietary OS vendors - and even they do a better
> > job than this.

It can also be a fixed bug and there's no reason to try to fix it
"again". The time frame from 2.6.22-omap1 (linux-omap tag) until now
contains the most active development on musb driver. Several hw
workarounds were found, omap3 support was added, several cleanups were
done and a lot more.

It's a +16k lines diff. I'd rather try it in a recent kernel just to be
sure the bug still in, if it's not we try to find where is the fix and
backport it to 2.6.22 kernel.

For me it sounds mych saner going this way.

I really don't see how this relates to proprietary OS vendors support.
I'm pretty sure kernel from omapzoom would have support for his 3430 osk
board, wouldn't it?

Besides, wouldn't that board work with board-omap3evm.c code just by
tweaking the machine type ?

I really believe it'd be something good to try, either recent linux-omap
or omapzoom git tree. I believe still 2.6.24 right ?

-- 
balbi
