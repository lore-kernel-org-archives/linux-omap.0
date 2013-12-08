From: Jyri Sarha <jsarha@ti.com>
Subject: [RFC v2] Beaglebone-Black HDMI audio
Date: Sun, 8 Dec 2013 14:20:04 +0200
Message-ID: <cover.1386504183.git.jsarha@ti.com>
References: <cover.1384862950.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36838 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410Ab3LHMUl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Dec 2013 07:20:41 -0500
In-Reply-To: <cover.1384862950.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Changes since the first RFC version of the patch:
- Change sound node's compatible property
  form: "ti,am33xx-beaglebone-black" to "ti,am33xx-beaglebone-black-audio"

The patch has been rebased on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.13/dts

The associated code changes can be found here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-December/069897.html

Best regards,
Jyri

Jyri Sarha (1):
  ARM/dts: am335x-boneblack: Add HDMI audio support

 arch/arm/boot/dts/am335x-boneblack.dts |   52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

-- 
1.7.9.5

