From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 3/4] ARM: OMAP3: Add support for 3430 SDP, v3
Date: Sat, 4 Apr 2009 16:48:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB102CA6@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAC076CA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34363 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbZDDLTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 07:19:25 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02FAC076CA@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Paul Walmsley <paul@pwsan.com>, "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

<snip>

> > Just to follow up on this, Kevin, Tony, and I spent some time tracking
> > this down.  We've observed that Beagle and 3430SDP fail to boot when the
> > mainline kernel is compiled with CodeSourcery gcc 2007q3, hanging in
> > 'Calibrating delay loop'.  When CSL gcc 2008q3 is used, the machines boot.
> > 
> 
> Hey, good catch guys! I checked the log I had for the one working case and
> do see that it was compiled with the 2008q3 toolchain. I did switch toolchains
> sometime the previous day and forgot all about it.
> 

I tried mainline with the 2008q3 toolchain now, and it still doesn't boot.
This time, I was careful enough to patch kernel/printk.c correctly and compile
with CONFIG_DEBUG_LL enabled, and it still does not work.

The patch I sent earlier (replacing the defconfig) does let me boot if I
compile with 2008q3. So does it make sense to take this in?

Also, here's the error if I simply take the defconfig from the linux-omap tree
and don't turn off CONFIG_FB_OMAP.

- Anand

  LD      .tmp_vmlinux1
drivers/built-in.o: In function `omapfb_do_probe':
/share/anand/linux-2.6/drivers/video/omap/omapfb_main.c:1724: undefined reference to `omap2_int_ctrl'
make: *** [.tmp_vmlinux1] Error 1
