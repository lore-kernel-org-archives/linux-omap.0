From: Koen Kooi <koen@dominion.thruhere.net>
Subject: IVA and SGX not getting detected on 3630 ES1.2
Date: Wed, 21 Mar 2012 08:36:23 +0100
Message-ID: <F019DCEE-44FB-4CFC-BABF-A53A34C3EBA3@dominion.thruhere.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45012 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab2CUHg1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 03:36:27 -0400
Received: by wibhj6 with SMTP id hj6so6116672wib.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 00:36:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Hi,

I have a freshly built beagleboard xM on my desk which is giving me some trouble:

xM revision A:
[    0.000000] OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )

new xM revision C:
[    0.000000] OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )

So the IVA and SGX aren't getting detected, while they *are* present. Any hints where I should look to debug this?

regards,

Koen