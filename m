From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2 04/14] ARM: OMAP: Fix timer posted mode support
Date: Wed, 7 Nov 2012 16:21:07 -0600
Message-ID: <509ADED3.1050901@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com> <1352314890-22224-5-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45994 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688Ab2KGWVK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 17:21:10 -0500
In-Reply-To: <1352314890-22224-5-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wednesday 07 November 2012 01:01 PM, Jon Hunter wrote:
> Currently the dmtimer posted mode is being enabled when the function
> omap_dm_timer_enable_posted() is called. This function is only being called
> for OMAP1 timers and OMAP2+ timers that are being used as system timers. Hence,
> for OMAP2+ timers that are NOT being used as a system timer, posted mode is
> not enabled but the "timer->posted" variable is still set (incorrectly) in
> the omap_dm_timer_prepare() function.
>
> This is a regression introduced by commit 3392cdd3 (ARM: OMAP: dmtimer:
> switch-over to platform device driver) which was before the
> omap_dm_timer_enable_posted() function was introduced. Although this is a
> regression from the original code it only impacts performance and so is not
> needed for stable.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

