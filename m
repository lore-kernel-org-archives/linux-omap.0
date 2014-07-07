From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/6] ARM: dts: dra7-evm: Make VDDA_1V8_PHY supply
 always on
Date: Mon, 7 Jul 2014 01:44:32 -0700
Message-ID: <20140707084431.GK28884@atomide.com>
References: <1404467748-12154-1-git-send-email-rogerq@ti.com>
 <1404467748-12154-2-git-send-email-rogerq@ti.com>
 <20140707082922.GI28884@atomide.com>
 <53BA5B8A.5010805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39378 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbaGGIob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 04:44:31 -0400
Content-Disposition: inline
In-Reply-To: <53BA5B8A.5010805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, balbi@ti.com, nsekhar@ti.com, nm@ti.com, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>

* Roger Quadros <rogerq@ti.com> [140707 01:36]:
> Hi Tony,
> 
> On 07/07/2014 11:29 AM, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [140704 02:57]:
> >> After clarification from the hardware team it was found that
> >> this 1.8V PHY supply can't be switched OFF when SoC is Active.
> >>
> >> Since the PHY IPs don't contain isolation logic built in the design to
> >> allow the power rail to be switched off, there is a very high risk
> >> of IP reliability and additional leakage paths which can result in
> >> additional power consumption.
> >>
> >> The only scenario where this rail can be switched off is part of Power on
> >> reset sequencing, but it needs to be kept always-on during operation.
> >>
> >> This patch is required for proper functionality of USB, SATA
> >> and PCIe on DRA7-evm.
> >>
> >> CC: Rajendra Nayak <rnayak@ti.com>
> >> CC: Tero Kristo <t-kristo@ti.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> > 
> > Best that you queue this with the series:
> 
> This patch doesn't have any dependency with the others and we're not even sure if
> this series will hit 3.16.
> 
> But this 1V8 regulator _is_ required for normal operation of the SoC, whether the
> PHYs are in use or not.
> 
> Can you please queue just this patch for SoC fixes for 3.16? Thanks.

OK will do.

Regards,

Tony
