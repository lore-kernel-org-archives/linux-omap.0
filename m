From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v3 0/2]: Add legacy display init for IGEPv2 board
Date: Wed,  9 Oct 2013 11:19:17 +0200
Message-ID: <1381310359-20668-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:42125 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab3JIJUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 05:20:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomy Valkeinen <tomi.valkeinen@ti.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

Hi Tony,

This is a third version of the patch-set that adds legacy display init
for IGEPv2 boards that is needed to have display working when using DT.

You said to already had queued v2 on your omap-for-v3.13/quirk branch
but there were a few issues pointed out by Tomi Valkeinen that I addresed
here so it would be great if you can drop that patch and apply the following:

[PATCH v3 1/2] ARM: OMAP2+: pdata-quirks: add legacy display init for IGEPv2 board
[PATCH v3 2/2] ARM: OMAP: igep0020: use display init from dss-common

If it is already too late then I can repost these as an incremental patch.

Thanks a lot and best regards,
Javier
