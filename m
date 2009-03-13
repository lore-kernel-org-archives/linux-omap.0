From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: Bridge issue #3! dma_alloc_coherent causing crash - pm branch
Date: Fri, 13 Mar 2009 03:04:45 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF51E3F6@dlee02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF51E360@dlee02.ent.ti.com>
 <874oxy2rbv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56461 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbZCMIE4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 04:04:56 -0400
In-Reply-To: <874oxy2rbv.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, March 13, 2009 2:35 AM


> Sounds like a memory leak in the bridge driver to me.  I suggest you
> enable memory leak debugging.  In Kconfig
> 
>    Kernel Hacking -->  Kernel debugging
> 
> Enable 'Debug slab memory allocations' and its child 'Memory leak
> debugging'.
> 
> Or, you could switch to the SLUB allocator which has some more flexible
> debug options which can be controlled at boot-time from the cmdline.
> 
> While you are in the Kernel debugging menu, make sure you enable
> 'Verbose BUG()' and 'Verbose kernel errors'.  This will ensure that
> any memory leaks will be dumped with some extra debug output.

Thanks. Yep, it does sound like a mem leak... will keep the list posted as we progress.

Regards,
Nishanth Menon
