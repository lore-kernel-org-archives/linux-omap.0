From: Furquan Shaikh <furquan@chromium.org>
Subject: [PATCH 5/7] device property: Export dev_fwnode
Date: Tue, 24 Jan 2017 16:06:39 -0800
Message-ID: <20170125000641.25520-6-furquan@chromium.org>
References: <20170125000641.25520-1-furquan@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125000641.25520-1-furquan@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Furquan Shaikh <furquan@chromium.org>
List-Id: linux-omap@vger.kernel.org

Export dev_fwnode so that it can be used by other drivers like regulator.

Signed-off-by: Furquan Shaikh <furquan@chromium.org>
---
 drivers/base/property.c  | 3 ++-
 include/linux/property.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 3556c9fbdbf7..39eaeec0f0ea 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -182,11 +182,12 @@ static int pset_prop_read_string(struct property_set *pset,
 	return 0;
 }
 
-static inline struct fwnode_handle *dev_fwnode(struct device *dev)
+struct fwnode_handle *dev_fwnode(struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
 		&dev->of_node->fwnode : dev->fwnode;
 }
+EXPORT_SYMBOL_GPL(dev_fwnode);
 
 /**
  * device_property_present - check if a property of a device is present
diff --git a/include/linux/property.h b/include/linux/property.h
index 856e50b2140c..9e2b7e1416cd 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -49,6 +49,7 @@ int device_property_read_string(struct device *dev, const char *propname,
 int device_property_match_string(struct device *dev,
 				 const char *propname, const char *string);
 
+struct fwnode_handle *dev_fwnode(struct device *dev);
 bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname);
 int fwnode_property_read_u8_array(struct fwnode_handle *fwnode,
 				  const char *propname, u8 *val,
-- 
2.11.0.483.g087da7b7c-goog
