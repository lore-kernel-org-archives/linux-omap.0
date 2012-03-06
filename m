From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Tue, 6 Mar 2012 11:55:29 -0800
Message-ID: <20120306195529.GV12083@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
 <20120303180428.GA10293@atomide.com>
 <201203031829.06992.arnd@arndb.de>
 <20120303210521.GE10293@atomide.com>
 <20120304155909.GA14466@n2100.arm.linux.org.uk>
 <87fwdlfr8n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52132 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965199Ab2CFTzg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 14:55:36 -0500
Content-Disposition: inline
In-Reply-To: <87fwdlfr8n.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

* Kevin Hilman <khilman@ti.com> [120306 11:13]:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >
> > WARNING: arch/arm/mach-omap2/built-in.o(.text+0x183c): Section mismatch in reference from the function omap2_init_processor_devices() to the function .init.text:_init_omap_device()
> > The function omap2_init_processor_devices() references
> > the function __init _init_omap_device().
> > This is often because omap2_init_processor_devices lacks a __init 
> > annotation or the annotation of _init_omap_device is wrong.
> 
> Below is a fix for this one.
> 
> My compiler (gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3)) was
> inlining these so I wasn't seeing this warning.  I had to make
> omap2_init_processor_devices() static to make the warning appear.
> 
> Anyways, fix is trivial, patch below.

Thanks, I'll add that to fixes-non-critical-part2.

Regards,

Tony
