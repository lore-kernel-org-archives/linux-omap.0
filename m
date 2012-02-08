From: Dmitry Antipov <dmitry.antipov@linaro.org>
Subject: Re: Minimum timing resolution in Ubuntu/Linaro on the PandaBoard
 ES
Date: Wed, 08 Feb 2012 05:55:22 -0800
Message-ID: <4F327ECA.4040105@linaro.org>
References: <4F31A91B.8080106@umich.edu> <4F32063F.1020607@linaro.org> <51DAA6EF-1C3B-4964-8447-893D295E51A1@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45477 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab2BHNyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 08:54:19 -0500
Received: by iacb35 with SMTP id b35so901376iac.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 05:54:18 -0800 (PST)
In-Reply-To: <51DAA6EF-1C3B-4964-8447-893D295E51A1@umich.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Richardson <chardson@umich.edu>
Cc: John Stultz <john.stultz@linaro.org>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org

On 02/08/2012 01:32 AM, Andrew Richardson wrote:

> Do you recommend using "Get linaro image tools: method 2 (source code)"
> ( http://releases.linaro.org/12.01/ubuntu/leb-panda/ ) and building the
> kernel myself?

Unfortunately this is the only way. In theory, there are clocksource=
boot option, and sysfs interface under /sys/devices/system/clocksource,
but, IIUC, there is no way to compile the kernel with both 32K and MPU
timers support and then select one of them for the default clock source
at the boot time or when the system is running.

> It seems to me that we would want to disable some of the power-saving
> changes that have been made, such as this timer, and possibly configure
> other settings like cache behavior, though I have no idea
> how they're currently set. I have a bunch of docs from ARM on power and
> cache config, but I haven't messed around with them as I'm not sure where
> to start. My best guess is that I would have to rebuild the kernel to
> start handling that configuration myself. Is that true?

If you're seriously concerned on the optimization for the particular
workload, you definitely should.

> Some people ( http://groups.google.com/group/pandaboard/browse_thread/thread/a18fa3514d130720 )
> have mentioned enabling line fill and prefetching to speed up memcpy
> operations, which also seems  useful. Is this also a kernel-level setting?

Sure. Caching (and it's relationship to real memory speed) is a hard topic.
For the starting point, try:

1. Read http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.faqs/ka13544.html
    (this is for A8, but should be more or less applicable to A9);

2. Run 'dmesg | grep -i cache' and check for the something similar to:

    L310 cache controller enabled
    l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000, Cache size: 1048576 B

3. Read http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246f/DDI0246F_l2c310_r3p2_trm.pdf
    and realize the meaning of these AUX_CTRL bits;

4. Read arch/arm/mach-omap2/omap4-common.c and arch/arm/mm/cache-l2x0.c, try to play
    with 'aux_ctrl' bits within omap_l2_cache_init() and check whether it affects your
    workload. Note this may cause kernel crash and/or prevent the system from booting at all.

Dmitry
