From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: is omap development at git tree on kernel.org
Date: Tue, 7 Feb 2012 08:53:34 -0600
Message-ID: <alpine.DEB.2.02.1202070849400.24880@heelrod.ad.cirrus.com>
References: <alpine.DEB.2.02.1202061702130.13460@heelrod.ad.cirrus.com> <20120206231637.GC20333@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:44158 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754189Ab2BGOyl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 09:54:41 -0500
In-Reply-To: <20120206231637.GC20333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Brian Austin <brian.austin@cirrus.com>, linux-omap@vger.kernel.org

On Mon, 6 Feb 2012, Tony Lindgren wrote:

> Yes that's the current URL. For most part all the code is in the
> mainline kernel, and the linux-omap git tree is used for staging
> the patches for every merge window. Right now the focus is getting
> all the fixes into the -rc cycle, and over next few weeks we'll
> get busy merging all the new code posted for the next merge window.
>
> For stable versions, the latest stable mainline version is the
> way to go, so that's v3.2.x right now. For development versions,
> mainline v3.3-rc3 will contain the fixes you mentioned above.
>

Thanks for the info Tony,

Just to give you some background,  I do my codec development on a 
"beagleboard like" system and use the for-next branch of ASoC for codec 
patches.  I have noticed some issues with the latest OMAP port in this 
branch and have seem the emails lately from Russell...

I have seen these issues for a while and would be more than happy to 
inform the OMAP folks of problems with the latest dev branches, kind of 
like a regression tester for you.  If I find something and can fix with a 
patch to email this list, what linux-omap branch should I base the patch 
off of?

Thanks,
Brian

