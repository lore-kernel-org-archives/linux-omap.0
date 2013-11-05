From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RESEND] arm: omap2plus_defconfig: enable AM33xx SOC EVM audio
Date: Tue, 5 Nov 2013 10:42:37 +0200
Message-ID: <cover.1383639261.git.jsarha@ti.com>
References: <7460251f6a5b21ca843c652a35dfb042a3c54b42.1382529191.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41924 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab3KEImo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Nov 2013 03:42:44 -0500
In-Reply-To: <7460251f6a5b21ca843c652a35dfb042a3c54b42.1382529191.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: Jyri Sarha <jsarha@ti.com>

Hi Tony,
The audio support for am335x-emv and am335x-evmsk has been merged:
http://www.spinics.net/lists/linux-omap/msg99282.html
http://www.spinics.net/lists/linux-omap/msg99135.html

Best regards,
Jyri

Jyri Sarha (1):
  arm: omap2plus_defconfig: enable AM33xx SOC EVM audio

 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

-- 
1.7.9.5

