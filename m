From: Dmitriy Chumak <dmytro.chumak@inobject.com>
Subject: sdio_writesb doesn't transfer data
Date: Wed, 28 May 2008 14:02:25 +0300
Message-ID: <200805281402.26024.dmytro.chumak@inobject.com>
Reply-To: dmytro.chumak@inobject.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kyiv.inobject.com ([62.221.40.190]:25975 "EHLO
	kyiv.inobject.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbYE1LC3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 07:02:29 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

hi *

I have a problem with sdio_writesb. When I call it I get no error in return 
code, but in function mmc_omap_irq (from drivers/mmc/host/omap_hsmmc.c) I get 
status 0x11. It means CC | DDIR. And because there is no TC in status, 
mmc_omap_xfer_done is not called, but I suppose that it should be called in 
case of sdio_writesb. Maybe someone could tell me what does DDIR, CC, TC and 
OD stand for (these are defines in drivers/mmc/host/omap_hsmmc.c)?

thanks
