From: Arun KS <getarunks@gmail.com>
Subject: omap_mcbsp_request fails for OMAP1 platforms
Date: Fri, 10 Apr 2009 19:16:02 +0530
Message-ID: <dfeb90390904100646m43c1aaa6ib2253b38e71bcb5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:19938 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbZDJNqF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2009 09:46:05 -0400
Received: by ti-out-0910.google.com with SMTP id i7so877935tid.23
        for <linux-omap@vger.kernel.org>; Fri, 10 Apr 2009 06:46:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I am using osk5912 board with latest l-o tree(2.6.30-rc1).

But, the system hangs at omap_mcbsp_request for mcbsp 1 and mcbsp 3,

ie.. omap_mcbsp_request(0) and omap_mcbsp_request(2)
but omap_mcbsp_request(1) works fine.

In file: arch/arm/mach-omap1/mcbsp.c
fuction: omap1_mcbsp_request

api_clk = clk_get(NULL, "api_clk");
dsp_clk = clk_get(NULL, "dsp_clk");

these clocks are not present in the tree structure at
arch/arm/mach-omap1/clock.c

So basically these clk_get s fails and the system hangs at

OMAP_MCBSP_WRITE(mcbsp->io_base, SPCR1, 0);
in File:arch/arm/plat-omap/mcbsp.c
Function: omap_mcbsp_request

Thanks,
Arun
