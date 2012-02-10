From: Tony Lindgren <tony@atomide.com>
Subject: Re: is omap development at git tree on kernel.org
Date: Fri, 10 Feb 2012 10:26:14 -0800
Message-ID: <20120210182614.GR1426@atomide.com>
References: <alpine.DEB.2.02.1202061702130.13460@heelrod.ad.cirrus.com>
 <20120206231637.GC20333@atomide.com>
 <alpine.DEB.2.02.1202070849400.24880@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24521 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759807Ab2BJS0Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 13:26:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1202070849400.24880@heelrod.ad.cirrus.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: linux-omap@vger.kernel.org

* Brian Austin <brian.austin@cirrus.com> [120207 06:23]:
> On Mon, 6 Feb 2012, Tony Lindgren wrote:
> 
> >Yes that's the current URL. For most part all the code is in the
> >mainline kernel, and the linux-omap git tree is used for staging
> >the patches for every merge window. Right now the focus is getting
> >all the fixes into the -rc cycle, and over next few weeks we'll
> >get busy merging all the new code posted for the next merge window.
> >
> >For stable versions, the latest stable mainline version is the
> >way to go, so that's v3.2.x right now. For development versions,
> >mainline v3.3-rc3 will contain the fixes you mentioned above.
> >
> 
> Thanks for the info Tony,
> 
> Just to give you some background,  I do my codec development on a
> "beagleboard like" system and use the for-next branch of ASoC for
> codec patches.  I have noticed some issues with the latest OMAP port
> in this branch and have seem the emails lately from Russell...
> 
> I have seen these issues for a while and would be more than happy to
> inform the OMAP folks of problems with the latest dev branches, kind
> of like a regression tester for you.  If I find something and can
> fix with a patch to email this list, what linux-omap branch should I
> base the patch off of?

Usually for fixes, it's best to base them on most recent mainline
tag that works. So right now either v3.2 or v3.3-rc3.

Regards,

Tony
