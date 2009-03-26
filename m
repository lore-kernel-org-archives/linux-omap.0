From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Problems bringing up new PM 2.6.29 tree on Logic 35x LV SOM
Date: Thu, 26 Mar 2009 15:13:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903261500350.12079@utopia.booyaka.com>
References: <1238099752.8002.84.camel@blackhole>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39222 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbZCZVNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2009 17:13:33 -0400
In-Reply-To: <1238099752.8002.84.camel@blackhole>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Thu, 26 Mar 2009, Peter Barada wrote:

> I changed the call to omap_init_common_hw to pass in four NULLs (as I
> think the sdrc params for mt46h32m32lf6 (somehow?) don't match the
> mt29c2g24maklajg-75 used on our board. 
                   ^^

This is why you can't use the MT46H32M32LF-6 parameters.  The -75 part is 
slower.  You'll need to plug in the -75 timings from the Micron datasheet 
1gb_ddr_mobile_sdram_t48m.pdf into calc-sdrc-params.c.  Using those 
values, create a new file, sdram-micron-mt46h32m32lf-75.h, for that part, 
and pass in the new SDRAM register structure via omap_init_common_hw() in 
your board-*.c file.


- Paul
