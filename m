From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 broken with 36-rc1
Date: Mon, 23 Aug 2010 10:35:30 +0300
Message-ID: <1282548930.2202.16.camel@tubuntu.research.nokia.com>
References: <1281962906.1888.25.camel@chotu>
	 <4C72192A.9050801@compulab.co.il>
	 <1282547709.2202.1.camel@tubuntu.research.nokia.com>
	 <4C722115.50401@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58472 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab0HWHgB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 03:36:01 -0400
In-Reply-To: <4C722115.50401@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Rapoport <mike@compulab.co.il>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Mon, 2010-08-23 at 09:19 +0200, ext Mike Rapoport wrote:
> Tomi Valkeinen wrote:
> > 
> > I tested 36-rc1 briefly with OMAP 3430SDP board. I wonder why that
> > works, but not N900...
> 
> May it be that 3430SDP uses SRAM for the framebuffer? Or reserves framebuffer 
> memory from the RAM that is not managed by the kernel, e.g with something like
> mem=<RAM size - fb size> vram=<fb size>,0x8...... ?

No, SRAM cannot be used on OMAP3s, as SRAM is too small to hold a
framebuffer. And no, I don't think it's reserving it from RAM not
managed by the kernel.

What is actually failing there? Looking at Ameya's original post, the
problem is in allocating the framebuffer. Your patch is doing something
_after_ the allocation has failed, so I don't see Ameya's problem having
anything to do with ioremap.

Ameya, you could try turning on the debugs in
drivers/video/omap2/vram.c, and checking what it says. Or see what is in
debugfs/vram file

 Tomi


