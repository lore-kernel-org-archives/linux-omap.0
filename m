From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: ttyO2 broken on IGEPv2 on 3.3, 3.4-rc5 or arm-soc/for-next,
 working on 3.2
Date: Fri, 5 Oct 2012 10:10:09 +0200
Message-ID: <20121005101009.7ed1fe85@skate>
References: <20120504155255.140b4e3f@skate>
	<87397fewso.fsf@ti.com>
	<20120504175124.GI5613@atomide.com>
	<878vh78q7b.fsf@ti.com>
	<20121004180747.3b342904@skate>
	<87vcequpf7.fsf@deeprootsystems.com>
	<20121004221118.4316181d@skate>
	<CAKQ2WVp71=ULs_yK7Tkuo=8F4hATq0YCQ6RtV0ziJQQmnrib_g@mail.gmail.com>
	<20121004225704.0c08c862@skate>
	<87wqz5u97g.fsf@deeprootsystems.com>
	<CAAwP0s1+_GT=TtVKg8ARtfqDYm_AZ-D34KG_j3SLWz0yzZKJtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:49519 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2JEIK1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 04:10:27 -0400
In-Reply-To: <CAAwP0s1+_GT=TtVKg8ARtfqDYm_AZ-D34KG_j3SLWz0yzZKJtQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Enric =?UTF-8?B?QmFsbGV0?= =?UTF-8?B?YsOy?= i Serra <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Michael Opdenacker <michael.opdenacker@free-electrons.com>


On Fri, 5 Oct 2012 09:32:07 +0200, Javier Martinez Canillas wrote:

> As Enric said, u-boot has SPL and NAND support for IGEP since
> v2012.10-rc1. I just tried kernel a 3.6 with u-boot v2012.10-rc2 and
> it works for me.

Ok, I'll try this out.

> But I agree that the kernel shouldn't do any assumptions about the
> bootloader setting correctly the omap mux. Could you please share your
> bootloader that makes the kernel to fail (or your IGEP NAND patches on
> top of u-boot U-boot 2011.12) so I can reproduce the issue and try to
> fix it?

Ok, I'm using the X-Loader from git://git.igep.es/pub/scm/x-loader.git,
tag v1.4.4-3, on top of which I apply
http://git.free-electrons.com/training-materials/plain/lab-data/sysdev/u-boot/x-loader-1.4.4-3-igep-nand-support.patch
to add support for the NAND-based IGEPv2 rev6.

In terms of U-Boot, I use U-Boot 2011.12, on top of which I apply
http://git.free-electrons.com/training-materials/plain/lab-data/sysdev/u-boot/u-boot-2011.12-igep-nand-support.patch
to add support for the NAND-based IGEPv2 rev6.

To make things easier if you don't need to rebuild those, I've put
online pre-built binaries of X-Loader and U-Boot I'm using:
http://free-electrons.com/~thomas/pub/igep-serial-problem/.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
