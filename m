From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: DRA7: hwmod: fix gpmc hwmod
Date: Tue, 2 Jun 2015 21:34:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1506022134480.14902@utopia.booyaka.com>
References: <1433239373-14653-1-git-send-email-rogerq@ti.com> <1433239373-14653-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43973 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbbFBVe7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 17:34:59 -0400
In-Reply-To: <1433239373-14653-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org

On Tue, 2 Jun 2015, Roger Quadros wrote:

> GPMC smart idle is not really broken but it does not support
> smart idle with wakeup.
> 
> Fixes: 556708fe8718 ("ARM: OMAP: DRA7: hwmod: Make gpmc software supervised as the smart idle is broken")
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Thanks, queued for v4.2-rc fixes.

- Paul
