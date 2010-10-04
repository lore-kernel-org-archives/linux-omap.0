From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: NOTE: hwmod changes merged to linux-omap master for testing
Date: Mon, 04 Oct 2010 08:06:14 -0700
Message-ID: <8762xi3sm1.fsf@deeprootsystems.com>
References: <20101002004821.GN3117@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64776 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489Ab0JDPGU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:06:20 -0400
Received: by pvg2 with SMTP id 2so1353209pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 08:06:19 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Mon, 4 Oct 2010 13:19:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Hi Tony,
> With latest merges on master branch with commit ID:
> 0882b1455797b0a104978000a622c3f2412e7cf5 omap: READ CAREFULLY: Fix build after merging in hwmod support for testing
>
> Booting with zoom3 seems to be fine but observed issues with omap4 blaze board. 
>
> Looks like multiple warning dumps and finally it crashes after "Freeing init memory" with both NFS and ramdisk file systems.
>
> The complete bootlogs are available at:
> NFS bootlog:
> http://pastebin.com/nrWQ5FGG

In the future, it helps greatly if you state what defconfig you're
using, and specifically what you've changed from the default defconfig.

Looking at this log, you've enabled CPUidle in your config, which is not
(yet) supported for OMAP4 in mainline.

Kevin

> Ramdisk bootlog:
> http://pastebin.com/1F75d2Ew
>
> -Manjunath 
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
>> Sent: Saturday, October 02, 2010 6:18 AM
>> To: linux-omap@vger.kernel.org
>> Subject: NOTE: hwmod changes merged to linux-omap master for testing
>> 
>> Hi all,
>> 
>> So I've finally merged Kevin's hwmod branch into the 
>> linux-omap master so we can give it some testing to see if we 
>> can merge it to the mainline. Might take few minutes to hit 
>> the mirrors.
>> 
>> Please note that for omap2plus machines you need to change:
>> 
>> - u-boot bootargs for kernel cmdline needs to change with setenv
>> - if you use hardcoded CONFIG_CMDLINE, change it in your .config
>> - /etc/inittab in your omap root file system if using serial console
>> 
>> This is because otherwise the serial-omap would be 
>> conflicting with the 8250 driver. This should not affect 
>> omap1 machines.
>> 
>> Please give it a try and report any issues on this list! Now 
>> all the machines except ams_delta_defconfig should build.
>> That one is still missing some camera driver changes to build.
>> 
>> Regards,
>> 
>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in the body of a message to 
>> majordomo@vger.kernel.org More majordomo info at  
>> http://vger.kernel.org/majordomo-info.html
>> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
