From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 0/2] mfd: twl4030-power: support ti,system-power-controller
Date: Wed, 17 Sep 2014 07:34:10 -0500
Message-ID: <1410957252-764-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This series adds ti,system-power-controller to Documentation and the
driver seperately as per maintainer preference.

Based on v3.17-rc1

Changes since V1: update in documentation, picked up Tony's ack for patch #2.

V1: http://marc.info/?l=devicetree&m=140977126218800&w=2

Nishanth Menon (2):
  Documentation: devicetree: mfd: twl4030-power: Use the standard
    'ti,system-power-controller' to mark power control
  mfd: twl4030-power: use 'ti,system-power-controller' as alternative
    way to support system power off

 .../devicetree/bindings/mfd/twl4030-power.txt      |    9 +++++++--
 drivers/mfd/twl4030-power.c                        |    3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
