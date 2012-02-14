From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: usb-host: fix compile warning
Date: Tue, 14 Feb 2012 11:47:21 -0800
Message-ID: <20120214194721.GR1426@atomide.com>
References: <1329209686-25551-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56184 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757036Ab2BNTrY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 14:47:24 -0500
Content-Disposition: inline
In-Reply-To: <1329209686-25551-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Felipe Balbi <balbi@ti.com> [120214 00:23]:
> when commit 3528c58 (OMAP: omap_device: when
> building return platform_device instead of
> omap_device) started returning a platform_device
> instead of a omap_device pointer when building
> a device, it failed to convert all users introducing
> a compile warning when building
> arch/arm/mach-omap2/usb-host.c.
> 
> This patch fixes that warning.

Thanks applying into fixes.

Tony
