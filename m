From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Make ARMv6 behave with TLS, VFPv3, and NEON
Date: Mon, 21 Jun 2010 16:51:13 +0300
Message-ID: <20100621133749.24299.36154.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62552 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438Ab0FUNvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 09:51:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here is an updated version of the earlier patch for the TLS [1], and a related
patch for VFPv3 and NEON. Sorry it took a while before I got around updating
this patch.

This series allows booting ARMv6 and 7 with the same kernel binary, such as
omap24xx (ARMv6), omap34xx (ARMv7) and omap44xx (ARMv7 SMP).

To summarize the problem, ARM1136 has TLS and MVFR registers only starting with
r1 p0, and at least omap2420 is earlier at r0 p2 and does not have TLS or
MVFR registers.

Regards,

Tony


[1] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6
    http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011667.html

---

Tony Lindgren (2):
      arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6
      arm: Make VFPv3 usable on ARMv6


 arch/arm/include/asm/hwcap.h     |    1 +
 arch/arm/include/asm/vfpmacros.h |   18 ++++++++++++++++++
 arch/arm/kernel/entry-armv.S     |   29 ++++++++++++++---------------
 arch/arm/kernel/setup.c          |   20 ++++++++++++++++++++
 arch/arm/kernel/traps.c          |   23 +++++++++++++----------
 arch/arm/mm/Kconfig              |   11 -----------
 arch/arm/mm/proc-v6.S            |    6 ++++--
 arch/arm/mm/proc-v7.S            |    2 +-
 arch/arm/vfp/vfpmodule.c         |   10 +++++++---
 9 files changed, 78 insertions(+), 42 deletions(-)

-- 
Signature
