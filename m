From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/2] OMAP2+: DMA: fix src/dst position reporting
Date: Mon,  7 Nov 2011 11:33:05 +0200
Message-ID: <1320658387-21067-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58147 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751861Ab1KGJdX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 04:33:23 -0500
Received: by faaa20 with SMTP id a20so344008faa.10
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 01:33:21 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

Changes since v1:
- Move the check after the ERRATA_3_3 re-read test

If the user asks for the sDMA current position before the first
data has been transmitted (before the first DMA request has been
generated), the reported position is not valid:
src position: CSAC is uninitialized
dst position: CDAC is 0

The return values in both case considered invalid.
This sitation can be identified by checking if the CDAC register
is 0 (it is initialized to 0 in omap_dam_start call).
In this case return the programmed source/destination address.

The affected omap_get_dma_src_pos/omap_get_dma_dst_pos functions
are used by the audio stack mainly for checking the current position
of the audio stream.

Regards,
Peter
---
Peter Ujfalusi (2):
  OMAP2+: DMA: Workaround for invalid source position
  OMAP2+: DMA: Workaround for invalid destination position

 arch/arm/plat-omap/dma.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

-- 
1.7.7.2

