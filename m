From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] PM: OMAP3 SDRC: fix some SDRAM settings for Qimonda parts
Date: Thu, 14 May 2009 12:54:45 -0600
Message-ID: <20090514185012.2152.36226.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52128 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbZENTE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 15:04:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Richard Woodruff <r-woodruff2@ti.com>

Hi,

This series updates some SDRAM parameter settings for the Qimonda parts
used on some 3430SDP boards.

Finally some 3430SDP boards are using bootloaders with rounded DPLL3 rates
(e.g., 166000000 Hz rather than 165941176 Hz); update the Qimonda SDRAM
parameters.

Also when reviewing the timing calculations, it appears that the lowest speed
setting had an error in its autorefresh counter value.  I don't know if
anything out there still uses this low-speed setting - my recollection is
that it was added for some early Labrador boards that had speed restrictions -
any comments from TI on whether these 133.3MHz/66.6MHz rates should be dropped
is most welcome.

These patches will be queued up into the omap-clock-testing branch at the
next possible opportunity.


- Paul

---

size:
  text    data     bss     dec     hex filename
3667957  196224  113216 3977397  3cb0b5 vmlinux.3430sdp.orig
3667957  196256  113216 3977429  3cb0d5 vmlinux.3430sdp


Paul Walmsley (2):
      OMAP3 SDRC: Add rounded rates for devices using the Qimonda SDRAM
      OMAP3 SDRC: Fix autorefresh counter for Qimonda SDRAM 66.6MHz rate


 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   28 +++++++++++++++-----
 1 files changed, 21 insertions(+), 7 deletions(-)

