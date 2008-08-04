From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv2 0/2] TWL4030: mark init functions __init, fix kerneldoc
Date: Mon, 04 Aug 2008 14:56:43 -0600
Message-ID: <20080804205134.22691.75138.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55055 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298AbYHDVOK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 17:14:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com

This second revision incorporates a documentation fix from Felipe Balbi 
<felipe.balbi@nokia.com>.

---

Mark most of the functions in twl4030-core.c as __init.  Fix the
old-style kerneldoc in several functions.

Frees up an extra 4kB page after kernel init on 3430SDP.  Not sure why
there is such a large kernel image size difference; no new code or
data has been added.

Boot-tested on 3430SDP ES2.


- Paul

---

size:

  text    data     bss     dec     hex filename
3391251  157104  107136 3655491  37c743 vmlinux.3430sdp.orig
3394259  157104  107136 3658499  37d303 vmlinux.3430sdp

 drivers/i2c/chips/twl4030-core.c |   71 +++++++++++++++++++-------------------
 1 files changed, 35 insertions(+), 36 deletions(-)

