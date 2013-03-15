From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 49/50] staging: omap-thermal: remove TODO entry for exposed APIs
Date: Fri, 15 Mar 2013 09:00:37 -0400
Message-ID: <1363352438-15935-50-git-send-email-eduardo.valentin@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Not all APIs exposed today are used. However all unused APIs
will be required once the thermal layer allows IRQ based
policies.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/TODO |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/omap-thermal/TODO b/drivers/staging/omap-thermal/TODO
index 91e2070..d45f556 100644
--- a/drivers/staging/omap-thermal/TODO
+++ b/drivers/staging/omap-thermal/TODO
@@ -3,7 +3,6 @@ List of TODOs (by Eduardo Valentin)
 on omap-bandgap.c:
 - Test every exposed API to userland
 - Add support to hwmon
-- Review and revisit all API exposed
 - Revisit PM support
 - Revisit data structures and simplify them
 - Once SCM-core api settles, update this driver accordingly
-- 
1.7.7.1.488.ge8e1c

