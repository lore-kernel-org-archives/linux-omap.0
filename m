From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: DSS2 broken with 36-rc1
Date: Wed, 25 Aug 2010 14:17:32 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6853FE5@dbde02.ent.ti.com>
References: <1281962906.1888.25.camel@chotu>
	 <4C72192A.9050801@compulab.co.il>  <4C721DFA.9010009@compulab.co.il>
 <1282723542.9299.87.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47291 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618Ab0HYIro convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 04:47:44 -0400
In-Reply-To: <1282723542.9299.87.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, ext Mike Rapoport <mike@compulab.co.il>
Cc: "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tomi Valkeinen
> Sent: Wednesday, August 25, 2010 1:36 PM
> To: ext Mike Rapoport
> Cc: Palande Ameya (Nokia-MS/Helsinki); linux-omap
> Subject: Re: DSS2 broken with 36-rc1
> 
> Hi,
> 
> On Mon, 2010-08-23 at 09:06 +0200, ext Mike Rapoport wrote:
> > Mike Rapoport wrote:
> 
> >  From 81e9278ad27bc91be42105321e0e26d0be9e883b Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <mike@compulab.co.il>
> > Date: Mon, 23 Aug 2010 09:40:09 +0300
> > Subject: [PATCH] OMAP: DSS2: OMAPFB: use phys_to_virt for RAM mappings
> >
> > After commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8 (ARM: Prohibit
> > ioremap() on kernel managed RAM) it is impossible to ioremap SDRAM for
> > the framebuffer. Use phys_to_virt for kernel managed RAM mapping and
> > ioremap for other memory types
> 
> Hmm. omapfb reserves/allocates the ram using memblock, and obviously
> memory from memblock is "kernel managed RAM". What does it mean? The RAM
> is already mapped? I guess so, if phys_to_virt() works. (I guess the
> whole RAM is mapped automatically). With what caching? How can we get
> writecombining for this memory?
> 
> Looking at the description of "ARM: Prohibit ioremap() on kernel managed
> RAM" it sounds to me that we cannot have writecombining for framebuffer
> memory, if it's "kernel managed RAM".
> 
This is indeed the case. One way to get write combining memory is to
use dma_alloc_coherent in kernel space. 
You can reserve some memory outside the kernel memory map and directly
mmap it to users pace with whatever attributes you interested in.

Regards,
Santosh
