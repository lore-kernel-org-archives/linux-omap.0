From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/3] pci_endpoint_test: Fix module removal/insertion cycle
Date: Wed, 11 Oct 2017 14:14:35 +0530
Message-ID: <20171011084438.8296-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

This series fixes module removal/insertion cycle of pci_endpoint_test.

Without this series, when trying to modprobe pci_endpoint_test after
rmmod pci_endpoint_test results in the following errors.

pci-endpoint-test 0000:01:00.0: BAR 0: can't reserve [mem 0x20204600-0x202046ff]
pci-endpoint-test 0000:01:00.0: Cannot obtain PCI resources
pci-endpoint-test: probe of 0000:01:00.0 failed with error -16

Kishon Vijay Abraham I (3):
  misc: pci_endpoint_test: Fix failure path return values in probe
  misc: pci_endpoint_test: Fix pci_endpoint_test not releasing resources
    on remove
  misc: pci_endpoint_test: Fix BUG_ON error during pci_disable_msi

 drivers/misc/pci_endpoint_test.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.11.0
