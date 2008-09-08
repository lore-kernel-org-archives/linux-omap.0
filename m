From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Mon, 8 Sep 2008 08:21:51 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE896716203655331A7@dlee02.ent.ti.com>
References: <20080906.035635.186133813.Hiroshi.DOYU@nokia.com>
	<20080907193619.GC10359@flint.arm.linux.org.uk>
	<13B9B4C6EF24D648824FF11BE89671620365533091@dlee02.ent.ti.com>
 <20080908.094729.236526510.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35314 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893AbYIHNWH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 09:22:07 -0400
In-Reply-To: <20080908.094729.236526510.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> > The usage in TI kernels has varied a bit.  Some times they are just
> > load and lock TLB's, for others table walking can be enabled.  In
> > all cases if a table walk miss happens it is fatal and the IP block
> > device will have to be reset.
>
> In *theory*, from this IOMMU hardware perspective, it's feasible to
> load something on memory dynamically("on-demand loading") when a table
> walk miss happens by notifying it to some memory manager through
> its assigned interrupt. Practically this latency may be a problem in
> some cases;)

I've been told explicitly by a few people that a table miss is fatal and the block needs to be reset to recover state.

I've not personally dug into TRM and underlying functional specs to validate this.  It might be different per IP.  Extreme case some kind of checkpoint would work ;)

In some discussions some people have even taken in table walk time as a consideration if certain camera streaming cases will work.  So, your comment about latency seems on.

Regards,
Richard W.

