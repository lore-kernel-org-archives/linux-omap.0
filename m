From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/2] arm: dts: add support for am437x sk
Date: Mon, 23 Jun 2014 13:20:57 -0500
Message-ID: <1403547659-24558-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, r.sricharan-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

here's v3 of am437x sk support. Patches tested on top of next-20140617.

Note that this series was tested with the following extra patches:

http://marc.info/?l=linux-omap&m=140299431732700&w=2
http://marc.info/?l=linux-omap&m=140300146503126&w=2
http://marc.info/?l=linux-omap&m=140299231232123
http://marc.info/?l=linux-omap&m=140310472709968&w=2
http://marc.info/?l=linux-omap&m=140310471409959&w=2

A branch is also available with all these patches at [1].

[1] http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=am437x-starterkit

Felipe Balbi (2):
  arm: dts: am4372: let boards access all nodes through phandles
  arm: dts: add support for AM437x StarterKit

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am4372.dtsi                      |   8 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                | 613 +++++++++++++++++++++
 4 files changed, 621 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/am437x-sk-evm.dts

-- 
2.0.0.390.gcb682f8

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
