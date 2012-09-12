From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH] ARM: mm: ADD descriptor string to
 CONFIG_DMA_ADDR_64BIT_T
Date: Wed, 12 Sep 2012 13:56:21 +0100
Message-ID: <20120912125621.GC21823@arm.com>
References: <1347429006-10879-1-git-send-email-r.sricharan@ti.com>
 <5050841A.7030203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:35477 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758271Ab2ILM5O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 08:57:14 -0400
Content-Disposition: inline
In-Reply-To: <5050841A.7030203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cyril Chemparathy <cyril@ti.com>
Cc: R Sricharan <r.sricharan@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

On Wed, Sep 12, 2012 at 01:46:18PM +0100, Cyril Chemparathy wrote:
> On 9/12/2012 1:50 AM, R Sricharan wrote:
> > Even if CONFIG_DMA_ADDR_64BIT_T is enabled by the defconfig,
> > the feature is not getting selected.
> > Adding a string description in the Kconfig resolves this.
> >
> > But not sure if this is the right way to fix this.
> 
> Shouldn't you be selecting this in your 64-bit dma address capable arch 
> instead?

Yes, that's how it was meant to be used.

-- 
Catalin
