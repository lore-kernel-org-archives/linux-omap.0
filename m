From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Minor omap2plus_defconfig updates for v3.13 merge window
Date: Thu, 10 Oct 2013 16:04:36 -0700
Message-ID: <20131010230325.8152.27727.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16492 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab3JJXEk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 19:04:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

As it's currently a bit of a pain to patch omap2plus_defconfig, let's
run make savedefconfig on it as that also gets rid of about 30 lines
from it. And let's add some WLAN modules and support for of_serial.

Regards,

Tony

---

Tony Lindgren (2):
      ARM: OMAP2+: Run make savedefconfig on omap2plus_defconfig to shrink it
      ARM: OMAP2+: Add WLAN modules and of_serial to omap2plus_defconfig


 arch/arm/configs/omap2plus_defconfig |  101 +++++++++++++---------------------
 1 file changed, 39 insertions(+), 62 deletions(-)

-- 
Signature
