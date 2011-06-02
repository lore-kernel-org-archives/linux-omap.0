From: Dmitry Kasatkin <dmitry.s.kasatkin@gmail.com>
Subject: [PATCH 00/11] crypto: omap-sham driver fixes
Date: Thu,  2 Jun 2011 21:10:02 +0300
Message-ID: <cover.1306926921.git.dmitry.kasatkin@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58398 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab1FBSKZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jun 2011 14:10:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: herbert@gondor.hengli.com.au
Cc: linux-crypto@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

Recently we got crashes few times after some other patches to 2.6.32 kernel.
This patch set greatly prevents race condition situations.
No crashes are noticed any more.
Now the driver should be ok for multi core as well.

Regards,
Dmitry

Dmitry Kasatkin (11):
  omap-sham: remove extra reference
  omap-sham: remove unused code
  omap-sham: replace flags bit mask with bit number
  omap-sham: replace flags operation with atomic bit operations
  omap-sham: move some flags to device context
  omap-sham: remove unnecessary local variable
  omap-sham: remove dedicated queue handling tasklet
  omap-sham: irq and dma handling changes
  omap-sham: irq handler must not clear error code
  omap-sham: clear device flags when finishing request
  omap-sham: do not schedule tasklet if there is no active requests

 drivers/crypto/omap-sham.c |  180 ++++++++++++++++++++++----------------------
 1 files changed, 90 insertions(+), 90 deletions(-)

-- 
1.7.4.1

