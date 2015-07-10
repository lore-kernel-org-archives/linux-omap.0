From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] Drop owner assignment from i2c_driver (and platform left-overs)
Date: Fri, 10 Jul 2015 15:37:28 +0900
Message-ID: <1436510250-5633-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Hi,


The i2c drivers also do not have to set 'owner' field because
i2c_register_driver() will do it instead.

'owner' is removed from i2c drivers, which I was able to compile
with allyesconfig (arm, arm64, i386, x86_64, ppc64).
Only compile-tested.

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html


Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  video: fbdev: Drop owner assignment from i2c_driver
  video: fbdev: Drop owner assignment from platform_driver

 drivers/video/fbdev/omap2/displays-new/encoder-opa362.c | 1 -
 drivers/video/fbdev/ssd1307fb.c                         | 1 -
 2 files changed, 2 deletions(-)

-- 
1.9.1
