From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH v3 0/7] misc patches (for ioctl and ssi)
Date: Fri, 15 Jan 2010 15:06:20 +0200
Message-ID: <1263560780.2092.5.camel@sanganak>
References: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59730 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab0AONG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 08:06:58 -0500
In-Reply-To: <1263258041-16836-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Contreras Felipe <felipe.contreras@nokia.com>

Hi Omar,

On Tue, 2010-01-12 at 02:00 +0100, ext Omar Ramirez Luna wrote:
> Ioctl numbers has changed, this will require an update on libbridge and clients accesing directly to the driver
> 
> - IO_ADDRESS is replaced for ioremap.
> 
> *v3
> - modified:
> 	DSPBRIDGE: replace IO_ADDRESS with ioremap, checking
> 	the result of ioremap
> 	(http://marc.info/?l=linux-omap&m=126324914710445&w=2).
> 	DSPBRIDGE: Use _IOxx macro to define ioctls (as per Nishanth comments)
> - new patch:
>   	DSPBRIDGE: remove WCD_Cmd structure
>   	
> *v2
> - dropped from the series:
> 	DSPBRIDGE: Increased DMM size to 256MB
> 	DSPBRIDGE: sysfs entry for global driver state
> - will be kept in bridge-pm
> 	DSPBRIDGE: Use dspbridge to initialize platform data
> 	DSPBRIDGE: change to cpufreq_register_notifier for OPP changes
> 	DSPBRIDGE: Fix header locations mach to plat

Where is the bridge-pm repository?
I am trying to compile dspbridge branch with HEAD commit as: DSPBRIDGE:
Use _IOxx macro to define ioctls. But compilation fails because of
following missing commit:

DSPBRIDGE: Fix header locations mach to plat

Can you move this commit from bridge-pm to dspbridge so that dspbridge
is in compilable state?

Thanks!

Cheers,
Ameya.

