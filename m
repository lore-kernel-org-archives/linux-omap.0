From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: IVA and SGX not getting detected on 3630 ES1.2
Date: Wed, 21 Mar 2012 13:35:24 +0100
Message-ID: <067A7F76-43A6-4331-BE0F-DEDCE81049C4@dominion.thruhere.net>
References: <F019DCEE-44FB-4CFC-BABF-A53A34C3EBA3@dominion.thruhere.net> <F75355CF-6C58-4667-B505-DC5EB7167981@dominion.thruhere.net> <alpine.DEB.2.01.1203211320440.13696@pmeerw.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43226 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab2CUMf3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 08:35:29 -0400
Received: by wibhj6 with SMTP id hj6so6443315wib.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 05:35:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.01.1203211320440.13696@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


Op 21 mrt. 2012, om 13:29 heeft Peter Meerwald het volgende geschreven:

> 
>>> xM revision A:
>>> [    0.000000] OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
>>> new xM revision C:
>>> [    0.000000] OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
> 
> on a rev. C -xm with kernel 3.2.8:
> [    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
> 
> maybe u-boot makes some difference?

>From what I can tell the kernel reads the register directly, so u-boot shouldn't make a difference.

regards,

Koen