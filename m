From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc7
Date: Thu, 4 Jul 2013 17:11:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307041650170.6258@utopia.booyaka.com>
References: <alpine.DEB.2.02.1307011946180.4358@utopia.booyaka.com> <20130701204236.GA805@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42444 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558Ab3GDRLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 13:11:34 -0400
In-Reply-To: <20130701204236.GA805@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Mon, 1 Jul 2013, Felipe Balbi wrote:

> On Mon, Jul 01, 2013 at 07:48:50PM +0000, Paul Walmsley wrote:
> > Boot to userspace:
> >     FAIL ( 2/12): 37xxevm, am335xbonelt
> 
> <quoting part of [1]>
> | U-Boot# tftp 0x82000000 am335x-boneblack.dtb
> | link up on port 0, speed 100, full duplex
> | Using cpsw device
> | TFTP from server 192.168.57.1; our IP address is 192.168.57.138
> | Filename 'am335x-boneblack.dtb'.
> 
> Where are you taking am335x-boneblack.dtb from ? It's not in mainline
> v3.10-rc7 kernel:

As mentioned in my earlier reply:

http://www.spinics.net/lists/arm-kernel/msg255055.html

my earlier test boots were with the am335x-boneblack.dtb from the 
ti-linux-3.8.y tree from Vaibhav's github, since that was the only DTB 
that I was able to get any kernel to boot with.

The am33xx_only/appended DTB issues don't apply to this board since it's 
booted with detached DTB and omap2plus_defconfig.

Anyway, just retried it with the mainline am335x-bone.dtb file with v3.10, 
and the board comes up now.  So that's good, will switch to 
am335x-bone.dtb for the testing restate jobs to be run for 
BeagleBone-white, and let's see what previous kernels it boots with now...


- Paul
