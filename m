From: Tony Lindgren <tony@atomide.com>
Subject: Re: is omap development at git tree on kernel.org
Date: Mon, 6 Feb 2012 15:16:37 -0800
Message-ID: <20120206231637.GC20333@atomide.com>
References: <alpine.DEB.2.02.1202061702130.13460@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37386 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065Ab2BFXQk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Feb 2012 18:16:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1202061702130.13460@heelrod.ad.cirrus.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: linux-omap@vger.kernel.org

Hi Brian,

* Brian Austin <brian.austin@cirrus.com> [120206 14:40]:
> Looking at the GIT logs for the linux-omap.git tree it seems pretty
> sparse like no for-next activity in quite a while.
> 
> I am using the OMAP for development and need to keep current with
> your platform.
> 
> So the questionis...
> 
> Is git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
> where the development is being done? I know that the kernel.org
> servers were down for a while and maybe the omap tree hasnt been
> fully updated from another remote one somewhere else?  Or is the
> fixes branch where all the work is done?

Yes that's the current URL. For most part all the code is in the
mainline kernel, and the linux-omap git tree is used for staging
the patches for every merge window. Right now the focus is getting
all the fixes into the -rc cycle, and over next few weeks we'll
get busy merging all the new code posted for the next merge window.

For stable versions, the latest stable mainline version is the
way to go, so that's v3.2.x right now. For development versions,
mainline v3.3-rc3 will contain the fixes you mentioned above.

Regards,

Tony
