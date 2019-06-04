From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] Add Mailbox support for TI K3 SoCs
Date: Tue, 4 Jun 2019 12:01:44 -0500
Message-ID: <20190604170146.12205-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Jassi,

The following series adds the support for the Mailbox IP present
within the Main NavSS module on the newer TI K3 AM65x and J721E SoCs.

The Mailbox IP is similar to the previous generation IP on OMAP SoCs
with a few differences:
 - Multiple IP instances from previous DRA7/AM57 family each form a
   cluster and are part of the same IP. The driver support will continue
   to be based on a cluster.
 - The IP is present within a Main NaVSS, and interrupts have to go
   through an Interrupt Router within Main NavSS before they reach the
   respective processor sub-system's interrupt controllers.
 - The register layout is mostly same, with difference in two registers

Support is added by enhancing the existing OMAP Mailbox driver to 
support the K3 IP using a new compatible. The driver also has to be
adjusted to deal with the 32-bit mailbox payloads vs the 64-bit 
pointers used by the Mailbox API on these Arm v8 platforms.

DT nodes will be posted separately once the binding is acked.

regards
Suman

Suman Anna (2):
  dt-bindings: mailbox: omap: Update bindings for TI K3 SoCs
  mailbox/omap: Add support for TI K3 SoCs

 .../bindings/mailbox/omap-mailbox.txt         | 59 ++++++++++++++++---
 drivers/mailbox/Kconfig                       |  2 +-
 drivers/mailbox/omap-mailbox.c                | 43 ++++++++------
 include/linux/omap-mailbox.h                  |  4 +-
 4 files changed, 80 insertions(+), 28 deletions(-)

-- 
2.21.0
