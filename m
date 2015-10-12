From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] Fix mmc/sd card detect gpio dt definition
Date: Mon, 12 Oct 2015 14:37:09 +0530
Message-ID: <1444640832-7396-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The mmc/sd card detect gpio definition in DT is not defined as
per hardware design, the card detect gpio is an active low
signal.

As per MMC/SD device tree binding documentation, the card detect
signal should be an active low signal and when ever a hardware is
designed with an active high card detect gpio then "cd-inverted"
dt parameter should be used to detect the actual status for the
card.

This was not captured till now because gpio is used as interrupt
source and mmc_rescan task is scheduled. The value of the gpio
is not used to determine card presence.

Pushed a branch [1] for testing and tested this patch series on
am335x bone black [2], am437x-gp evm [3] and dra72x evm [4].

[1]: git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git mmc-cd-gpio-fix
[2]: http://pastebin.ubuntu.com/12762164/
[3]: http://pastebin.ubuntu.com/12762168/
[4]: http://pastebin.ubuntu.com/12762169/

Mugunthan V N (3):
  ARM: DTS: am335x: fix cd-gpios definition as per hardware design and
    dt binding docs
  ARM: DTS: am43xx: fix cd-gpios definition as per hardware design and
    dt binding docs
  ARM: DTS: dra7xx: am57xx: fix cd-gpios definition as per hardware
    design and dt binding docs

 arch/arm/boot/dts/am335x-bone-common.dtsi | 3 +--
 arch/arm/boot/dts/am335x-evm.dts          | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts        | 2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts       | 2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts      | 2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts       | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts      | 2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts   | 2 +-
 arch/arm/boot/dts/dra7-evm.dts            | 2 +-
 arch/arm/boot/dts/dra72-evm.dts           | 2 +-
 10 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.6.1.133.gf5b6079

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
