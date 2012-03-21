From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: IVA and SGX not getting detected on 3630 ES1.2
Date: Wed, 21 Mar 2012 13:04:01 +0100
Message-ID: <F75355CF-6C58-4667-B505-DC5EB7167981@dominion.thruhere.net>
References: <F019DCEE-44FB-4CFC-BABF-A53A34C3EBA3@dominion.thruhere.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37402 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab2CUMEC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 08:04:02 -0400
Received: by wejx9 with SMTP id x9so864839wej.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 05:04:01 -0700 (PDT)
In-Reply-To: <F019DCEE-44FB-4CFC-BABF-A53A34C3EBA3@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


Op 21 mrt. 2012, om 08:36 heeft Koen Kooi het volgende geschreven:

> Hi,
> 
> I have a freshly built beagleboard xM on my desk which is giving me some trouble:
> 
> xM revision A:
> [    0.000000] OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
> 
> new xM revision C:
> [    0.000000] OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
> 
> So the IVA and SGX aren't getting detected, while they *are* present. Any hints where I should look to debug this?

This is on 3.0.25 if that makes a difference.