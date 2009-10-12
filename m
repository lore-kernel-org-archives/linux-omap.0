From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 0/3] OMAP3: PM: Make PRM setup times and CPUidle
 latencies/threshold board specific
Date: Mon, 12 Oct 2009 19:11:07 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D1009@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43295 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755514AbZJLNlu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 09:41:50 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

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

regards,
Rajendra


