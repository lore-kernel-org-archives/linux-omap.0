From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 0/6] omap3: pm: Update TRITON power scripts and making it generic
Date: Thu, 21 Jan 2010 13:19:10 -0800
Message-ID: <873a1z17ht.fsf@deeprootsystems.com>
References: <1263922193-13468-1-git-send-email-x0080970@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f196.google.com ([209.85.223.196]:36167 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab0AUVTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 16:19:13 -0500
Received: by iwn34 with SMTP id 34so396702iwn.21
        for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 13:19:12 -0800 (PST)
In-Reply-To: <1263922193-13468-1-git-send-email-x0080970@ti.com> (Lesly A. M.'s message of "Tue\, 19 Jan 2010 22\:59\:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <x0080970@ti.com>
Cc: linux-omap@vger.kernel.org

Lesly A M <x0080970@ti.com> writes:

> map3: pm: Update TRITON power scripts and making it generic
>
> This series of patch implements a updated TRITON power scripts.
> Also moving the sleep, wakeup & warm_reset sequence to a generic script file,
> which can be used by different OMAP3 board with the power companion chip TWL4030.
>
> V1: Initial Patch Series
>
> V2: Incorporated comments
>
>  arch/arm/mach-omap2/Makefile                  |   12 ++-
>  arch/arm/mach-omap2/board-3430sdp.c           |  124 ++++++++-----------------
>  arch/arm/mach-omap2/board-3630sdp.c           |   25 +++++-
>  arch/arm/mach-omap2/board-zoom-peripherals.c  |   43 +++++++++-
>  arch/arm/mach-omap2/board-zoom2.c             |   25 +++++-
>  arch/arm/mach-omap2/board-zoom3.c             |   25 +++++-
>  arch/arm/mach-omap2/include/mach/board-zoom.h |    2 +-
>  arch/arm/mach-omap2/pm.h                      |   11 ++-
>  arch/arm/mach-omap2/pm34xx.c                  |   60 ++++++++++--
>  drivers/mfd/twl4030-power.c                   |   30 +++++--
>  include/linux/i2c/twl.h                       |    4 +
>  11 files changed, 245 insertions(+), 116 deletions(-)
>
>
> Tested on top of Kevins PM branch commit id:
> ad4776c4207a376961372752fe0a0ae3814990b3

Lesly,

Could you also report what platforms this was tested on, and what
exactly was tested?  RET, OFF in suspend?  RET & OFF while idle? etc.

Thanks,

Kevin

