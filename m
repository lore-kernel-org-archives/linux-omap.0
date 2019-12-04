From: Baolin Wang <baolin.wang7@gmail.com>
Subject: [PATCH 0/3] Some improvements for OMAP hwspinlock
Date: Wed,  4 Dec 2019 17:31:28 +0800
Message-ID: <cover.1575451463.git.baolin.wang7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: baolin.wang7@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch set did some optimization for OMAP hwlock controller with
changing to use some devm_xxx APIs to simplify code.

Baolin Wang (3):
  hwspinlock: omap: Change to use devm_platform_ioremap_resource()
  hwspinlock: omap: Use devm_kzalloc() to allocate memory
  hwspinlock: omap: Use devm_hwspin_lock_register() to register hwlock
    controller

 drivers/hwspinlock/omap_hwspinlock.c |   45 ++++++++++------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

-- 
1.7.9.5
