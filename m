From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] i2c-omap: reduce bloat
Date: Thu, 17 Jul 2008 19:44:10 -0600
Message-ID: <20080718013912.22295.5368.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50368 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757708AbYGRBor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 21:44:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Don't compile the OMAP15xx I2C ISR for non-OMAP15xx builds.  Also, mark
init-only functions in i2c-omap as __init.

Boot-tested on OMAP3430SDP ES2.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---

size:
3391587  157104  107136 3655827  37c893 vmlinux.3430sdp.orig
3390339  157104  107136 3654579  37c3b3 vmlinux.3430sdp


 drivers/i2c/busses/i2c-omap.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

