From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 0/2] OMAP3: PM: Make PRM setup times and CPUidle
 latencies/threshold board specific
Date: Mon, 29 Jun 2009 20:04:34 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305B77D98@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43705 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbZF2Oej convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 10:34:39 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5TEYavj004336
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 09:34:41 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5TEYZVp022859
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 20:04:35 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

The setup times to be programmed in the PRM module on OMAP (for clksetup, voltsetup etc)
are board specific. They depend heavily on the PMIC used and even on different boards
with the same PMIC, they vary based on the sleep/wake sequence used, system clock speed et al.

The CPUidle latencies and hence thresholds (derived from latencies and Power consumption numbers)
and very much dependent on these setup values and hence also need to be board specific.

This patchset makes it possible for the PRM setup times and the CPUidle latencies/threshold numbers to be
configured from board files, and some default values are used if nothing gets passed from board files.

Only the 3430SDP board file is currently been modifed to pass these values and the rest of the 3430
based board's still pass NULL and hence use the default values defined.

Also the values currenlty passed for the 3430SDP are not optimal. I will send out a sperate patchset
which would popluate the optimal setup times/proper latencies/optimal thresholds for the 3430SDP.

This patchset is generated on top of the latest pm(2.6.30) branch and validated on the SDP
using the omap3_pm_defconfig.

regards,
Rajendra