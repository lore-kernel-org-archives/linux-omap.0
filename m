From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
	address space.
Date: Tue, 8 May 2012 22:55:54 +0100
Message-ID: <20120508215554.GA18980@n2100.arm.linux.org.uk>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com> <20120508124116.GE17798@arm.com> <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58706 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727Ab2EHV4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 17:56:23 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, R Sricharan <r.sricharan@ti.com>

On Tue, May 08, 2012 at 07:31:57PM +0530, Shilimkar, Santosh wrote:
> Ok. Assuming you mean " it's _not_ cleaner to have two domains where
> manager overrides XN attributes" Note that DRAM can be in the middle of
> 4GB address space, so we need to take care of bottom and top address
> space.
> 
> Update patch end of the email. Is that fine with you ?

This is certainly not cleaner because this will break non-ARMv7.
