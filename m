From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: mmc: remove ifdef in omap_mmc_platform_data
 defination
Date: Mon, 4 Oct 2010 10:09:34 -0700
Message-ID: <20101004170934.GU3117@atomide.com>
References: <1286211201-31168-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61667 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486Ab0JDRJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 13:09:33 -0400
Content-Disposition: inline
In-Reply-To: <1286211201-31168-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org

* tom.leiming@gmail.com <tom.leiming@gmail.com> [101004 09:45]:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> The instance of omap_mmc_platform_data is alwasy passed to
> mmc omap host driver from board, so remove ifdef in omap_mmc_platform_data
> defination to simplify handling it in mmc omap host driver.
 
OK, let's do this. Eventually we can convert omap1/2420 MMC controller
to use caps also.

> The patch fixes the compile error below:
> 
> drivers/mmc/host/omap.c: In function 'mmc_omap_new_slot':
> drivers/mmc/host/omap.c:1320: error: 'struct omap_mmc_slot_data' has no member named 'wires'
> make[3]: *** [drivers/mmc/host/omap.o] Error 1
> make[2]: *** [drivers/mmc/host] Error 2
> make[1]: *** [drivers/mmc] Error 2
> make: *** [drivers] Error 2

I'll merge this into the earlier patch "omap: Keep nwires for omap1
and 2420 MMC controller".

Regards,

Tony
