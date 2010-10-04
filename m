From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: NOTE: hwmod changes merged to linux-omap master for testing
Date: Mon, 4 Oct 2010 13:19:40 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
References: <20101002004821.GN3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52250 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038Ab0JDHtq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 03:49:46 -0400
In-Reply-To: <20101002004821.GN3117@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,
With latest merges on master branch with commit ID:
0882b1455797b0a104978000a622c3f2412e7cf5 omap: READ CAREFULLY: Fix build after merging in hwmod support for testing

Booting with zoom3 seems to be fine but observed issues with omap4 blaze board. 

Looks like multiple warning dumps and finally it crashes after "Freeing init memory" with both NFS and ramdisk file systems.

The complete bootlogs are available at:
NFS bootlog:
http://pastebin.com/nrWQ5FGG

Ramdisk bootlog:
http://pastebin.com/1F75d2Ew

-Manjunath 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Saturday, October 02, 2010 6:18 AM
> To: linux-omap@vger.kernel.org
> Subject: NOTE: hwmod changes merged to linux-omap master for testing
> 
> Hi all,
> 
> So I've finally merged Kevin's hwmod branch into the 
> linux-omap master so we can give it some testing to see if we 
> can merge it to the mainline. Might take few minutes to hit 
> the mirrors.
> 
> Please note that for omap2plus machines you need to change:
> 
> - u-boot bootargs for kernel cmdline needs to change with setenv
> - if you use hardcoded CONFIG_CMDLINE, change it in your .config
> - /etc/inittab in your omap root file system if using serial console
> 
> This is because otherwise the serial-omap would be 
> conflicting with the 8250 driver. This should not affect 
> omap1 machines.
> 
> Please give it a try and report any issues on this list! Now 
> all the machines except ams_delta_defconfig should build.
> That one is still missing some camera driver changes to build.
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 