From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Subject: [PATCHv2 0/6] omap-aes off mode and error handling fixes
Date: Tue, 30 Nov 2010 10:13:26 +0200
Message-ID: <cover.1291104329.git.dmitry.kasatkin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:51518 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975Ab0K3IM6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 03:12:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org

Changes to v1:
- omap type specific handling removed
- fixed backlog handling bug in "redundunt locking is removed"
- aes module initialized once per request instead of dma transaction
  more efficient and right way to do it
- checkpatch fixes in separate patch


Dmitry Kasatkin (6):
  omap-aes: DMA initialization fixes for OMAP off mode
  omap-aes: redundant locking is removed
  omap-aes: error handling implementation improved
  omap-aes: unnecessary code removed
  omap-aes: initialize aes module once per request
  omap-aes: checkpatch --file warning fixes

 drivers/crypto/omap-aes.c |  260 +++++++++++++++++++++++---------------------
 1 files changed, 136 insertions(+), 124 deletions(-)

