From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Date: Thu, 9 Jan 2014 08:31:16 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EDB1489@DBDE04.ent.ti.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
 <52CE5123.9050702@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com>
 <52CE5D6F.3050700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36901 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398AbaAIIbp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jan 2014 03:31:45 -0500
In-Reply-To: <52CE5D6F.3050700@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Thursday, January 09, 2014 1:57 PM
> To: Hiremath, Vaibhav; Ivaylo Dimitrov; Ivaylo Dimitrov
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
> 
> On 2014-01-09 10:08, Hiremath, Vaibhav wrote:
> 
> > No, that's what is causing issue to me. Can you try predefined address flow?
> > Just to highlight, I get UNDERFLOW during boot itself, immediately when it
> gets mapped to userspace.
> >
> > Boot LOG:
> >
> 
> > [    4.822549] Freeing unused kernel memory: 440K (c0919000 - c0987000)
> > [    5.276615] OMAPFB: pan_display(0)
> > [    5.276625] OMAPFB: setcmap
> > [    5.276635] OMAPFB: setcmap
> > [    5.293518] OMAPFB: user mmap region start a0000000, len 1536000, off 0
> > [    5.300171] omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the
> overlay
> 
> Hmm that's interesting... So you have some tool that's ran early, which draws
> something on the screen? Or maybe that's X starting?
> 

It's initial demo, not sure whether you heard of MATRIX demo. I am running Matrix demo
As part of init script.

> Ah... I think I understand now. As I mentioned, AM4x has issues already.
> I think the CPU/others can block DSS when accessing memory. So, if we have
> bad caching for the mapped framebuffer, the CPU will use more bandwidth
> when reading/writing to it, and that will cause DSS to underflow.
> 

Yeah, AM4x already has some issues but I am comparing normal dma_alloc and reserved
Memory and I see different behavior and it could be due to bad caching for the mapped buffers.

Thanks,
Vaibhav
