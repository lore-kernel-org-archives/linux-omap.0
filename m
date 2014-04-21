From: Ben Davis <bdavis@swri.org>
Subject: GPMC fails at clk_get
Date: Mon, 21 Apr 2014 17:29:01 +0000
Message-ID: <6646911DE04D7341A1CB05F0FD48887F1259CC@swri16exbe1.electro.swri.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from esg256-2.itc.swri.edu ([129.162.243.101]:43056 "EHLO
	esg256-2.itc.swri.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbaDUSW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 14:22:29 -0400
Received: from exchmail.swri.org (casht256-1.adm.swri.edu [129.162.243.120])
	by esg256-2.itc.swri.edu (8.14.5/8.14.5) with ESMTP id s3LHVxBE029609
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Mon, 21 Apr 2014 12:31:59 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

my client has "volun-told" me update my design from my functional 3.12 kernel to the 3.15 kernel.  On doing so, my GPMC kernel modules no longer load due to the following:

omap-gpmc 50000000.gpmc: error: clk_get
omap-gpmc: probe of 50000000.gpmc failed with error -2

this is at line 1643 of gpmc.c.

I had to hack the kernel to get my GPMC f-clock operational in 3.12 and presume my issue is due to the evolution of the clocks and integration of the DT.  Perhaps I am coming in mid-modification?

I am continuing to investigate but if there is a simple solution I would love to any help you can offer.

Cheers,
Benjamin 