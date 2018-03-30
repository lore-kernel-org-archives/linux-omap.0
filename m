From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv6 0/2] Motorola Droid 4 Audio Support
Date: Fri, 30 Mar 2018 14:58:22 +0200
Message-ID: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi,

This adds audio support to Motorola Droid 4. I dropped
all patches, that have been applied and collected all
Reviewed-by & Acked-by for the remaining ones. Also I
changed the binding to use relative paths.

-- Sebastian

Sebastian Reichel (2):
  dt-bindings: mfd: motorola-cpcap: document audio-codec
  mfd: motorola-cpcap: Add audio-codec support

 .../devicetree/bindings/mfd/motorola-cpcap.txt     | 42 ++++++++++++++++++
 drivers/mfd/motorola-cpcap.c                       | 51 +++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.16.2
