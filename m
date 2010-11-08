From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/2] video: omap: vram: remove from normal memory
Date: Mon, 08 Nov 2010 13:40:55 +0200
Message-ID: <1289216455.3297.29.camel@tubuntu>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	 <1287146784-5517-1-git-send-email-felipe.contreras@gmail.com>
	 <1287407452.6781.64.camel@tubuntu>	<1287410618.6781.110.camel@tubuntu>
	 <20101018225534.GH13341@atomide.com>	<1287489785.2216.10.camel@tubuntu>
	 <AANLkTin+0B1GbiJkf9X88-08Yc6LROSorPyCyydvCtkK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:50016 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754492Ab0KHLkV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 06:40:21 -0500
In-Reply-To: <AANLkTin+0B1GbiJkf9X88-08Yc6LROSorPyCyydvCtkK@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Contreras <felipe.contreras@gmail.com>, Namhyung Kim <namhyung@gmail.com>
Cc: ext Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, Russell King <linux@arm.linux.org.uk>, "mike@compulab.co.il" <mike@compulab.co.il>

Hi,

On Sun, 2010-11-07 at 23:49 +0100, ext Felipe Contreras wrote:
> On Tue, Oct 19, 2010 at 3:03 PM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:

> > Yes, I can queue them (when the required memblock stuff is in).
> 
> Now it's in :) (v2.6.37-rc1)

I pushed vram patches to my DSS tree.

I combined the patches from Felipe and Namhyung with some changes: 1)
use memblock_alloc instead of memblock_alloc_base, and 2) use
memblock_free and memblock_remove for both reserved and allocated
memory. I hope this is ok for Felipe and Namhyung?

I think there was also a bug in memblock_is_region_memory(), for which I
sent a patch to memblock people. It's also in my tree.

Works for me on 3430SDP board, for both reserved and allocated vram, and
memblock and vram debug output looks sane.

 Tomi


