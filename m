From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
Date: Thu, 10 Feb 2011 13:38:27 -0800
Message-ID: <87sjvvh8oc.fsf@ti.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<36192288611a2912eca9abc99a4353ff@mail.gmail.com>
	<AANLkTi=sPeQPfcGzrLSB=9-V805y6pnU4gA5QgqMSwWe@mail.gmail.com>
	<9ae36f6f04c9c1cf58fb4938dc78d6bf@mail.gmail.com>
	<AANLkTiknZ1VrA_OuqY=0AihNWiEdMkHA_zyVKQLg70+w@mail.gmail.com>
	<82c254dc5a3a4a405b25350e1ef3240e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:33822 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752507Ab1BJVid (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 16:38:33 -0500
Received: by mail-iw0-f172.google.com with SMTP id 10so1846634iwc.17
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 13:38:32 -0800 (PST)
In-Reply-To: <82c254dc5a3a4a405b25350e1ef3240e@mail.gmail.com> (Santosh
	Shilimkar's message of "Wed, 9 Feb 2011 11:15:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

[...]

>>
>> The SD card gets suspended, but nothing else seems to happen, and I
>> can't resume the system.
>>
>> Am I doing something wrong?
>>
> MMC suspend is broken. I use ramdisk-ext3 or NFS for my testing
>

Just to clarify, MMC suspend is not broken.  It's a "feature" the MMC
core.  See the help text of the following Kconfig option, and ensure
that it's enabled:


config MMC_UNSAFE_RESUME
	bool "Assume MMC/SD cards are non-removable (DANGEROUS)"
	help
	  If you say Y here, the MMC layer will assume that all cards
	  stayed in their respective slots during the suspend. The
	  normal behaviour is to remove them at suspend and
	  redetecting them at resume. Breaking this assumption will
	  in most cases result in data corruption.

	  This option is usually just for embedded systems which use
	  a MMC/SD card for rootfs. Most people should say N here.

	  This option sets a default which can be overridden by the
	  module parameter "removable=0" or "removable=1".

Looking at Dave's .config, this option is disabled, so suspend will hang
when rootfs is on MMC.

Kevin
