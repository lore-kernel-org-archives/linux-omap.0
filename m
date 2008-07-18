From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] TWL4030: mark init functions __init, fix kerneldoc
Date: Thu, 17 Jul 2008 20:15:47 -0600
Message-ID: <20080718021356.31884.9848.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44360 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbYGRCQh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 22:16:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Mark most of the functions in twl4030-core.c as __init.  Fix the
old-style kerneldoc in several functions.

Applies on top of 'TWL4030: bugfixes and cleanups'.  Frees up an extra
4kB page after kernel init on 3430SDP.  Not sure why there is such a
large kernel image size difference; no new code or data has been added.

Boot-tested on 3430SDP ES2.

- Paul

---

size:
   text    data     bss     dec     hex filename
3391251  157104  107136 3655491  37c743 vmlinux
3394259  157104  107136 3658499  37d303 vmlinux

 drivers/i2c/chips/twl4030-core.c |   71 +++++++++++++++++++-------------------
 1 files changed, 35 insertions(+), 36 deletions(-)

