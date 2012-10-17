From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
Date: Wed, 17 Oct 2012 13:34:04 -0700
Message-ID: <20121017203404.GY15569@atomide.com>
References: <20121016230040.GP15569@atomide.com>
 <1350488838-6289-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59477 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755839Ab2JQUeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 16:34:07 -0400
Content-Disposition: inline
In-Reply-To: <1350488838-6289-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [121017 08:54]:
> In order to make single zImage work for ARM architecture,
> we need to make sure we don't depend on private headers.
> 
> Move USB platform_data to <linux/platform_data/omap-usb.h>
> and keep only internal functions in <plat/usb.h>.

Thanks, looks like I can't make this apply against v3.7-rc1:

patching file arch/arm/plat-omap/include/plat/usb.h
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 26.
Hunk #3 FAILED at 44.
Hunk #4 FAILED at 65.
Hunk #5 FAILED at 81.
Hunk #6 succeeded at 28 with fuzz 2 (offset -128 lines).
5 out of 6 hunks FAILED -- rejects in file arch/arm/plat-omap/include/plat/usb.h

Can you please check it?

Regards,

Tony
