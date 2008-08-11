From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] OMAP3 timer: switch Beagle clockevents source to GPTIMER12
Date: Mon, 11 Aug 2008 17:34:20 -0600
Message-ID: <20080811233109.3046.54050.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35736 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbYHKXi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 19:38:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch series allows the clockevents source GPTIMER to be selectable via
Kconfig, and changes the Beagle Kbuild config to use GPTIMER12 instead of
GPTIMER1.  The theory here is that GPTIMER12 has its own internal 32kHz 
secure oscillator, and does not depend on the external 32kHz clock source,
which we suspect may be noisy.


---

size:
  text    data     bss     dec     hex filename
3265520  145472  105480 3516472  35a838 vmlinux.beagle.orig
3265568  145472  105480 3516520  35a868 vmlinux.beagle

 arch/arm/configs/omap3_beagle_defconfig |    5 +++--
 arch/arm/mach-omap2/Kconfig             |   16 ++++++++++++++++
 arch/arm/mach-omap2/timer-gp.c          |    5 ++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

