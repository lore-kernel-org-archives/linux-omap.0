From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 6 Sep 2010 10:34:24 +0100
Message-ID: <20100906093424.GB20903@n2100.arm.linux.org.uk>
References: <20100817154035.GD20325@n2100.arm.linux.org.uk> <20100819073810.GR12184@atomide.com> <4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com> <20100819102025.GA32151@n2100.arm.linux.org.uk> <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com> <20100902133637.GJ26319@n2100.arm.linux.org.uk> <20100902161659.GJ11597@atomide.com> <1283765333.1926.2.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44203 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab0IFJen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 05:34:43 -0400
Content-Disposition: inline
In-Reply-To: <1283765333.1926.2.camel@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>

On Mon, Sep 06, 2010 at 10:28:53AM +0100, Catalin Marinas wrote:
> I haven't followed your patches closely but can we restrict the ARMv6
> SMP/UP support to only those cores that have TEX remapping (most of them
> probably)?

We don't support TEX remapping on ARMv6.
