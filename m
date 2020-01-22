From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] mfd: syscon: Use a unique name with regmap_config
Date: Wed, 22 Jan 2020 14:27:46 -0600
Message-ID: <20200122202746.30703-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, David Lechner <david@lechnology.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

The DT node full name is currently being used in regmap_config
which in turn is used to create the regmap debugfs directories.
This name however is not guaranteed to be unique and the regmap
debugfs registration can fail in the cases where the syscon nodes
have the same unit-address but are present in different DT node
hierarchies. Replace this logic using the syscon reg resource
address instead (inspired from logic used while creating platform
devices) to ensure a unique name is given for each syscon.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
Hi Lee,

I ran into this issue while trying to add multiple different instances
of the same IP using the ti-sysc node hierarchy on OMAP.

Not sure if you prefer to consider this as a fix or as an improvement.
So, haven't added a Fixes tag.

regards
Suman

 drivers/mfd/syscon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index e22197c832e8..8915b35eef4f 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -101,12 +101,13 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 		}
 	}
 
-	syscon_config.name = of_node_full_name(np);
+	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%llx", np, res.start);
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
+	kfree(syscon_config.name);
 	if (IS_ERR(regmap)) {
 		pr_err("regmap init failed\n");
 		ret = PTR_ERR(regmap);
-- 
2.23.0
