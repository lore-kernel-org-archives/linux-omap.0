From: Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 0/2] cpts fixes for v3.8-rc2
Date: Mon, 24 Dec 2012 08:19:08 +0100
Message-ID: <cover.1356331925.git.richardcochran@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:36563 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab2LXHTV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Dec 2012 02:19:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, David Miller <davem@davemloft.net>, Cyril Chemparathy <cyril@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

Changed in v2:
Use clk_prepare_enable instead of clk_prepare + clk_enable.

The new cpts driver has two small issues, but it otherwise seems to be
working in -rc1.

Thanks,
Richard

Richard Cochran (2):
  cpts: fix build error by removing useless code.
  cpts: fix a run time warn_on.

 drivers/net/ethernet/ti/cpts.c |    3 +--
 drivers/net/ethernet/ti/cpts.h |    1 -
 2 files changed, 1 insertions(+), 3 deletions(-)

-- 
1.7.2.5

