From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 0/4] Add AM437x RTC
Date: Thu, 5 Mar 2015 07:13:27 -0600
Message-ID: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36005 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbbCENOK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Mar 2015 08:14:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, KEERTHY <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>

Hi,
This series adds support for the rtc on am437x, as previously the hwmod
and dt entries were missing. The am43x-epos-evm requires special treatment
because the RTC gets disabled in hardware with no way to tell through
software so we add a ti,no-init dt flag for the hwmod layer so we can
avoid writing to the SYSCONFIG register and triggering an external abort.
If we use this flag for the am43x-epos-evm we can add the rtc as normal
to am437x-gp-evm. am437x-sk-evm already has the required dt entry in place. 

Regards,
Dave

Dave Gerlach (3):
  ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt property
  ARM: OMAP2+: AM43xx hwmod: Add RTC hwmod for AM43xx
  ARM: dts: am43x-epos-evm: Add rtc node with ti,no-init property

Keerthy (1):
  ARM: dts: am437x-gp-evm: Enable RTC

 Documentation/devicetree/bindings/arm/omap/omap.txt | 2 ++
 arch/arm/boot/dts/am437x-gp-evm.dts                 | 4 ++++
 arch/arm/boot/dts/am43x-epos-evm.dts                | 4 ++++
 arch/arm/mach-omap2/omap_hwmod.c                    | 7 ++++++-
 arch/arm/mach-omap2/omap_hwmod.h                    | 4 ++++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c          | 1 +
 6 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.3.0

