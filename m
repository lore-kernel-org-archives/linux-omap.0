From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: multiple linux-next OMAP3 build errors
Date: Tue, 05 Oct 2010 09:30:22 +1100
Message-ID: <1286231422.2463.316.camel@pasglop>
References: <AANLkTim9v1Y2o9QebYcJkh+QLVQq9fFOFE5P+OoyUHXa@mail.gmail.com>
	 <1286173747.2358.4.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54369 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756175Ab0JDWbQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Oct 2010 18:31:16 -0400
In-Reply-To: <1286173747.2358.4.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, yinghai@kernel.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, ext Grazvydas Ignotas <notasas@gmail.com>, Ingo Molnar <mingo@elte.hu>

On Mon, 2010-10-04 at 09:29 +0300, Tomi Valkeinen wrote:
> >   CC      drivers/video/omap2/vram.o
> > drivers/video/omap2/vram.c: In function
> 'omap_vram_reserve_sdram_memblock':
> > drivers/video/omap2/vram.c:568: error: implicit declaration of
> > function 'memblock_region_is_memory'
> 
> Benjamin, your patch "memblock/arm: Use memblock_region_is_memory()
> for
> omap fb" in linux-next seems to be broken. I believe the called
> function
> should be memblock_is_region_memory, not memblock_region_is_memory?

I suspect either I didn't push my latest version before it got merged or
Yinghai didn't pull the right one, since I'm pretty sure I test built
it, but in any case, you're probably right :-)

I'm not in control of this patch series at the moment however. Ingo and
Yinghai are. Yinghai, care to fix that up ? I'm currently travelling on
holidays and won't be able to do much until later next week.

Cheers,
Ben.



