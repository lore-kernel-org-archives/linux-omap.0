From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 3/4] ASoC: davinci-mcasp: Remove last reference to num-serializer in DT doc
Date: Wed, 23 Oct 2013 15:30:15 +0300
Message-ID: <88fa99eb10f10771a22678ce39333ea9389712c2.1382529191.git.jsarha@ti.com>
References: <cover.1382529191.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54209 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab3JWMae (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Oct 2013 08:30:34 -0400
In-Reply-To: <cover.1382529191.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, joelf@ti.com, tony@atomide.com, Jyri Sarha <jsarha@ti.com>

Remove last reference to num-serializer in davinci-mcasp devicetree
binding document.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |    1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 0aa416b..ed785b3 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -15,7 +15,6 @@ Required properties:
   	    IEC60958-1, and AES-3 formats.
 - tdm-slots : Slots for TDM operation. Indicates number of channels transmitted
   	      or received over one serializer.
-- num-serializer : Serializers used by McASP.
 - serial-dir : A list of serializer configuration. Each entry is a number
                indication for serializer pin direction.
                (0 - INACTIVE, 1 - TX, 2 - RX)
-- 
1.7.9.5

