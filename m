From: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] DMM DT adaptation
Date: Mon, 16 Sep 2013 15:00:13 +0530
Message-ID: <1379323815-14130-1-git-send-email-archit@ti.com>
References: <1379063679-4869-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379063679-4869-1-git-send-email-archit-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The DMM/Tiler block can used by omapdrm to allocate frame buffers. With the
removal of address and irq data from the omap4 hwmods, the probe of DMM driver
fails and omapdrm isn't able to utilize the DMM hardware.

Add DMM bindings for omap4 and omap5.

Changes in v2:
- No changes, split out into a separate series containing only DT related parts.

Archit Taneja (2):
  arm: dts: omap4+: Add DMM bindings
  drm: omap: Enable DT support for DMM

 Documentation/devicetree/bindings/arm/omap/dmm.txt | 17 +++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |  7 +++++++
 arch/arm/boot/dts/omap5.dtsi                       |  7 +++++++
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           | 11 +++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/dmm.txt

-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
