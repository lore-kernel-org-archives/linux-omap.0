From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] ARM: dra7: Enable Errata i877
Date: Thu, 3 Mar 2016 14:12:03 +0530
Message-ID: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series enables Errata i877 for all DRA7 platforms. The public errata
documentation can be found here[1].

[1] http://www.ti.com/lit/er/sprz429h/sprz429h.pdf

Lokesh Vutla (1):
  ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property

Mugunthan V N (1):
  ARM: dts: dra7: do not gate cpsw clock due to errata i877

 Documentation/devicetree/bindings/arm/omap/omap.txt |  1 +
 arch/arm/boot/dts/dra7.dtsi                         | 10 ++++++++++
 arch/arm/mach-omap2/omap_hwmod.c                    |  9 ++++++++-
 arch/arm/mach-omap2/omap_hwmod.h                    |  3 +++
 4 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
