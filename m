From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/24 V2] OMAP4: PM: suspend, CPU-hotplug and CPUilde support
Date: Mon, 10 Oct 2011 11:01:59 -0700
Message-ID: <87ty7ghgiw.fsf@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:42749 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751155Ab1JJSCE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Oct 2011 14:02:04 -0400
Received: by mail-gy0-f172.google.com with SMTP id 12so5540669gyd.3
        for <linux-omap@vger.kernel.org>; Mon, 10 Oct 2011 11:02:04 -0700 (PDT)
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 24 Sep 2011 11:44:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The series adds OMAP4 MPUSS (MPU SubSystem) power management support for
> suspend (S2R), CPU hotplug and CPUidle.

There are a few more compile errors when doing OMAP1-only builds.
You'll need a way to eliminate the secure calls for OMAP1.

This series causes a couple build errors when doing OMAP1-only builds
(I used omap1_defconfig):

First:

/work/kernel/omap/pm/arch/arm/plat-omap/common.c:24:30: fatal error: mach/omap-secure.h: No such file or directory

And trying creating a dummy header to see if it would continue to build gives:

/work/kernel/omap/pm/arch/arm/plat-omap/common.c: In function 'omap_reserve':
/work/kernel/omap/pm/arch/arm/plat-omap/common.c:70:2: error: implicit declaration of function 'omap_secure_ram_reserve_memblock'
make[2]: *** [arch/arm/plat-omap/common.o] Error 1
make[1]: *** [arch/arm/plat-omap] Error 2

Kevin
