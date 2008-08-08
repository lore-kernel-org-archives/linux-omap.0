From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Fri, 8 Aug 2008 02:45:40 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808080242590.21853@utopia.booyaka.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>  <20080805114920.GC27299@trinity.fluff.org>  <13B9B4C6EF24D648824FF11BE89671620361EE1A9C@dlee02.ent.ti.com>  <1218018018.25235.23.camel@pc1117.cambridge.arm.com>
 <alpine.DEB.1.00.0808062355060.18201@utopia.booyaka.com> <1218127510.7718.41.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46449 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbYHHIpl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 04:45:41 -0400
In-Reply-To: <1218127510.7718.41.camel@pc1117.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, tony@atomide.com, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, 7 Aug 2008, Catalin Marinas wrote:

> Many of the architecture people in ARM seem to be on holiday, I'll try
> to get clarification in about a week time.

That would be really great.  For reference, here is the assembly code in 
question:

    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg01349.html

It's the code following the omap34xx_sram_configure_core_dpll entry point.


- Paul
