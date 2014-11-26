From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 0/3] remoteproc: Introduce wkup_m3_rproc driver
Date: Wed, 26 Nov 2014 15:27:09 -0600
Message-ID: <cover.1417029919.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
This patch series adds a wkup_m3_rproc driver for TI AM335x SoCs.
This family of SoCs contains an ARM Cortex M3 coprocessor that is
responsible for low-level power tasks that cannot be handled by the
main ARM Cortex A8 so firmware running from the CM3 can be used instead.
This driver handles loading of the firmware and reset of the CM3
once it is booted.

This patch was split off from v4 of the am335x suspend series, found
here [1]. Because of this it is a dependency for v5 of that series. I have
pushed a branch based on v3.18-rc6 containing all dependencies here [2] for
am33xx suspend for a higher level view of the entire series of patch sets.

This patch set depends on series "couple of generic remoteproc enhancements"
by Suman Anna found here [3] (Included already in previously mentioned branch)

Regards,
Dave

[1] http://www.spinics.net/lists/linux-omap/msg109331.html
[2] https://github.com/dgerlach/linux-pm/tree/rfc-pm-am335x-v3.18-rc6
[3] http://www.spinics.net/lists/arm-kernel/msg362961.html

Dave Gerlach (3):
  ARM: OMAP2+: Use pdata-quirks for wkup_m3 deassert_hardreset
  Documentation: dt: add ti,am3353-wkup-m3 bindings
  remoteproc: wkup_m3: Add wkup_m3 remote proc driver

 .../bindings/remoteproc/wkup_m3_rproc.txt          |  32 ++++
 arch/arm/mach-omap2/pdata-quirks.c                 |  13 ++
 drivers/remoteproc/Kconfig                         |  12 ++
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/wkup_m3_rproc.c                 | 175 +++++++++++++++++++++
 include/linux/platform_data/wkup_m3.h              |  23 +++
 6 files changed, 256 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/wkup_m3_rproc.txt
 create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
 create mode 100644 include/linux/platform_data/wkup_m3.h

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
