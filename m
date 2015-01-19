From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Few omap2plus_defconfig changes to make more boards usable
Date: Mon, 19 Jan 2015 10:15:55 -0800
Message-ID: <1421691358-14661-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33896 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751677AbbASSTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2015 13:19:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi,

Let's add davinci_emac, and fix the NOR configuration. And let's also
add pcf857x as a loadable module.

Regards,

Tony


Tony Lindgren (3):
  ARM: omap2plus_defconfig: Enable support for davinci_emac
  ARM: omap2plus_defconfig: Enable pcf857x
  ARM: omap2plus_defconfig: Add NOR flash support

 arch/arm/configs/omap2plus_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.1.4

