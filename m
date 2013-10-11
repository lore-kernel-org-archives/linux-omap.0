From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/11] ARM: OMAP2+: CM cleanup series
Date: Fri, 11 Oct 2013 19:15:30 +0300
Message-ID: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54824 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244Ab3JKQQU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:16:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

A small cleanup set for CM. This basically gets rid of the omap2_cm_*
register accesses from the random code locations, and gathers these
under cm2xxx.c and cm3xxx.c. This is done in preparation for creating
a separate CM driver. The set also contains a couple of PRM cleanups
which I decided to take care of at the same time due to overlapping
code (PRCM interrupt handler + DSP reset.)

TODO: cleanup dsp bridge code (arch/arm/mach-omap2/dsp.c.)

Tested on OMAP3 beagle + 3.12-rc3.

If someone could verify the omap2 changes, that would be nice.

-Tero

