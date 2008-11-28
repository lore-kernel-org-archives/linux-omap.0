From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add OMAP2 camera driver
Date: Fri, 28 Nov 2008 09:04:50 -0800
Message-ID: <20081128170446.GE6640@atomide.com>
References: <5d5443650811261044w30748b75w5a47ce8b04680f79@mail.gmail.com> <200811262116.42364.hverkuil@xs4all.nl> <5d5443650811262323l759d8c02s835c9a7454508b85@mail.gmail.com> <492E69C9.9080904@nokia.com> <5d5443650811270942n2421ea27v194e4c8aa1933dda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56645 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbYK1REz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 12:04:55 -0500
Content-Disposition: inline
In-Reply-To: <5d5443650811270942n2421ea27v194e4c8aa1933dda@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, Hans Verkuil <hverkuil@xs4all.nl>, video4linux-list@redhat.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

* Trilok Soni <soni.trilok@gmail.com> [081127 09:42]:
> Hi Sakari,
> 
> >
> > It *might* be possible that the same camera block would be used in non-OMAP
> > CPUs as well but I guess it is safe to assume that it depends on ARCH_OMAP
> > now.
> 
> Right, better to keep ARCH_OMAP as dependancy.
> 
> >>
> >> Thanks for the review comments. I will resubmit the patch.
> >
> > Is this exactly the same code that was removed from linux-omap a while ago?
> >
> > ---
> > commit ebdae9abf598ae8a3ee1c8c477138f82b40e7809
> > Author: Tony Lindgren <tony@atomide.com>
> > Date:   Mon Oct 27 13:33:13 2008 -0700
> >
> >    REMOVE OMAP LEGACY CODE: Delete all old omap specific v4l drivers
> >
> >    All v4l development must be done on the v4l mailing list with linux-omap
> >    list cc'd.
> >
> >    Signed-off-by: Tony Lindgren <tony@atomide.com>
> >
> 
> Yes, it the same commit from which I have based this patch.
> 
> > ---
> >
> > Although I haven't had time to discuss this anywhere, I though a possible
> > reason of for the removal was that some parts of the code are not that
> > pretty (e.g. DMA) and those parts should be rewritten.

Well mostly the motivation for removal from linux-omap tree was to
send the camera development to v4l list. For the camera DMA issues, I guess
Sakari you know best how it should be handled.

> > But yes, the OMAP 2 camera driver does actually work and I would suppose it
> > has users, too (think N800/N810).
> 
> Yes, I have both ;)
> 
> >
> > I'm in if the aim is to get this back to linux-omap. :-) (Waiting for the
> > next patch from Trilok.)
> 
> It will come down to linux-omap via mainline tree :)

I like that :)

Tony
