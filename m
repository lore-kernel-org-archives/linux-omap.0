From: Tony Lindgren <tony@atomide.com>
Subject: Re: New randconfig build failures in OMAP
Date: Wed, 6 Jun 2012 01:11:27 -0700
Message-ID: <20120606081126.GT12766@atomide.com>
References: <20120605220214.GA29782@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:12919 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab2FFIL3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 04:11:29 -0400
Content-Disposition: inline
In-Reply-To: <20120605220214.GA29782@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120605 15:07]:
> I pulled Linus' tree at 7am UTC, and reran the builds after updating
> the build tree with that (plus my pending devel stuff).  The resulting
> randconfig spat out this:
> 
> arch/arm/mach-omap2/dsp.c: In function 'omap_dsp_reserve_sdram_memblock':
> arch/arm/mach-omap2/dsp.c:58: error: implicit declaration of function 'arm_memblock_steal'
> 
> Looks to me like a missing include?

Yup I've caused that one by moving the code around without the memblock.h
include. Looks like I did not hit this one yet with my randconfigs as it's
behind CONFIG_STAGING. Will post a fix along with few other randconfig
fixes.

TOny
