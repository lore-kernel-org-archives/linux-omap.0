From: Tony Lindgren <tony@atomide.com>
Subject: Re: Issues with GPIO and wake from sleep
Date: Thu, 13 Feb 2014 14:40:49 -0800
Message-ID: <20140213224048.GA28216@atomide.com>
References: <F690310232FDDF4AB457E8B3EF90DDE09A56D39C@MARCM-SBS2011.marcmltd.local>
 <20140117173902.GD7235@atomide.com>
 <F690310232FDDF4AB457E8B3EF90DDE09A5A80E9@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE09A5B971D@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE09A5BA71D@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52573 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbaBMWlB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 17:41:01 -0500
Content-Disposition: inline
In-Reply-To: <F690310232FDDF4AB457E8B3EF90DDE09A5BA71D@MARCM-SBS2011.marcmltd.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Murphy <marcmltd@marcm.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Marc Murphy <marcmltd@marcm.co.uk> [140205 15:20]:
> I have now stepped through most of the system as it goes into the sleep state.  It will transition into omap34xx_cpu_suspend and eventually work itself into an endless loop.
> 
> I have then taken a step back to see the config of the system and all kernel options seem to be correct with power management. 
> 
> I then looked at the boot line, I am running tftp which should be a problem for the suspend to ram, and there is an option of nohlt :
> setenv bootargs console=${console},115200n8 ${mem_size} mpurate=${mpurate} ${video_mode} ${extra_options} root=${nfsroot} rootfstype=nfs ip=dhcp nohlt rw
> 
> I was informed I needed to do this quite some time ago when I was having issue with the system booting.  Upon reading the kernel-paramters doc I see that the description is what I am experiencing;
> 	nohlt		[BUGS=ARM,SH] Tells the kernel that the sleep(SH) or
> 			wfi(ARM) instruction doesn't work correctly and not to
> 			use it. This is also useful when using JTAG debugger.
> 
> OK so WFI doesn't work correctly, I have no WFI operating.  If I remove the nohlt from the boot line the system freezes;
> [    2.833587] voltdm_scale: No voltage scale API registered for vdd_core
> [    2.840454] PM: no software I/O chain control; some wakeups may be lost
> [    2.856536] davinci_emac davinci_emac.0: using random MAC addr: 86:2d:4d:a4:87:3e

It seems that this is a 3517 based issue, maybe the davinci_emac driver
won't work properly with runtime PM?

Tony
