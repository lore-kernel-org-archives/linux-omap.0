From: John Faith <jfaith7@gmail.com>
Subject: DMA from GPMC peripheral to external RAM
Date: Thu, 26 Aug 2010 18:32:38 -0700
Message-ID: <AANLkTimfbGTiSY9BHQ8YP4NjUp71YZz1NNcR82Gs+Grd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46670 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0H0Bcj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 21:32:39 -0400
Received: by vws3 with SMTP id 3so2385814vws.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 18:32:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,
I'm trying to transfer from an FPGA peripheral on the 3530's GPMC bus
to external RAM on a 2.6.32 kernel.  Transferring words using
*ram_buffer = __raw_readw(peripheral_addr) works for non-DMA copies
and I've checked that the DMA cycle works in my driver by using
another location in RAM as the source instead of the peripheral
register and I get values and an interrupt as expected, but when using
the FPGA as source all values are 0xff.  The FPGA uses WAIT1 to signal
read/write completion and I've set GPMC_CONFIG6_CYCLE2CYCLEDELAY so
chip select is toggled between transfers as the FPGA hardware
currently requires.

Does a DMA transfer use GPMC settings for timing?  Are there other
settings I need to worry about for this case?

Thanks!
,
John
