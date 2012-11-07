From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP4/Panda: u-boot upgrade v2012.04.01 -> v2012.10 breaks RTC wakeups
Date: Wed, 07 Nov 2012 07:21:20 -0800
Message-ID: <87390l8mmn.fsf@deeprootsystems.com>
References: <87obja9r3x.fsf@deeprootsystems.com> <5099B0FB.3060203@ti.com>
	<5099F3BA.6090302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41902 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab2KGPVW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 10:21:22 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so1278266pbb.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Nov 2012 07:21:22 -0800 (PST)
In-Reply-To: <5099F3BA.6090302@ti.com> (R. Sricharan's message of "Wed, 7 Nov
	2012 11:08:02 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, u-boot@lists.denx.de, linux-omap <linux-omap@vger.kernel.org>, trini@ti.com

Hi Sricharan,

R Sricharan <r.sricharan@ti.com> writes:

>  In the latest, pad mux and clocks for all
>  non-essential modules at U-BOOT were removed.
>
>  This might also cause the problem.
>  We can bring this back in u-boot by adding the following macros
>  and check if it works fine again.
>
>   include/configs/omap4_common.h
>   ------------------------------
>   #define CONFIG_SYS_ENABLE_PADS_ALL
>   #define CONFIG_SYS_CLOCKS_ENABLE_ALL

Thanks for the pointer, that got things working again.  It's actually
CONFIG_SYS_ENABLE_PADS_ALL alone which got things working again.

I'm glad to see u-boot going in this direction.  In the kernel, we've
also been trying to get rid of bootloader dependencies also, but it's
clear we haven't got all of them yet.

I'll keep digging to see what's missing in the kernel pads setup to get
RTC working again.

Kevin


