From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP totally fucked?
Date: Tue, 06 Mar 2012 11:45:28 -0800
Message-ID: <87fwdlfr8n.fsf@ti.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
	<20120303180428.GA10293@atomide.com>
	<201203031829.06992.arnd@arndb.de>
	<20120303210521.GE10293@atomide.com>
	<20120304155909.GA14466@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:59073 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965234Ab2CFTpb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 14:45:31 -0500
Received: by mail-yw0-f54.google.com with SMTP id m50so2834048yhg.13
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 11:45:30 -0800 (PST)
In-Reply-To: <20120304155909.GA14466@n2100.arm.linux.org.uk> (Russell King's
	message of "Sun, 4 Mar 2012 15:59:09 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Sat, Mar 03, 2012 at 01:05:21PM -0800, Tony Lindgren wrote:
>> * Arnd Bergmann <arnd@arndb.de> [120303 09:57]:
>> > On Saturday 03 March 2012, Tony Lindgren wrote:
>> > > Well 85631d2 builds fine, looks like now some more includes of
>> > > plat/hardware.h are now needed.Have not yet tracked down which
>> > > commit triggers the build errors. Eventually those should become
>> > > local headers too..
>> > 
>> > I've tried building arm-soc/for-next and rmk/for-next, they are both
>> > fine, just merging the two gives me the same build errors that Russell
>> > saw.
>> > 
>> > Adding plat/hardware.h in all files that break solves the problems,
>> > aside from the iommu dependency for rpmsg for which Ohad has provided
>> > a fix already that I should pull.
>> 
>> Here's a patch for you to the cleanup branch to fix the hardware.h
>> build errors.
>
> Right, with this applied, things are better:
>
> 1. omap3430ldp allnoconfig is the first build without warnings, congrats.
> 2. omap4430sdp allnoconfig has a bunch of new section mismatch warnings,
>    a couple of compiler warnings, and builds:
>
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x183c): Section mismatch in reference from the function omap2_init_processor_devices() to the function .init.text:_init_omap_device()
> The function omap2_init_processor_devices() references
> the function __init _init_omap_device().
> This is often because omap2_init_processor_devices lacks a __init 
> annotation or the annotation of _init_omap_device is wrong.

Below is a fix for this one.

My compiler (gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3)) was
inlining these so I wasn't seeing this warning.  I had to make
omap2_init_processor_devices() static to make the warning appear.

Anyways, fix is trivial, patch below.

Kevin

>From d8d4a0917c731a5fd846cd846296e2b8a5f2348d Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 6 Mar 2012 11:38:01 -0800
Subject: [PATCH] ARM: OMAP2+: PM: fix section mismatch with
 omap2_init_processor_devices()

Fix the below warning by making omap2_init_processor_devices() __init.
It is called by an __init function and calls only __init functions, so
it should also be init.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x183c): Section mismatch in reference from the function omap2_init_processor_devices() to the function .init.text:_init_omap_device()
The function omap2_init_processor_devices() references
the function __init _init_omap_device().
This is often because omap2_init_processor_devices lacks a __init
annotation or the annotation of _init_omap_device is wrong.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1881fe9..d00c39e 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -49,7 +49,7 @@ static int _init_omap_device(char *name)
 /*
  * Build omap_devices for processors and bus.
  */
-static void omap2_init_processor_devices(void)
+static void __init omap2_init_processor_devices(void)
 {
 	_init_omap_device("mpu");
 	if (omap3_has_iva())
-- 
1.7.9.2


