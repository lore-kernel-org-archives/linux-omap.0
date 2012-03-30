From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: defconfig for panda
Date: Fri, 30 Mar 2012 16:11:06 -0500
Message-ID: <B05E7CFB-E2F3-426C-AAA8-622D715DB86A@kernel.crashing.org>
References: <1F91D012-8308-45BB-83AD-90E52D472AC2@kernel.crashing.org> <20120330184859.GB8240@atomide.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54054 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964808Ab2C3VLX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 17:11:23 -0400
In-Reply-To: <20120330184859.GB8240@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>


On Mar 30, 2012, at 1:48 PM, Tony Lindgren wrote:

> Hi,
> 
> * Kumar Gala <galak@kernel.crashing.org> [120329 12:24]:
>> As I'm new to the OMAP community this might be a stupid question but trying to just build and run a stock v3.3 kernel on a pandaboard.  In doing so it seems as if some basic drivers are not enabled in omap2plus_defconfig for the board.  I'm trying to figure out if this is normal for some reason or just an oversight.
>> 
>> For example, USB and USB ethernet (SMC95xx).  I notice the linaro kernel tree introduces an omap4_defconfig, so just wondering should I send patches to omap2plus_defconfig or what?
> 
> We can add those to omap2plus_defconfig for sure, but let's have
> them added as modules. Then distros can use that easily in a
> standard way using initramfs-tools etc.
> 
> Let's not change the drivers that are currently built in if they're
> needed for mounting mmc or nfsroot. Those can be changed later on.

I'll work up a patch, however I was doing this as I was trying to get NFS root working and thus would need USB + USB ethernet compiled in and not as modules for panda.  Is that ok?

- k