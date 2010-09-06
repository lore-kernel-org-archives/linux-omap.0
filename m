From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 06 Sep 2010 10:38:30 +0100
Message-ID: <1283765910.1926.4.camel@e102109-lin.cambridge.arm.com>
References: <20100817154035.GD20325@n2100.arm.linux.org.uk>
	 <20100819073810.GR12184@atomide.com> <4C6CFBAF.6020407@canonical.com>
	 <20100819095705.GU12184@atomide.com>
	 <20100819102025.GA32151@n2100.arm.linux.org.uk>
	 <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com>
	 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
	 <20100902161659.GJ11597@atomide.com>
	 <1283765333.1926.2.camel@e102109-lin.cambridge.arm.com>
	 <20100906093424.GB20903@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37948 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750734Ab0IFJij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 05:38:39 -0400
In-Reply-To: <20100906093424.GB20903@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>

On Mon, 2010-09-06 at 10:34 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 06, 2010 at 10:28:53AM +0100, Catalin Marinas wrote:
> > I haven't followed your patches closely but can we restrict the ARMv6
> > SMP/UP support to only those cores that have TEX remapping (most of them
> > probably)?
> 
> We don't support TEX remapping on ARMv6.

I know but it's easy to enable if useful for the SMP/UP v6/v7
combination (with some restrictions).

-- 
Catalin

