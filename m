From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5 0/12] dmtimer adaptation to platform_driver
Date: Mon, 6 Dec 2010 21:58:52 +0530
Message-ID: <20101206162852.GA4924@manju-desktop>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:57945 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752050Ab0LFQ3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 11:29:11 -0500
Received: by mail-gx0-f180.google.com with SMTP id 19so8093025gxk.25
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 08:29:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Dec 07, 2010 at 05:14:07AM +0530, Tarun Kanti DebBarma wrote:
> dmtimer adaptation to platform_driver.
> 
> This patch series is adaptation of dmtimer code to platform driver
> using omap_device and omap_hwmod abstraction.
> 
> Tested on following platforms:
> OMAP4430, OMAP3430, OMAP3630, OMAP2430
> OMAP2420 -- Image with omap2plus_defconfig in too large to download on N800.

How about omap1? The mainline code happily compiles and boots on osk5912
but this series is going to break omap1 build.

As per Tony's comments for GPIO and DMA hwmod, the changes should build and
boot for omap1 also.

-Manjunath

[...]
