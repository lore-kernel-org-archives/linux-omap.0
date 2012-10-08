From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/16] More omap plat header cleanup for v3.8 merge window
Date: Mon, 8 Oct 2012 14:54:13 +0530
Message-ID: <50729BBD.2070009@ti.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local> <50729461.8090504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39559 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab2JHJYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Oct 2012 05:24:20 -0400
In-Reply-To: <50729461.8090504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 08 October 2012 02:22 PM, Santosh Shilimkar wrote:
> Tony,
>
> On Friday 05 October 2012 03:34 AM, Tony Lindgren wrote:
>> Hi all,
>>
>> Here are some more patches for early merging after -rc1 for v3.8
>> merge window to remove more plat includes for the ARM common
>> zImage support. These are based on top of current linux next +
>> kevin's cpufreq fixes.
>>
> Have scanned the series and movement looks fine. For the SRAM movement,
> I just wanted to to check if the builds are fine with errata WA enabled
> for OMAP4. Do you have a branch where you are stacking up these patches?
>
Found the branch 'tmp-testing-header-cleanup' which had these patches.
Did few build test along with the errata related build. No issues seen.

Feel free to add my ack for the series.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
