From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/5] arm: dts: complete dm816x device tree
Date: Thu, 12 Nov 2015 15:07:25 +0100
Message-ID: <56449D1D.4030803@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

In order to fix support for the dm816x platform, add missing bits in
the dm816x dtsi and cleanup OCP.

The last patch adds support for the omap4-hwspinlock.

v2: add ocp hwmod cleanup

Neil Armstrong (5):
  arm: dts: add dm816x missing #mbox-cells
  arm: dts: add dm816x missing spi DT dma handles
  arm: dts: add dm816x pwm property to timers
  arm: dts: remove dm816x invalid DT l3_main hwmod
  arm: dts: Add omap4-hwspinlock support in dm816x

 arch/arm/boot/dts/dm816x.dtsi | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
