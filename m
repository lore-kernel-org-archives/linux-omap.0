From: "Vutla, Lokesh" <lokeshvutla@ti.com>
Subject: Re: Help needed with remaining plat headers
Date: Thu, 27 Sep 2012 15:27:50 +0530
Message-ID: <CAJ1gdca9cPA97rbJV_Q5rEQCJydmoRPuGYE1oq1vUhmxdPnEKA@mail.gmail.com>
References: <20120920232907.GN28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:58001 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645Ab2I0J6M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 05:58:12 -0400
Received: by oagh16 with SMTP id h16so1570689oag.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 02:58:10 -0700 (PDT)
In-Reply-To: <20120920232907.GN28835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

On Fri, Sep 21, 2012 at 4:59 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi all,
>
> With the recent pull request I sent for v3.7, we now have pretty
> much all the mach includes fixed up for omap2+ for single zImage
> support.
>
> We still have quite a few plat headers that we need to sort
> out manually.
>
> Please take a look at the following list, and reply to this
> thread if you are working on patches moving one of the headers
> in the list so we can coordinate things. The rules are simple
> for most of them:
>
> 1. For driver related data, the header should now be in
>    include/linux/platform_data/*.h
>
> 2. For mach-omap2 specific things, the headers should be
>    in arch/arm/mach-omap2.
>
> 3. Drivers should not include anything from plat or mach.
>
> I'll be looking into getting rid of cpu.h etc for v3.8 merge
> window, but won't be looking much at the driver related
> headers. So some help would be appreciated here :)
>
> Regards,
>
> Tony
>
>
> $ ls arch/arm/plat-omap/include/plat/
> clkdev_omap.h
> clock.h
> common.h
> cpu.h
> dma-44xx.h
> dma.h
As a part of clean up I am looking at dma.h and dma-44xx.h files
ll send you patches once cleanup and testing is done.

Thanks
Lokesh

> dmtimer.h
> fpga.h
> gpmc.h
> i2c.h
> iommu2.h
> iommu.h
> iopgtable.h
> iovmm.h
> led.h
> mailbox.h
> menelaus.h
> mmc.h
> multi.h
> omap_device.h
> omap_hwmod.h
> omap-pm.h
> omap-secure.h
> omap-serial.h
> prcm.h
> sdrc.h
> serial.h
> sram.h
> tc.h
> timex.h
> uncompress.h
> usb.h
> vram.h
> vrfb.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
