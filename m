From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH] omap: 3630: update is_chip variable
Date: Mon, 2 Nov 2009 20:28:31 +0200
Message-ID: <20091102182831.GD15200@shisha.kicks-ass.net>
References: <1255989491-27088-1-git-send-email-vikram.pandita@ti.com>
 <71a0d6ff0911020905u7879b332x53d01f43b5888307@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.welho.com ([213.243.153.38]:45585 "EHLO smtp4.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756224AbZKBSkG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Nov 2009 13:40:06 -0500
Content-Disposition: inline
In-Reply-To: <71a0d6ff0911020905u7879b332x53d01f43b5888307@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

On Mon, Nov 02, 2009 at 07:05:49PM +0200, Alexander Shishkin wrote:
> 2009/10/20 Vikram Pandita <vikram.pandita@ti.com>:
> > 3630 is getting treated like next rev of 3430
> > omap_chip.oc variable has to be updated for 3630 version
> >
> > Otherwise the Core power domain is not getting registered.
> >
> > This gets used in the registration of power domains in:
> > "arch/arm/mach-omap2/powerdomains34xx.h"
> > core_34xx_es3_1_pwrdm
> > OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1)
> >
> > Core power doman will get registered for 3630 only when .oc is pouplated
> > correctly.
> >
> > Tested on Zoom3(3630) board
> >
> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> FWIW,
> 
> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>

Please excuse me, I obviously wanted to say

Acked-by: Alexander Shishkin <virtuoso@slind.org>

Regards,
--
Alex
