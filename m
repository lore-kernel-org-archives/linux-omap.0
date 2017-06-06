From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/5] mfd: Add a dependency on OF
Date: Tue, 6 Jun 2017 20:15:35 +0530
Message-ID: <1496760340-27959-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, milo.kim@ti.com, lee.jones@linaro.org
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Currently few of the drivers boot only via device tree hence add a
dependency on OF.

Signed-off-by: Keerthy <j-keerthy@ti.com> 

Keerthy (5):
  mfd: palmas: Add a dependency on OF
  mfd: tps65218: Add a dependency on OF
  mfd: tps65217: Add a dependency on OF
  mfd: lp873x: Add a dependency on OF
  mfd: lp3943: Add a dependency on OF

 drivers/mfd/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
1.9.1
