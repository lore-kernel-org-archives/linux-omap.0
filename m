From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod
 dependency
Date: Tue, 19 Feb 2013 15:30:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com> <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com> <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com> <20130214224710.GF11362@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56980 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933036Ab3BSPaC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 10:30:02 -0500
In-Reply-To: <20130214224710.GF11362@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, 14 Feb 2013, Tony Lindgren wrote:

> The other option could be to allow custom ioremap function pointers 
> based on address range in __arm_ioremap_pfn_caller() the same way as
> the SoC specific static mappings are allowed. That would require adding
> a function pointer to struct map_desc.
> 
> Maybe that would do the trick?

That sounds fine to me too.

To me it makes sense to eventually handle the I/O mappings automatically 
from data in the DT -- hence the association with a bus device, which 
should be present in DT data.


- Paul

