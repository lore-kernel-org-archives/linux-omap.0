From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/6] ARM: Use SMP and UP macros for cacheflush
Date: Sat, 4 Sep 2010 11:57:50 +0100
Message-ID: <20100904105750.GC12674@n2100.arm.linux.org.uk>
References: <20100819073810.GR12184@atomide.com> <4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com> <20100819102025.GA32151@n2100.arm.linux.org.uk> <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com> <20100902133637.GJ26319@n2100.arm.linux.org.uk> <20100902161659.GJ11597@atomide.com> <20100902161940.GL11597@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7588@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51875 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab0IDK6B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Sep 2010 06:58:01 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7588@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

On Fri, Sep 03, 2010 at 05:27:25PM +0530, Shilimkar, Santosh wrote:
> Since UP/SMP both cases are handled, the above patch can be something
> like this now... 

No - this results in the instruction used for ARMv6 SMP systems being
changed to the ARMv7 instruction, which probably won't work.
