From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/12] OMAP3 CPUidle context save/restore patches -
     supports C6
Date: Mon, 1 Sep 2008 19:06:00 +0530 (IST)
Message-ID: <58337.192.168.10.89.1220276160.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYIANgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 09:36:08 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81Da1MM000859
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:36:06 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m81DZxRD018370
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:36:00 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

This patch set is the next in the series of CPUIdle patches. This has
context save/restore support implemented for the following modules
GPMC, UART, GPIO, I2C, PRCM, INTC, SCM, SRAM.

This also adds support for CPUIdle state C6, and adds a CONFIG option
to enable/disbale CORE OFF support in CPUIdle. This option is disabled
by default for now as not all device drivers are adapted to CORE OFF.

The config option can be found here
System Type->TI OMAP Implementations->CORE OFF support in CPUIdle.

regards,
Rajendra



