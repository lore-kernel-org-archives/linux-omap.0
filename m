From: Roman <roman.tereshonkov@nokia.com>
Subject: Amba device porting
Date: Wed, 23 Dec 2009 12:19:02 +0200
Message-ID: <20091223101902.GA15537@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53086 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147AbZLWKV4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 05:21:56 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi,

I planned to port the omap3 SDTI (Serial Debug Trace Interface) driver to amba based interface.

SDTI memory map is two parts composed:
0x54500000 0x5450FFFF 4KB       SDTI module (configuration) - coresight based format.
0x54510000 0x545FFFFF 1984KB    Reserved
0x54600000 0x546FFFFF 1MB       SDTI module (window)

But amba interface seems to support only one memory region resource.

Is there any way to pass two memory regions?


Regards
Roman Tereshonkov
