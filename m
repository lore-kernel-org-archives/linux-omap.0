From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP2/3 GPTIMER: minor optimizations
Date: Tue, 14 Oct 2008 11:27:43 -0600
Message-ID: <20081014172417.5459.36601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49889 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbYJNRar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 13:30:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

these patches implement a few minor optimizations on the
omap_dm_timer_set_load() and omap_dm_timer_set_load_start() functions for
OMAP2/3.  Gory details in the patch descriptions.

Tested on 2430SDP and 3430SDP.


- Paul

---

  text    data     bss     dec     hex filename
3099539  135104  151144 3385787  33a9bb vmlinux.3430sdp.orig
3099539  135104  151144 3385787  33a9bb vmlinux.3430sdp

 arch/arm/plat-omap/dmtimer.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

