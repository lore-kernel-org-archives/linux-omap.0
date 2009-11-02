From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH] omap: 3630: update is_chip variable
Date: Mon, 2 Nov 2009 19:05:49 +0200
Message-ID: <71a0d6ff0911020905u7879b332x53d01f43b5888307@mail.gmail.com>
References: <1255989491-27088-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:7942 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458AbZKBRFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 12:05:46 -0500
Received: by ey-out-2122.google.com with SMTP id d26so440820eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2009 09:05:50 -0800 (PST)
In-Reply-To: <1255989491-27088-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

2009/10/20 Vikram Pandita <vikram.pandita@ti.com>:
> 3630 is getting treated like next rev of 3430
> omap_chip.oc variable has to be updated for 3630 version
>
> Otherwise the Core power domain is not getting registered.
>
> This gets used in the registration of power domains in:
> "arch/arm/mach-omap2/powerdomains34xx.h"
> core_34xx_es3_1_pwrdm
> OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1)
>
> Core power doman will get registered for 3630 only when .oc is pouplated
> correctly.
>
> Tested on Zoom3(3630) board
>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
FWIW,

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>

This version seems to be the common consensus (per discussion in v2 thread).

Regards,
--
Alex
