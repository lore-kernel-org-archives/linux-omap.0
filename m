From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: multiple linux-next OMAP3 build errors
Date: Mon, 04 Oct 2010 09:29:07 +0300
Message-ID: <1286173747.2358.4.camel@tubuntu.research.nokia.com>
References: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:33072 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab0JDG3Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 02:29:25 -0400
In-Reply-To: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: benh@kernel.crashing.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, ext Grazvydas Ignotas <notasas@gmail.com>

Hi,

On Fri, 2010-10-01 at 17:57 +0200, ext Grazvydas Ignotas wrote:
> hi,
> 
> I've been building linux-next for a while now and keep getting these
> build errors, just posting them here in case not all are known. Not
> familiar enough with that code to send patches unfortunately.

>   CC      drivers/video/omap2/vram.o
> drivers/video/omap2/vram.c: In function 'omap_vram_reserve_sdram_memblock':
> drivers/video/omap2/vram.c:568: error: implicit declaration of
> function 'memblock_region_is_memory'

Benjamin, your patch "memblock/arm: Use memblock_region_is_memory() for
omap fb" in linux-next seems to be broken. I believe the called function
should be memblock_is_region_memory, not memblock_region_is_memory?

 Tomi


