From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix selection of clockevent timer when using
 device-tree
Date: Wed, 30 Jan 2013 11:24:32 +0530
Message-ID: <5108B598.6080401@ti.com>
References: <1359490991-17688-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34710 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3A3FxX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jan 2013 00:53:23 -0500
In-Reply-To: <1359490991-17688-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wednesday 30 January 2013 01:53 AM, Jon Hunter wrote:
> Commit 9725f44 (ARM: OMAP: Add DT support for timer driver) added
> device-tree support for selecting a clockevent timer by property.
> However, the code is currently ignoring the property passed and
> selecting the first available timer found. Hence, for the OMAP3 beagle
> board timer-12 is not being selected as expected. Fix this problem
> by ensuring the timer property is passed to omap_get_timer_dt().
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

