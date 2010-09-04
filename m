From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/6] ARM: Use SMP and UP macros for cacheflush
Date: Sat, 4 Sep 2010 16:31:06 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE77A2@dbde02.ent.ti.com>
References: <20100819073810.GR12184@atomide.com>
 <4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com> <20100902161940.GL11597@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7588@dbde02.ent.ti.com>
 <20100904105750.GC12674@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57193 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab0IDLBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Sep 2010 07:01:31 -0400
In-Reply-To: <20100904105750.GC12674@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Saturday, September 04, 2010 4:28 PM
> To: Shilimkar, Santosh
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Bryan Wu; Will Deacon
> Subject: Re: [PATCH 2/6] ARM: Use SMP and UP macros for cacheflush
> 
> On Fri, Sep 03, 2010 at 05:27:25PM +0530, Shilimkar, Santosh wrote:
> > Since UP/SMP both cases are handled, the above patch can be something
> > like this now...
> 
> No - this results in the instruction used for ARMv6 SMP systems being
> changed to the ARMv7 instruction, which probably won't work.
Ok. I get it now
