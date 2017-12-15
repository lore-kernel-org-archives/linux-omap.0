From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] ARM: dts: Some am43x fixes
Date: Fri, 15 Dec 2017 11:16:41 -0600
Message-ID: <20171215171643.8345-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
This series has two fixes for am43x based platforms. First patch disables OPP50
on am437x-idk-evm which the board supply does not support. Second patch is for
am43x-epos-evm and adds dcdc2 regulator as the missing cpu0-supply which
enables CPUFreq on this platform.

Regards,
Dave

Dave Gerlach (2):
  ARM: dts: am437x-idk-evm: Disable OPP50 for MPU
  ARM: dts: am43x-epos-evm: Hook dcdc2 as the cpu0-supply

 arch/arm/boot/dts/am437x-idk-evm.dts | 14 ++++++++++++++
 arch/arm/boot/dts/am43x-epos-evm.dts |  4 ++++
 2 files changed, 18 insertions(+)

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
