From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] TI sysc driver updates for am335x and am437x
Date: Mon, 24 Sep 2018 15:44:41 -0700
Message-ID: <20180924224445.97239-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few updates for ti-sysc driver for am335x and am437x. I'll be
posting the related dts changes separately.

Based on testing with various devices, we can now also get rid of the
quirk flag for SYSC_QUIRK_RESOURCE_PROVIDER and make module names limited
to debug only except for few devices still using pm_runtime_irq_safe().

Regards,

Tony

Tony Lindgren (4):
  bus: ti-sysc: Defer suspend as needed
  bus: ti-sysc: Update revision masks to support am437x
  bus: ti-sysc: Detect more devices on am473x for debugging
  bus: ti-sysc: Detect devices on am335x when DEBUG is enabled

 drivers/bus/ti-sysc.c                 | 143 +++++++++++++++-----------
 include/linux/platform_data/ti-sysc.h |   1 -
 2 files changed, 85 insertions(+), 59 deletions(-)

-- 
2.19.0
