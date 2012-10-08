From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/16] More omap plat header cleanup for v3.8 merge window
Date: Mon, 8 Oct 2012 14:22:49 +0530
Message-ID: <50729461.8090504@ti.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab2JHIw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 04:52:59 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony,

On Friday 05 October 2012 03:34 AM, Tony Lindgren wrote:
> Hi all,
>
> Here are some more patches for early merging after -rc1 for v3.8
> merge window to remove more plat includes for the ARM common
> zImage support. These are based on top of current linux next +
> kevin's cpufreq fixes.
>
Have scanned the series and movement looks fine. For the SRAM movement,
I just wanted to to check if the builds are fine with errata WA enabled
for OMAP4. Do you have a branch where you are stacking up these patches?

Regards
santosh
