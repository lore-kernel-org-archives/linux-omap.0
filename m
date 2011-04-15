From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 16:40:00 +0200
Message-ID: <201104151640.01040.arnd@arndb.de>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <4DA84AAB.60601@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53111 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab1DOOkY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 10:40:24 -0400
In-Reply-To: <4DA84AAB.60601@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robherring2@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org

On Friday 15 April 2011 15:39:55 Rob Herring wrote:

> On 04/15/2011 08:06 AM, Russell King - ARM Linux wrote:
> > This is work in progress.
> >
> > We have two SoCs using SRAM, both with their own allocation systems,
> > and both with their own ways of copying functions into the SRAM.
> 
> It's more than that. Several i.MX chips use plat-mxc/iram_alloc.c.

There are also non-ARM systems doing something like that,
arch/blackfin/mm/sram-alloc.c comes to mind. On powerpc, the
ppc7410 also has this feature in hardware, but I believe it was
never supported in mainline Linux.

How about putting sram-pool.c into the top-level mm/ directory
and sram-pool.h into include/linux? They seem to be completely
generic to me, aside from the dependency on asm/fncpy.h which
should probably remain arch specific.

As long as CONFIG_ARM_SRAM_POOL (or perhaps just CONFIG_SRAM_POOL)
is selected only by platforms that support it, the dependency
should not hurt.

	Arnd
