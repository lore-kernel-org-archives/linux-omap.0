From: "arun c" <arunedarath@mistralsolutions.com>
Subject: Does DSS support 24 bits_per_pixel?
Date: Tue, 29 Jul 2008 10:13:04 +0530
Message-ID: <c656a4d20807282143kb3e36e4p36662d7eda4b1861@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:12133 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYG2EnG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 00:43:06 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2487169tic.23
        for <linux-omap@vger.kernel.org>; Mon, 28 Jul 2008 21:43:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

Does omap (2&3) DSS support 24 bit output?

I was trying to enable DVI support for omap2evm(data lines=24, bits
per pixel =24), I couldn't find
24 bit support in omapfb driver(git) and omap24xxfb(linux-2.6.14-omap2-v5).

In TRM its given that it supports 24 BPP. Then why its absent in both
the drivers?. Does the hardware
really support 24 bit format?

Regards,
Arun C
