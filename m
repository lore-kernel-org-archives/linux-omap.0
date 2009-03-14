From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: Bridge issue #3! dma_alloc_coherent causing crash - pm branch
Date: Sat, 14 Mar 2009 09:56:12 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02A8FD141D@dbde02.ent.ti.com>
References: <87sklh1ki5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48851 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbZCNE1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Mar 2009 00:27:07 -0400
In-Reply-To: <87sklh1ki5.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,

> >
> > I enabled all the above options, do I need to add some boot 
> options to 
> > enable Debug messages? I am not seeing any debug 
> information displayed in the cosole by default.
> > Looks like I am mising some thing :( . Any comments?
> >
> 
> You'll only see extra messages when the kerel hits a BUG() or 
> a WARN().  If you don't see anything more verbose with all 
> these options enabled, then the kernel is not detecting any problems.

Thank you.

Regards
Ramesh