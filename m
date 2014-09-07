From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 2/3] nand: omap2: Remove horrible ifdefs to fix module
 probe
Date: Sun, 7 Sep 2014 12:16:56 -0300
Message-ID: <20140907151656.GA1048@arch.cereza>
References: <1410033389-32357-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1410033389-32357-3-git-send-email-ezequiel@vanguardiasur.com.ar>
 <540B785C.3070400@pek-sem.com>
 <20140906231728.GA4663@arch.cereza>
 <540C26F7.7020005@pek-sem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:53440 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaIGPSI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2014 11:18:08 -0400
Received: by mail-qg0-f46.google.com with SMTP id q107so4434044qgd.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Sep 2014 08:18:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <540C26F7.7020005@pek-sem.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pekon <pekon@pek-sem.com>
Cc: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, linux-omap <linux-omap@vger.kernel.org>

On 07 Sep 03:05 PM, pekon wrote:
[..]
> As ECC-scheme is selected in GPMC driver based on DTS settings, so
> any mis-match is easily handled there.
> Moreover, error will occur when we change ECC-scheme on-the-fly,
> which is still not supported by framework, and require many other
> updates if we plan to support that in near future.
> So considering ECC-scheme as static configuration is a safe assumption.
> 
> But surely you can drop new check in omap2_nand_ecc_check(), which
> is already covered in @@gpmc_probe_nand_child(...)
> 
> However, I leave it to you and rogerq@ti.com (as he currently
> maintains OMAP NAND driver from TI side) to decide how to go about it.
> 

As far as I can see, your proposal only cover the devicetree-probed case
and it won't work for legacy boards.

Given it seems we still support legacy, I'd say your proposal would break
things.

Not to mention that I still prefer to fail at probe time if the driver cannot
deal with the selected ECC, and that's exactly what  omap2_nand_ecc_check()
does.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
