From: Archit Taneja <a0393947@ti.com>
Subject: Issue with _are_all_hardreset_lines_asserted()
Date: Thu, 4 Oct 2012 18:45:58 +0530
Message-ID: <506D8C0E.8010600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56270 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756639Ab2JDNQD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Oct 2012 09:16:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>, "paul@pwsan.com" <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>

Hi,

I was trying out the linux-next kernel, and I noticed that DSS 
MODULEMODE bits are never cleared.

In _omap4_disable_module(), there is a check:

	...

	if (!_are_all_hardreset_lines_asserted(oh))
		return 0;

	/* MODULEMODE bits cleared here */
	...
	...
	...

The function _are_all_hardreset_lines_asserted() returns false if 
'oh->rst_lines_cnt == 0', so we bail out from _omap4_disable_module() 
before clearing the MODULEMODE bits.

Is this correct behavior? This would prevent all hwmods who have 
rst_lines_cnt as 0 to not get their MODULEMODE bits cleared.

Thanks,
Archit
