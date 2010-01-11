From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do
	notinvalidate clean lines
Date: Mon, 11 Jan 2010 16:26:30 +0000
Message-ID: <1263227190.6305.51.camel@pc1117.cambridge.arm.com>
References: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
	 <1263220628.6305.44.camel@pc1117.cambridge.arm.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C0509409@dbde02.ent.ti.com>
	 <20100111152333.GB4109@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46214 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751172Ab0AKQ0v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 11:26:51 -0500
In-Reply-To: <20100111152333.GB4109@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, "Woodruff, Richard" <r-woodruff2@ti.com>

On Mon, 2010-01-11 at 15:23 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 11, 2010 at 08:48:37PM +0530, Shilimkar, Santosh wrote:
> > > Do you need to specify "r12" as well? What about "cc", are they
> > > preserved by the secure monitor?
> >
> > r12 and reset of the registers are preserved. Lr needs to be saved but
> > because of function call, the compiler saves/restores it.
> 
> That's not guaranteed; the compiler can re-use lr for its own purposes
> within a function.  You need to add lr to the list of clobbered registers.

Do we need to specify "r12" in the list of clobbered registers as the
inline asm explicitly modifies it? Or the compiler doesn't touch it.

-- 
Catalin

