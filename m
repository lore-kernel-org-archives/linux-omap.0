From: "Premi, Sanjeev" <premi@ti.com>
Subject: hwmod: multi-omap: disabling smartreflex on AM3517
Date: Tue, 15 Feb 2011 17:21:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248A017D9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54334 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab1BOLvO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 06:51:14 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1FBpB9p020936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 05:51:13 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1FBpAI3022492
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 17:21:10 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>

AM3517 doesn't support SmartReflex.

However, these HWMODS are defined in omap3xxxx_hwmods[]:
	&omap34xx_sr1_hwmod,
	&omap34xx_sr2_hwmod,
	&omap36xx_sr1_hwmod,
	&omap36xx_sr2_hwmod,

(similar definition in l4_slaves as well)

This leads to crash when booting the kernel on AM3517EVM during
_setup().

I see the field .omap_chip being initialized; but not used.

If I were to use this - along with cpu_is_omap3517(), I would need
to define a new flag e.g. CHIP_IS_AM3517 and add it to almost all
devices defined in omap_hwmod_3xxx_data.c.

Before going all out on making changes, wanted to check if there is
a better way. Has this/similar possibility been considered earlier?

Best regards,
Sanjeev

