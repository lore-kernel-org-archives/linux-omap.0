From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 0/3] Use ARM SMC Calling Convention when OP-TEE is available
Date: Tue, 17 Dec 2019 18:47:42 -0500
Message-ID: <20191217234745.4434-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello all,

This is the reworked patch turned into a series to allow upstream kernels
to make use of OP-TEE on the OMAP2+ platform.

Thanks,
Andrew

Changes from v1:
 - Split into logical patches
 - Check for OP-TEE in DT only once
 - Check the OP-TEE node is "okay"

Andrew F. Davis (3):
  ARM: OMAP2+: Add omap_secure_init callback hook for secure
    initialization
  ARM: OMAP2+: Introduce check for OP-TEE in omap_secure_init()
  ARM: OMAP2+: Use ARM SMC Calling Convention when OP-TEE is available

 arch/arm/mach-omap2/common.h      |  2 +-
 arch/arm/mach-omap2/io.c          | 11 +++++++++
 arch/arm/mach-omap2/omap-secure.c | 41 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.h |  6 +++++
 arch/arm/mach-omap2/omap-smc.S    |  6 ++---
 5 files changed, 62 insertions(+), 4 deletions(-)

-- 
2.17.1
