From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 0/1] PLAT: OMAP: Add device configuration to support second
 HSMMC slot on OMAP 2430 and 3430 boards.
Date: Mon, 31 Mar 2008 16:06:19 -0400
Message-ID: <47F1443B.6010803@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:59928 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbYCaUGf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 16:06:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

Please, consider this new version of the patch instead of the previous
one [1].

If you take a good look, I was defining the OMAP_MMC2_INT macro with
INT_24XX_MMC_IRQ - the correct is INT_24XX_MMC2_IRQ.

Sorry, my bad. And thanks to Keppler for advise me.

BR,

Carlos.

[1] http://marc.info/?l=linux-omap&m=120696814316116&w=2

-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br

