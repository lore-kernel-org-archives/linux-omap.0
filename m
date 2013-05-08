From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: dts: OMAP36xx/OMAP4460 Fix CPU OPP voltages
Date: Wed, 8 May 2013 16:14:46 -0700
Message-ID: <20130508231445.GQ32546@atomide.com>
References: <1366997973-19120-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41689 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751996Ab3EHXOt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 19:14:49 -0400
Content-Disposition: inline
In-Reply-To: <1366997973-19120-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

* Nishanth Menon <nm@ti.com> [130426 10:44]:
> Hi,
> It seems that I have not been paying close attention to
> actual voltage value seen on scope to map it back to verify the validity
> of the voltage value. Even though I did verify[1] that voltage did scale to
> values in DT entries, the values in the case of 3630 and 4460 were lower than
> what the spec voltage was as per opp_data files.
> 
> This series is based off Benoit's tree here:
> http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.10/dts
> 
> Commit ID's in the patches to indicate regressions are from there as well.
> Would be good to have this fix merged to 3.10 dts entries.
> I have cross verified that OMAP3430,3630,4430 and 4460 entries now match that
> of corresponding opp*_data.c
> 
> My sincere apologies on the oversight.
> 
> Nishanth Menon (2):
>   ARM: dts: OMAP36xx: Fix CPU OPP voltages
>   ARM: dts: OMAP4460: Fix CPU OPP voltages
> 
>  arch/arm/boot/dts/omap36xx.dtsi |    6 +++---
>  arch/arm/boot/dts/omap4460.dtsi |    6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> [1] http://marc.info/?l=linux-arm-kernel&m=136580742724210&w=2

Thanks applying both into omap-for-v3.10/dt-fixes.

Regards,

Tony
