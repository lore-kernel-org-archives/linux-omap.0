From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: HWMOD: Add support for early device register into
 omap device layer
Date: Mon, 8 Feb 2010 21:05:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002082105200.22923@utopia.booyaka.com>
References: <1265685422-14351-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49781 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab0BIEFh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 23:05:37 -0500
In-Reply-To: <1265685422-14351-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 9 Feb 2010, Thara Gopinath wrote:

> This patch adds support in omap device layer to register devices
> as early platform devices. Certain devices needed during system boot up
> like timers, gpio etc can be registered as early devices. This will
> allow for them to be probed very early on during system boot up.
> This patch adds a parameter is_early_device in omap_device_build.
> Depending on this parameter a call to early_platform_add_devices
> or platform_register_device is made.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>

Thanks Thara, queued for 2.6.34.


- Paul
