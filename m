From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: Bridge issue #3! dma_alloc_coherent causing crash - pm branch
Date: Fri, 13 Mar 2009 15:18:12 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8FD10D6@dbde02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF51E3F6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33781 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757412AbZCMJtD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 05:49:03 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF51E3F6@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,
 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, March 13, 2009 1:35 PM
> To: Kevin Hilman
> Cc: linux-omap@vger.kernel.org; Gupta, Ramesh
> Subject: RE: Bridge issue #3! dma_alloc_coherent causing 
> crash - pm branch
> 
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > Sent: Friday, March 13, 2009 2:35 AM
> 
> 
> > Sounds like a memory leak in the bridge driver to me.  I 
> suggest you 
> > enable memory leak debugging.  In Kconfig
> > 
> >    Kernel Hacking -->  Kernel debugging
> > 
> > Enable 'Debug slab memory allocations' and its child 'Memory leak 
> > debugging'.
> > 
> > Or, you could switch to the SLUB allocator which has some more 
> > flexible debug options which can be controlled at boot-time 
> from the cmdline.
> > 
> > While you are in the Kernel debugging menu, make sure you enable 
> > 'Verbose BUG()' and 'Verbose kernel errors'.  This will ensure that 
> > any memory leaks will be dumped with some extra debug output.

I enabled all the above options, do I need to add some boot options to enable 
Debug messages? I am not seeing any debug information displayed in the cosole by default.
Looks like I am mising some thing :( . Any comments?

Thanks
Ramesh Gupta G
