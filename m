From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH RESEND 0/2] mfd: twl6040: bulk access fix and pdmclk registration
Date: Wed, 31 Aug 2016 14:46:19 +0300
Message-ID: <20160831114621.6301-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

The two patch were part of a bigger series to support the external pdmclk clock
needed by the McPDM on OMAP4/5 [1].

The other patches have been applied, but the ASoC patch to actually use the
pdmclk needed to be reverted as the MFD parts were not taken.

[1] https://lkml.org/lkml/2016/5/18/299

Regards,
Peter
---
Peter Ujfalusi (2):
  mfd: twl6040: The chip does not support bulk access
  mfd: twl6040: Register child device for twl6040-pdmclk

 Documentation/devicetree/bindings/mfd/twl6040.txt | 1 +
 drivers/mfd/twl6040.c                             | 6 ++++++
 include/linux/mfd/twl6040.h                       | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

--
2.9.3
