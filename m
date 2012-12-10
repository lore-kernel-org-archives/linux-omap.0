From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 0/9] memory: emif: miscellaneous bug fixes for EMIF driver
Date: Mon, 10 Dec 2012 12:42:27 +0530
Message-ID: <50C58B5B.4030606@ti.com>
References: <1355123324-5228-1-git-send-email-a>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45250 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910Ab2LJHMe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 02:12:34 -0500
In-Reply-To: <1355123324-5228-1-git-send-email-a>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, gregkh@linuxfoundation.org, b-cousson@ti.com

Sorry to Spam you in-box.
Please discard this message...

Thanks
Lokesh

On Monday 10 December 2012 12:38 PM, a@dbdp33.itg.ti.com wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
>
> This series resolves a few minor issues for EMIF driver.
>
> Tested all the patches on OMAP4-sdp, OMAP5-sevm.
> Patch : "memory: emif: setup LP settings on freq update"
> is tested on a local tree, since freq update cannot be
> tested on mainline.
>
> Ambresh K (1):
>    memory: emif: use default custom config parameter.
>
> Lokesh Vutla (1):
>    memory: emif: Correct the lpmode timeout calculation
>
> Nishanth Menon (5):
>    memory: emif: setup LP settings on freq update
>    memory: emif: handle overflow for timing for LP mode
>    memory: emif: Handle devices which are not rated for >85C
>    memory: emif: use restart if power_off not present when out of spec
>    memory: emif: disable phy_fast_dll_lock
>
> Oleksandr Dmytryshyn (1):
>    memory: emif: fix timings initialization issue
>
> Severine Glock (1):
>    memory: emif: debugfs: Remove MR4= string print
>
>   drivers/memory/emif.c                   |   92 +++++++++++++++++++++++++------
>   drivers/memory/emif.h                   |    2 +-
>   include/linux/platform_data/emif_plat.h |    1 +
>   3 files changed, 78 insertions(+), 17 deletions(-)
>

