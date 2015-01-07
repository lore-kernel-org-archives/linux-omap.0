From: Suman Anna <s-anna@ti.com>
Subject: [RFC PATCH 2/3] core: platform: fix an invalid kfree during of_platform_depopulate
Date: Wed, 7 Jan 2015 11:30:53 -0600
Message-ID: <1420651854-17768-3-git-send-email-s-anna@ti.com>
References: <1420651854-17768-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420651854-17768-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pawel Moll <pawel.moll@arm.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Felipe Balbi <balbi@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Drivers can use of_platform_populate() to create platform devices
for children of the device main node, and a complementary API
of_platform_depopulate() is provided to delete these child devices.
Any platform_data supplied for the OF devices through auxdata lookup
data is populated directly in the device's platform_data field, unlike
those created using platform API. The of_platform_depopulate()
leverages the platform code for cleanup, and this will result in a
kernel oops due to an invalid kfree on this direct populated
platform_data.

Fix this by resetting the platform data for OF devices during
platform device cleanup.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/base/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9421fed40905..129e69c8c894 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -200,6 +200,8 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
+	if (pa->pdev.dev.of_node)
+		pa->pdev.dev.platform_data = NULL;
 	of_device_node_put(&pa->pdev.dev);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
-- 
2.2.1
