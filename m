From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: Fix build failure on MEMBLOCK_REAL_LIMIT
Date: Tue, 02 Nov 2010 11:43:02 +0200
Message-ID: <1288690982.5614.78.camel@tubuntu>
References: <1288629008-29767-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:33575 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab0KBJmb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Nov 2010 05:42:31 -0400
In-Reply-To: <1288629008-29767-1-git-send-email-namhyung@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Namhyung Kim <namhyung@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2010-11-01 at 17:30 +0100, ext Namhyung Kim wrote:
> The MEMBLOCK_REAL_LIMIT symbol was removed by the commit e63075a3c937
> (memblock: Introduce default allocation limit and use it to replace
> explicit ones) so it breaks beagle board build as follows:
> 
>   CC      drivers/video/omap2/vram.o
> drivers/video/omap2/vram.c: In function 'omap_vram_reserve_sdram_memblock':
> drivers/video/omap2/vram.c:573: error: 'MEMBLOCK_REAL_LIMIT' undeclared (first use in this function)
> drivers/video/omap2/vram.c:573: error: (Each undeclared identifier is reported only once
> drivers/video/omap2/vram.c:573: error: for each function it appears in.)
> make[5]: *** [drivers/video/omap2/vram.o] Error 1
> make[4]: *** [drivers/video/omap2] Error 2
> make[3]: *** [drivers/video] Error 2
> make[2]: *** [drivers] Error 2
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2

Thanks, applied to my tree.

 Tomi


