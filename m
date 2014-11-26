From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Tue, 25 Nov 2014 22:47:09 -0800
Message-ID: <20141126064709.GI3212@norris-Latitude-E6410>
References: <1415185258-11747-1-git-send-email-rogerq@ti.com>
 <546C8B7F.6030600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:58438 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaKZGrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 01:47:25 -0500
Received: by mail-pd0-f175.google.com with SMTP id y10so2196988pdj.34
        for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2014 22:47:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <546C8B7F.6030600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: dwmw2@infradead.org, tony@atomide.com, ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, pekon@pek-sem.com, "Rini, Tom" <trini@ti.com>

On Wed, Nov 19, 2014 at 02:22:23PM +0200, Roger Quadros wrote:
> 3430LDP has NAND flash with 32 bytes OOB size which is sufficient to hold
> BCH8 codes but the small page check introduced in
> commit b491da7233d5 ("mtd: nand: omap: clean-up ecc layout for BCH ecc schemes")
> considers anything below 64 bytes unsuitable for BCH4/8/16. There is another
> bug in that code where it doesn't skip the check for OMAP_ECC_HAM1_CODE_SW.
> 
> Get rid of that small page check code as it is insufficient and redundant
> because we are checking for OOB available bytes vs ecc layout before calling
> nand_scan_tail().
> 
> Fixes: b491da7233d5 ("mtd: nand: omap: clean-up ecc layout for BCH ecc schemes")
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Applied to l2-mtd.git.

Brian
