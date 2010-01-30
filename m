From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] OMAP2/3: update default defconfig, towards smaller kernel
Date: Sat, 30 Jan 2010 11:25:22 +0100
Message-ID: <10B267BD-D756-4FDA-ADDA-892DAA1FAAEC@student.utwente.nl>
References: <1264811216-25989-1-git-send-email-khilman@deeprootsystems.com> <4B6392DD.20207@ti.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:34789 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab0A3KZw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Jan 2010 05:25:52 -0500
In-Reply-To: <4B6392DD.20207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Op 30 jan 2010, om 03:01 heeft Nishanth Menon het volgende geschreven:

> Kevin Hilman had written, on 01/29/2010 06:26 PM, the following:
>> Update omap3_defconfig to work towards a minimal kernel by building
>> most things as modules.  Some drivers that cannot currently be built
>> as modules and need to be fixed:
>> - MMC: platform code uses MMC core regulator functions directly
>> - ASoC: drivers call omap_ctrl_[read|write] directly
>> In addition some additional changes:
>> - use new SLUB allocator instead of SLAB (increased debugability)
>> - compile with PREEMPT enabled by default
>> - disable OABI_COMPAT.  We should not pretend to support this IMHO
> Curious: Does'nt most of busybox build's fail to boot without this?

All the busybox builds I did for the past 3 (maybe 4) years have been EABI. People tracking a git kernel should just "get with the program" I guess :) And let's not forget that due to the ABI differences things like alsa don't work properly with EABI kernel + OABI rootfs.
Enabling the OABI compat also introduces a bit of overhead when used with a pure EABI rootfs.

regards,

Koen