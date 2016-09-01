From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/3] ARM: dts: Add operating-points-v2 tables for TI platforms
Date: Wed, 31 Aug 2016 21:48:13 -0500
Message-ID: <20160901024816.32390-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
This is v2 of the series to add operating-points-v2 tables for am335x,
am437x, dra7, and am57x platforms, but really just updates the already
merged v1 found here [1].

It seems v1 was merged without the binding being finalized so this series
just updates the nodes that are already present in order to work with the
new bindings coming in v2 of the ti-cpufreq driver series which will follow
shortly.

Regards,
Dave

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430205.html

Dave Gerlach (3):
  ARM: dts: am33xx: Change operating-points-v2 table to am3352 version
  ARM: dts: am4372: Change operating-points-v2 table to am4372 version
  ARM: dts: dra7: Change operating-points-v2 table to dra7 version

 arch/arm/boot/dts/am33xx.dtsi | 2 +-
 arch/arm/boot/dts/am4372.dtsi | 2 +-
 arch/arm/boot/dts/dra7.dtsi   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
