From: "Avinash.H.M." <avinashhm@ti.com>
Subject: Re: [PATCH v3] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Fri, 20 May 2011 20:32:17 +0530
Message-ID: <20110520150216.GA11915@avinash-laptop>
References: <1304328111-15999-1-git-send-email-avinashhm@ti.com>
 <alpine.DEB.2.00.1105051548210.30136@utopia.booyaka.com>
 <20110509124842.GA25211@avinash-laptop>
 <alpine.DEB.2.00.1105181021590.4550@utopia.booyaka.com>
 <20110518162542.GB3026@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36015 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756038Ab1ETPCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:02:36 -0400
Received: by mail-yx0-f169.google.com with SMTP id 33so1654267yxt.0
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:02:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110518162542.GB3026@avinash-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khi>

On Wed, May 18, 2011 at 09:55:42PM +0530, Avinash.H.M. wrote:
> On Wed, May 18, 2011 at 10:22:28AM -0600, Paul Walmsley wrote:
> > On Mon, 9 May 2011, Avinash.H.M. wrote:
> > 
> > > On Thu, May 05, 2011 at 03:58:56PM -0600, Paul Walmsley wrote:
> > > 
> > > > > 
> > > > > The patch is based on
> > > > >  * git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> > > > >  * master branch.
> > > > >  * 9be20f0 commit. ( Linux-omap rebuilt: Updated to -rc5 )
> > > > 
> > > > Please base all your patches against mainline commits.  I suggest using 
> > > > v2.6.39-rc6.
> > > 
> > > OK Paul. I will rebase against mainline, -rc6.
> > 
> > Ping.  Any progress?
> 
> Hi Paul ,
> 
> I am having the patch ready. Haven't had a chance to test. I will test
> and send by tomorrow.

Hi Paul ,

I tested the patch on 3430 sdp today with the patch against 2.6.39-rc7.

I am seeing that the timeout is there during bootup event with this
patch. Tried with the previous version (v3 , which was tested against
the older commit and was confirmed to be working). With this also, i am
seeing that the reset timeouts are still present. 

So, looks like there is something broken. First glance, i suspect that
the register access may not be proper. Need to debug more. I ll debug
this and send the fix together.

Incase, if you want me to send this patch now and then send a seperate
patch for the recent problem, do let me know.

thanks ,

- Avinash

> thanks ,
> 
> - Avinash
> 
> > 
> > 
> > - Paul
