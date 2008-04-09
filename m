From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Problems with 2430 NAND prefetch engine
Date: Tue, 8 Apr 2008 17:33:35 -0700
Message-ID: <a46a26fd0804081733i469936d4m3315f3bb3270ff5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:2721 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbYDIAdf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2008 20:33:35 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2260196wff.4
        for <linux-omap@vger.kernel.org>; Tue, 08 Apr 2008 17:33:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I am trying to use the NAND prefetch engine to speed up NAND access.

In GPMC CS0 is the NAND chip. GPMC_CONFIG7_0 is set to 0x0000084c by
u-boot. Hence the address for this CS should be 0x0C000000.
Documentation indicates that the FIFO should be accessible in any
associated chip-select region after the engine has been enabled.

In linux I use ioremap() to map 0x0C000000 and use the returned
pointer to access the prefetch engine FIFO.

Prefetch engine is configured and started.
I get FIFOEVENT interrupt from it and try to read the fifo by using
this ioremap's pointer but kernel crashes with:

Unhandled fault: external abort on non-linefetch (0x008) at 0xc4854000
0xc4854000 corresponds to the pointer ioremap() returned.

Apparently I miss something either in HW or kernel but I cannot think
of anything.
Conventional access to the NAND chip through COMMAND/ADDRESS/DATA
registers works ok.
Any ideas would be appreciated.

 - Juha

-- 
Madness takes it's toll. Please have exact change.
