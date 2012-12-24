From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: [PATCH 0/3] OMAP GPMC OneNAND DT bindings
Date: Sun, 23 Dec 2012 21:02:05 -0300
Message-ID: <CALF0-+VOjr6O=+EPFsav1jghfsp624H9w48+JP8_JQgFoAAt=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:38594 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab2LXACH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 19:02:07 -0500
Received: by mail-ia0-f170.google.com with SMTP id i1so5562711iaa.1
        for <linux-omap@vger.kernel.org>; Sun, 23 Dec 2012 16:02:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Daniel Mack <zonque@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, matthias.bgg@googlemail.com, jon-hunter@ti.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi everyone,

Just in case anyone wants to access his OneNAND device,
here's a little patchset. Feedback is more than welcome.

It's based on arm-soc/for-next with Daniel Mack's GPMC patches.

Ezequiel Garcia (3):
  mtd: omap-onenand: pass device_node in platform data
  arm: omap2: gpmc-onenand: drop __init annotation
  arm: omap2: gpmc: add DT bindings for OneNAND

 .../devicetree/bindings/mtd/gpmc-onenand.txt       |   44 ++++++++++++++++++++
 arch/arm/mach-omap2/gpmc-onenand.c                 |    2 +-
 arch/arm/mach-omap2/gpmc.c                         |   44 ++++++++++++++++++++
 drivers/mtd/onenand/omap2.c                        |    4 +-
 include/linux/platform_data/mtd-onenand-omap2.h    |    3 +
 5 files changed, 95 insertions(+), 2 deletions(-)

Regards,

-- 
    Ezequiel
