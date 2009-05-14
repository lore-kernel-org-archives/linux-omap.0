From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 0/2] PM: OMAP3 SDRC: fix some SDRAM settings for Qimonda
	parts
Date: Thu, 14 May 2009 13:50:10 -0600
Message-ID: <20090514194728.20623.60039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43621 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbZENTwe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 15:52:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: r-woodruff2@ti.com, khilman@deeprootsystems.com

Hi,

This series updates some SDRAM parameter settings for the Qimonda parts
used on some 3430SDP boards.

Drop the 133.3MHz/66.6MHz rates from the Qimonda SDRAM file - these were only
used on some early Labrador boards with slower SDRAM parts.  Thanks to
Richard Woodruff <r-woodruff2@ti.com> for help with this patch.

Finally some 3430SDP boards are using bootloaders with rounded DPLL3 rates
(e.g., 166000000 Hz rather than 165941176 Hz); update the Qimonda SDRAM
parameters.  This resolves -EINVALs during boot-time "Reprogramming SDRC"
on 3430SDPs with updated bootloaders.  Thanks to Kevin Hilman
<khilman@deeprootsystems.com> for reporting this issue and testing
the patch.

These patches will be queued up into the omap-clock-testing branch at the
next opportunity.

---

size:
   text    data     bss     dec     hex filename
3667957  196224  113216 3977397  3cb0b5 vmlinux.3430sdp.orig
3667957  196224  113216 3977397  3cb0b5 vmlinux.3430sdp

Paul Walmsley (2):
      OMAP3 SDRC: Add rounded rates for devices using the Qimonda SDRAM
      OMAP3 SDRC: Drop 133.3MHz, 66.6MHz rates from Qimonda SDRAM params file


 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   25 ++++++++++----------
 1 files changed, 12 insertions(+), 13 deletions(-)

