From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] Add VTT regulators for DDR3 AMx3xx Boards
Date: Mon, 5 May 2014 14:58:27 -0500
Message-ID: <1399319909-53795-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The am335x-evmsk and am437x-gp-evm both have a gpio controlled regulator
for DDR3 VTT voltage. This is configured by boot loader and previously
just left at that but it is better to define a fixed regulator to control
the gpio so that the kernel is aware of it.

Previous discussion here [1].

Original am437x-gp-evm patch has been updated to reflect actual voltage
supplied by VTT regulator.

Regards,
Dave

[1] http://marc.info/?l=linux-omap&m=139819277623028&w=2

Dave Gerlach (2):
  ARM: dts: am437x-gp-evm: Add vtt_fixed regulator
  ARM: dts: am335x-evmsk: Add vtt_fixed regulator

 arch/arm/boot/dts/am335x-evmsk.dts  | 11 +++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts | 11 +++++++++++
 2 files changed, 22 insertions(+)

-- 
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
