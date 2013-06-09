From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: AM33xx: Add missing reset status info to
 GFX hwmod
Date: Sun, 9 Jun 2013 07:14:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306090714080.20050@utopia.booyaka.com>
References: <1367693284-7870-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53188 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab3FIHOT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Jun 2013 03:14:19 -0400
In-Reply-To: <1367693284-7870-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Sun, 5 May 2013, Vaibhav Hiremath wrote:

> GFX has a reset status register (PRM_GFX.RM_GFX_RSTST),
> so update the GFX hwmod data with .rstst_off and .st_shift
> information.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, queued.

- Paul
