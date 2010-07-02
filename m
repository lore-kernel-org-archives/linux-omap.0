From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/13] OMAP4: hwmod: Enable omap_device build for OMAP4
Date: Fri, 2 Jul 2010 05:46:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007020545370.13691@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-9-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-650800317-1278071185=:13691"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40299 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab0GBLq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 07:46:26 -0400
In-Reply-To: <1277336563-24988-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-650800317-1278071185=:13691
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 23 Jun 2010, Kevin Hilman wrote:

> From: Rajendra Nayak <rnayak@ti.com>
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

This patch has been updated to include Beno=EEt's compile fix; revised patc=
h=20
below.


- Paul

OMAP4: hwmod: Enable omap_device build for OMAP4

From: Rajendra Nayak <rnayak@ti.com>

Enable omap_device layer support for OMAP4, so that drivers can
use them to enable/idle/shutdown devices.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |    2 +-
 arch/arm/plat-omap/Makefile  |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6c6d7c6..2fa3418 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -15,7 +15,7 @@ clock-common=09=09=09=09=3D clock.o clock_common_data.o \
=20
 obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common) $(hwmod-co=
mmon)
 obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(hwmod-co=
mmon)
-obj-$(CONFIG_ARCH_OMAP4) +=3D $(prcm-common)
+obj-$(CONFIG_ARCH_OMAP4) +=3D $(prcm-common) $(hwmod-common)
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
=20
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 98f0191..9405831 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) +=3D ocpi.o
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) +=3D omap_device.o
 obj-$(CONFIG_ARCH_OMAP3) +=3D omap_device.o
+obj-$(CONFIG_ARCH_OMAP4) +=3D omap_device.o
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
 obj-$(CONFIG_OMAP_IOMMU) +=3D iommu.o iovmm.o
--155748971-650800317-1278071185=:13691--
