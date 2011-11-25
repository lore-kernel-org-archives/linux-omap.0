From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 0/6] OMAP: SMPS support for TWL regulators
Date: Fri, 25 Nov 2011 18:29:16 +0200
Message-ID: <1322238562-19943-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53134 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab1KYQ3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 11:29:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, gg@slimlogic.co.uk, rnayak@ti.com, b-cousson@ti.com

Hello,

Unfortunately the previous version of this work (SMPS regulator
was a separate driver) was rejected by the omap maintainers, thus
I am sending a new version. This implementation is going somewhat
back towards the original version, we are having an external
controller that replaces the default controller from a regulator
driver, in this case from twl-regulator. External controller
support is built in to regulator core now, and it is used when
available.

I think the main force behind driving the SMPS support back
towards this has been Kevin Hilman and Benoit Cousson from TI.

Rajendra Nayak also had a quick look at these patches and said
that adding device tree support on top of this is rather trivial,
however it can't be done at this point due to missing dependencies.

This set applies on top of Kevin's for_3.2/voltage-cleanup branch.

Tested on omap3 beagle, by changing voltages of both vdd1 and vdd2
regulators and measuring it from the hw.

-Tero

