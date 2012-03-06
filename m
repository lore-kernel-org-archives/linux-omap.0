From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 0/6] ARM: OMAP3+: IO daisy chain support fixes
Date: Tue, 6 Mar 2012 17:11:36 +0200
Message-ID: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58003 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030763Ab2CFPL4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Mar 2012 10:11:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Changes compared to previous version:

- patch2:
  * fixed the timeout for waiting for ST_IO_CHAIN == 1
  * added clear for ST_IO_CHAIN bit (as per spec + implementation in patch 1)
  * replaced the timeout at the end of function with a simple register
    readback (timing out on a register value that we are clearing does
    not make that much sense, the bit is cleared the very first time CPU
    manages to read it)
- patch5:
  * added spinlock for protecting io_chain_trigger operation

Tested on omap3 beagle + omap4 blaze. Also did measurements for the
cost of IO chain trigger operation with ARM performance counters:

- omap3 approx 7...8us
- omap4 approx 2...4us

-Tero


