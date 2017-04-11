From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/1] ARM: dts: dra7x-evm: Enable dual-role mode for USB1
Date: Tue, 11 Apr 2017 16:16:14 +0300
Message-ID: <1491916575-16023-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Dual role support for DWC3 is now in usb/next. With this patch we can
utilize dual-role mode on dra7x boards. Please queue for -next. Thanks.

cheers,
-roger

Roger Quadros (1):
  ARM: dts: dra7x-evm: Enable dual-role mode for USB1

 arch/arm/boot/dts/dra7-evm.dts          | 3 ++-
 arch/arm/boot/dts/dra72-evm-common.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
