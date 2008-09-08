From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Mon, 08 Sep 2008 09:47:29 +0300 (EEST)
Message-ID: <20080908.094729.236526510.Hiroshi.DOYU@nokia.com>
References: <20080906.035635.186133813.Hiroshi.DOYU@nokia.com>
	<20080907193619.GC10359@flint.arm.linux.org.uk>
	<13B9B4C6EF24D648824FF11BE89671620365533091@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32999 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYIHGsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 02:48:04 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620365533091@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r-woodruff2@ti.com
Cc: linux@arm.linux.org.uk, tony@atomide.com, linux-omap@vger.kernel.org

Hi Richard,

From: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Sun, 7 Sep 2008 21:04:56 -0500

> 
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> 
> > Well, the first question is... where has this come from, and why.
> 
> In OMAPs, a few devices have a local IO MMU.  Their basic structure
> is similar to an ARM MMU, but less featured. IVA & Camera have one
> each on 3430/2430, a 2420 has those before mentioned and + 3rd in
> its video accelerator.
> 
> The usage in TI kernels has varied a bit.  Some times they are just
> load and lock TLB's, for others table walking can be enabled.  In
> all cases if a table walk miss happens it is fatal and the IP block
> device will have to be reset.

In *theory*, from this IOMMU hardware perspective, it's feasible to
load something on memory dynamically("on-demand loading") when a table
walk miss happens by notifying it to some memory manager through
its assigned interrupt. Practically this latency may be a problem in
some cases;)

   Hiroshi DOYU
