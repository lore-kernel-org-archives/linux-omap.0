From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: LPDDR memory for TI OMAP 3503 processor
Date: Thu, 1 Jan 2009 18:30:32 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036CEED176@dlee02.ent.ti.com>
References: <AB5ACC34-3CDD-4FB9-9A8B-F948D9FA7952@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43656 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbZABAal convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jan 2009 19:30:41 -0500
In-Reply-To: <AB5ACC34-3CDD-4FB9-9A8B-F948D9FA7952@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, Linux OMAP Users <linux-omap@vger.kernel.org>

 34xx max supported ddr frequently is 166mhz.

there should be no issue running a 200mhz rated ddr at 166.

the real issues are with pin level interfacing.
________________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Elvis Dowson [elvis.dowson@mac.com]
Sent: Thursday, January 01, 2009 3:31 PM
To: Linux OMAP Users
Subject: LPDDR memory for TI OMAP 3503 processor

Hi,
         Is the micron 2GB POP LPDDR memory compatible with the TI
OMAP3503 processor?  http://www.micron.com/products/partdetail?part=MT46H64M32L2JG-5%20IT

Quote from the technical reference manual:
"The SDRC module only supports low-power double-data-rate (LPDDR)
SDRAM devices. Memory devices can be interfaced to the SDRC using a
stacked-memory approach or through the printed circuit board (PCB).
The stacked-memory approach uses the package on package interface pins
(available on CBB & CBC package). The LPDDR interface on the top of
the POP package has been designed for compatibility any POP LPDDR
device with a matching footprint and compliance with the JEDEC
LPDDR-266 specification."

My point of confusion is
a. the Micron 2GB memory is stated to have a 200MHz clock rate and the
data rate is LPDDR400.
b. in the term JDEC LPDDR-266, does the 266 correspond to the data
rate? If so, can I use the LPDDR400 memory with the OMAP3503
processor, which requires an LPDDR-266 memory?

Best regards,

Elvis Dowson
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

