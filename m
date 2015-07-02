From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ARM: DTS: am437x-sk-evm: Use simple-card for audio support
Date: Thu, 2 Jul 2015 14:58:04 +0300
Message-ID: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

There is no reason to use the davinci-evm machine driver's compatible for audio
support since the setup is simple and the common simple-audio-card can handle it
just fine.
Also add McASP1 sleep pin configuration.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: DTS: am437x-sk-evm: Add sleep pin settings for mcasp1
  ARM: DTS: am437x-sk-evm: Switch using simple-audio-card for audio
    support

 arch/arm/boot/dts/am437x-sk-evm.dts | 42 +++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

-- 
2.4.5
