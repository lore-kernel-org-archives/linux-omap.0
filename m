From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2 OneNAND GPIO fix
Date: Tue, 16 Dec 2008 08:37:03 -0800
Message-ID: <20081216163702.GQ19551@atomide.com>
References: <200812111759.15180.jpihet@mvista.com> <20081215234058.GC19551@atomide.com> <200812160919.24771.jpihet@mvista.com> <20081216103909.60b9ba67.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65031 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbYLPQhN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 11:37:13 -0500
Content-Disposition: inline
In-Reply-To: <20081216103909.60b9ba67.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Jean Pihet <jpihet@mvista.com>, linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [081216 00:39]:
> On Tue, 16 Dec 2008 09:19:24 +0100
> "ext Jean Pihet" <jpihet@mvista.com> wrote:
> 
> > On Tuesday 16 December 2008 00:40:59 Tony Lindgren wrote:
> > > * Jean Pihet <jpihet@mvista.com> [081211 09:02]:
> > > > Hi,
> > > >
> > > > Here is a patch to have the OMAP2 OneNAND driver compile on the latest
> > > > tree. I do not know if this has been addressed already, here is a patch.
> > >
> > > Looks like I already applied similar fixes. These are queued up for
> > > mainline too BTW.
> > Ok. My patch also changes the request and free omap calls to the standard 
> > version. I can generate a new patch if needed.
> > 
> IRCC gpiolib conversion patches are already going. Tony?

Yeah, should be about to get pulled into Russell's queue, also
available here:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=hsmmc-init

So Jean, if you can check what still needs to be patched there, and
we can queue it via omap-fixes.

Regards,

Tony
