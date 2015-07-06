From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] extcon: fix hang and extcon_get/set_cable_state().
Date: Mon, 6 Jul 2015 17:46:57 +0300
Message-ID: <1436194018-18696-2-git-send-email-rogerq@ti.com>
References: <1436194018-18696-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436194018-18696-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cw00.choi@samsung.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

Users of find_cable_index_by_name() will cause a kernel hang
as the while loop counter is never incremented and end condition
is never reached.

extcon_get_cable_state() and extcon_set_cable_state() are broken
because they use cable index instead of cable id. This causes
the first cable state (cable.0) to be always invalid in sysfs
or extcon_get_cable_state() users.

Introduce a new function find_cable_id_by_name() that fixes
both of the above issues.

Fixes: commit 73b6ecdb93e8 ("extcon: Redefine the unique id of supported external connectors without 'enum extcon' type")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/extcon/extcon.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 76157ab..868c6e2 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -124,15 +124,12 @@ static int find_cable_index_by_id(struct extcon_dev *edev, const unsigned int id
 	return -EINVAL;
 }
 
-static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
+static int find_cable_id_by_name(struct extcon_dev *edev, const char *name)
 {
-	unsigned int id = EXTCON_NONE;
+	unsigned int id = -EINVAL;
 	int i = 0;
 
-	if (edev->max_supported == 0)
-		return -EINVAL;
-
-	/* Find the the number of extcon cable */
+	/* Find the id of extcon cable */
 	while (extcon_name[i]) {
 		if (!strncmp(extcon_name[i], name, CABLE_NAME_MAX)) {
 			id = i;
@@ -140,6 +137,19 @@ static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
 		}
 	}
 
+	return id;
+};
+
+static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
+{
+	unsigned int id = EXTCON_NONE;
+
+	if (edev->max_supported == 0)
+		return -EINVAL;
+
+	/* Find the the number of extcon cable */
+	id = find_cable_id_by_name(edev, name);
+
 	if (id == EXTCON_NONE)
 		return -EINVAL;
 
@@ -228,9 +238,11 @@ static ssize_t cable_state_show(struct device *dev,
 	struct extcon_cable *cable = container_of(attr, struct extcon_cable,
 						  attr_state);
 
+	int i = cable->cable_index;
+
 	return sprintf(buf, "%d\n",
 		       extcon_get_cable_state_(cable->edev,
-					       cable->cable_index));
+					       cable->edev->supported_cable[i]));
 }
 
 /**
@@ -341,6 +353,9 @@ int extcon_get_cable_state_(struct extcon_dev *edev, const unsigned int id)
 {
 	int index;
 
+	if (id == EXTCON_NONE)
+		return -EINVAL;
+
 	index = find_cable_index_by_id(edev, id);
 	if (index < 0)
 		return index;
@@ -361,7 +376,7 @@ EXPORT_SYMBOL_GPL(extcon_get_cable_state_);
  */
 int extcon_get_cable_state(struct extcon_dev *edev, const char *cable_name)
 {
-	return extcon_get_cable_state_(edev, find_cable_index_by_name
+	return extcon_get_cable_state_(edev, find_cable_id_by_name
 						(edev, cable_name));
 }
 EXPORT_SYMBOL_GPL(extcon_get_cable_state);
@@ -380,6 +395,9 @@ int extcon_set_cable_state_(struct extcon_dev *edev, unsigned int id,
 	u32 state;
 	int index;
 
+	if (id == EXTCON_NONE)
+		return -EINVAL;
+
 	index = find_cable_index_by_id(edev, id);
 	if (index < 0)
 		return index;
@@ -404,7 +422,7 @@ EXPORT_SYMBOL_GPL(extcon_set_cable_state_);
 int extcon_set_cable_state(struct extcon_dev *edev,
 			const char *cable_name, bool cable_state)
 {
-	return extcon_set_cable_state_(edev, find_cable_index_by_name
+	return extcon_set_cable_state_(edev, find_cable_id_by_name
 					(edev, cable_name), cable_state);
 }
 EXPORT_SYMBOL_GPL(extcon_set_cable_state);
-- 
2.1.4
