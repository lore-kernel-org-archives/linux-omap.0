From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/4] OMAP: Cleanup series.
Date: Tue, 19 May 2009 18:46:47 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CBCAD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48563 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbZESNRI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 09:17:08 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Recent OMAP4 patch reviews brought out some clean-up/reorganization on generic OMAP2/3 software. This patch series addresses those comments.
It's based on 2.6.30-rc6 (commit:22ef37eed673587ac984965dc88ba94c68873291) and tested on OMAP3430 SDP platform.

	[PATCH 1/4] ARM: OMAP2/3: Reorganize Makefile to add omap4 support
	[PATCH 2/4] ARM: OMAP: Remove unwanted type casts and fix the compiler warning.
	[PATCH 3/4] ARM: OMAP: Remove useless omap_sram_error function.
	[PATCH 4/4] ARM: OMAP: Remove unnecessary omap2_globals.
 

Regards,
Santosh
