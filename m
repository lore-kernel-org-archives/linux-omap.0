From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 0/3] DSPBRDIGE: Implement WDT3 to notify DSP hangs
Date: Wed, 11 Nov 2009 00:55:37 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A6A218F8@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34853 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbZKKGzd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 01:55:33 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAB6tc1h006014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:55:39 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id nAB6tcOB004248
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:55:38 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAB6tcBL013434
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 00:55:38 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi All,

	This set of patches implement wdt3 to detect when DSP hangs, there are the mail features:

	- Added to catch DSP hang or crash which is not caught by MMU 			faults or exceptions.
	- This can also catch the tight loop in the DSP.
	- WDT3 (IVA2 WD) causes an interrupt to ARM in the event of 			overflow.
	- MPU configures the IVA2 WD.
	- DSP periodically re-loads the counter in order to avoid the overflow 			when active.
		* Reload occurs in the IDLE task.
		* Reload also occurs when the interrupt is sent back to MPU.
	- WD is disabled when IVA go to OFF and enabled when coming out OFF.
	- WD will be delivered disabled by default.  It can be enabled with 		the sysfs entry.
	- WD timer value will also be configurable through sysfs entry.

Regards,
Fernando.
