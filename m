From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Patch "REMOVE OMAP LEGACY CODE: Reset mach-omap1/board-*.c
	files to mainline" breaks nokia770
Date: Thu, 14 May 2009 03:23:35 +0300
Message-ID: <20090514002335.GA9538@nokia.com>
References: <20090514004651.77342rqoq5tz86ww@lidskialf.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22394 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbZENAdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 20:33:39 -0400
Content-Disposition: inline
In-Reply-To: <20090514004651.77342rqoq5tz86ww@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, May 14, 2009 at 01:46:51AM +0200, ext Andrew de Quincey wrote:
> Hi, I've just discovered that the patch at:
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=3eae3ea7c443fc4330574dffea65b6f2f53a2574
> 
> Breaks the nokia770's framebuffer as it removes the platform data for  
> the HWA742 LCD controller.
> 
> As the patch says "Patches against the mainline tree are welcome to  
> add back the missing functionality if needed!", I'm happy to do this.
> 
> However, since I'm fairly new to the linux-omap project, is simply  
> extracting the removed nokia770 code and generating a patch against  
> the mainline kernel sufficient? or is there a newer style of some sort  
> that should be adopted for this?

You can start by generating the new patch against mainline and running
scripts/checkpatch.pl, then you should probably find out if there are
any API changes and stuff like that. Then send the patch to lkml ccing
linux-omap and let's see what comments do you get from those guys :-)

-- 
balbi
