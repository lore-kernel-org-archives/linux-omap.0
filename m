From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: IVA and SGX not getting detected on 3630 ES1.2
Date: Wed, 21 Mar 2012 13:29:31 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1203211320440.13696@pmeerw.net>
References: <F019DCEE-44FB-4CFC-BABF-A53A34C3EBA3@dominion.thruhere.net> <F75355CF-6C58-4667-B505-DC5EB7167981@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:40878 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757204Ab2CUM3f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 08:29:35 -0400
In-Reply-To: <F75355CF-6C58-4667-B505-DC5EB7167981@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


> > xM revision A:
> > [    0.000000] OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
> > new xM revision C:
> > [    0.000000] OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )

on a rev. C -xm with kernel 3.2.8:
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )

maybe u-boot makes some difference?

regards p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
