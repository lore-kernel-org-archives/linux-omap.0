From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 03/11] net: ethernet: ti: cpsw: ale: add functions to modify VLANs/MDBs
Date: Thu, 25 Apr 2019 01:24:19 +0300
Message-ID: <1556144667-27997-4-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

A following patch introduces switchdev functionality. Add functions
to cpsw ALE engine to modify VLANs/MDBs

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 179 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/ti/cpsw_ale.h |  10 ++
 2 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index d09768368dbd..add3f6e4917b 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -400,6 +400,45 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 	return 0;
 }
 
+static int cpsw_ale_read_mc(struct cpsw_ale *ale, u8 *addr, int flags, u16 vid)
+{
+	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
+	int idx;
+
+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
+	if (idx >= 0)
+		cpsw_ale_read(ale, idx, ale_entry);
+
+	return cpsw_ale_get_port_mask(ale_entry, ale->port_mask_bits);
+}
+
+int cpsw_ale_mcast_add_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
+			      int flags, u16 vid, int mcast_state)
+{
+	int mcast_members, ret;
+
+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) | port_mask;
+	ret = cpsw_ale_add_mcast(ale, addr, mcast_members, flags, vid,
+				 mcast_state);
+
+	return ret;
+}
+
+int cpsw_ale_mcast_del_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
+			      int flags, u16 vid)
+{
+	int mcast_members, ret;
+	int idx;
+
+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) & ~port_mask;
+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
+	if (idx < 0)
+		return 0;
+	ret = cpsw_ale_del_mcast(ale, addr, mcast_members, flags, vid);
+
+	return ret;
+}
+
 /* ALE NetCP NU switch specific vlan functions */
 static void cpsw_ale_set_vlan_mcast(struct cpsw_ale *ale, u32 *ale_entry,
 				    int reg_mcast, int unreg_mcast)
@@ -415,6 +454,52 @@ static void cpsw_ale_set_vlan_mcast(struct cpsw_ale *ale, u32 *ale_entry,
 	writel(unreg_mcast, ale->params.ale_regs + ALE_VLAN_MASK_MUX(idx));
 }
 
+static int cpsw_ale_read_untagged(struct cpsw_ale *ale, u16 vid)
+{
+	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
+	int idx;
+
+	idx = cpsw_ale_match_vlan(ale, vid);
+	if (idx >= 0)
+		cpsw_ale_read(ale, idx, ale_entry);
+
+	return cpsw_ale_get_vlan_untag_force(ale_entry, ale->vlan_field_bits);
+}
+
+/* returns mask of current members for specificed vlan */
+static int cpsw_ale_read_vlan_members(struct cpsw_ale *ale, u16 vid)
+{
+	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
+	int idx;
+
+	idx = cpsw_ale_match_vlan(ale, vid);
+	if (idx >= 0)
+		cpsw_ale_read(ale, idx, ale_entry);
+
+	return cpsw_ale_get_vlan_member_list(ale_entry, ale->vlan_field_bits);
+}
+
+/* returns mask of registered/unregistered multicast registration */
+static int cpsw_ale_read_reg_unreg_mc(struct cpsw_ale *ale, u16 vid, bool unreg)
+{
+	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
+	int idx;
+	int ret;
+
+	idx = cpsw_ale_match_vlan(ale, vid);
+	if (idx >= 0)
+		cpsw_ale_read(ale, idx, ale_entry);
+
+	if (unreg)
+		ret = cpsw_ale_get_vlan_unreg_mcast(ale_entry,
+						    ale->vlan_field_bits);
+	else
+		ret = cpsw_ale_get_vlan_reg_mcast(ale_entry,
+						  ale->vlan_field_bits);
+
+	return ret;
+}
+
 int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 		      int reg_mcast, int unreg_mcast)
 {
@@ -452,6 +537,11 @@ int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 
 int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 {
+	int reg_mcast =
+		cpsw_ale_read_reg_unreg_mc(ale, vid, 0) & port_mask;
+	int unreg_mcast =
+		cpsw_ale_read_reg_unreg_mc(ale, vid, 1) & port_mask;
+	int untag = cpsw_ale_read_untagged(ale, vid) & port_mask;
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
 	int idx;
 
@@ -461,16 +551,101 @@ int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 
 	cpsw_ale_read(ale, idx, ale_entry);
 
-	if (port_mask)
+	if (port_mask) {
+		cpsw_ale_set_vlan_untag_force(ale_entry, untag,
+					      ale->vlan_field_bits);
+		if (!ale->params.nu_switch_ale) {
+			cpsw_ale_set_vlan_reg_mcast(ale_entry, reg_mcast,
+						    ale->vlan_field_bits);
+			cpsw_ale_set_vlan_unreg_mcast(ale_entry, unreg_mcast,
+						      ale->vlan_field_bits);
+		} else {
+			cpsw_ale_set_vlan_mcast(ale, ale_entry, reg_mcast,
+						unreg_mcast);
+		}
 		cpsw_ale_set_vlan_member_list(ale_entry, port_mask,
 					      ale->vlan_field_bits);
-	else
+	} else {
 		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
+	}
 
 	cpsw_ale_write(ale, idx, ale_entry);
+
 	return 0;
 }
 
+int cpsw_ale_vlan_add_modify(struct cpsw_ale *ale, u16 vid, int port_mask,
+			     int untag_mask, int reg_mask, int unreg_mask)
+{
+	int ret = 0;
+	int vlan_members = cpsw_ale_read_vlan_members(ale, vid) & ~port_mask;
+	int reg_mcast_members =
+		cpsw_ale_read_reg_unreg_mc(ale, vid, 0) & ~port_mask;
+	int unreg_mcast_members =
+		cpsw_ale_read_reg_unreg_mc(ale, vid, 1) & ~port_mask;
+	int untag_members = cpsw_ale_read_untagged(ale, vid) & ~port_mask;
+
+	vlan_members |= port_mask;
+	untag_members |= untag_mask;
+	reg_mcast_members |= reg_mask;
+	unreg_mcast_members |= unreg_mask;
+
+	ret = cpsw_ale_add_vlan(ale, vid, vlan_members, untag_members,
+				reg_mcast_members, unreg_mcast_members);
+	if (ret) {
+		dev_err(ale->params.dev, "Unable to add vlan\n");
+		return ret;
+	}
+	dev_dbg(ale->params.dev, "port mask 0x%x untag 0x%x\n", vlan_members,
+		untag_mask);
+
+	return ret;
+}
+
+int cpsw_ale_vlan_del_modify(struct cpsw_ale *ale, u16 vid, int port_mask)
+{
+	int ret = 0;
+	int vlan_members;
+
+	vlan_members = cpsw_ale_read_vlan_members(ale, vid);
+	vlan_members &= ~port_mask;
+
+	ret = cpsw_ale_del_vlan(ale, vid, vlan_members);
+	if (ret) {
+		dev_err(ale->params.dev, "Unable to del vlan\n");
+		return ret;
+	}
+	dev_dbg(ale->params.dev, "port mask 0x%x\n", port_mask);
+
+	return ret;
+}
+
+void cpsw_ale_set_unreg_mcast(struct cpsw_ale *ale, int unreg_mcast_mask,
+			      bool add)
+{
+	u32 ale_entry[ALE_ENTRY_WORDS];
+	int unreg_members = 0;
+	int type, idx;
+
+	for (idx = 0; idx < ale->params.ale_entries; idx++) {
+		cpsw_ale_read(ale, idx, ale_entry);
+		type = cpsw_ale_get_entry_type(ale_entry);
+		if (type != ALE_TYPE_VLAN)
+			continue;
+
+		unreg_members =
+			cpsw_ale_get_vlan_unreg_mcast(ale_entry,
+						      ale->vlan_field_bits);
+		if (add)
+			unreg_members |= unreg_mcast_mask;
+		else
+			unreg_members &= ~unreg_mcast_mask;
+		cpsw_ale_set_vlan_unreg_mcast(ale_entry, unreg_members,
+					      ale->vlan_field_bits);
+		cpsw_ale_write(ale, idx, ale_entry);
+	}
+}
+
 void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS];
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 8a0d25950dc1..b5ac8cc7c677 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -116,4 +116,14 @@ int cpsw_ale_control_set(struct cpsw_ale *ale, int port,
 			 int control, int value);
 void cpsw_ale_dump(struct cpsw_ale *ale, u32 *data);
 
+int cpsw_ale_vlan_add_modify(struct cpsw_ale *ale, u16 vid, int port_mask,
+			     int untag_mask, int reg_mcast, int unreg_mcast);
+int cpsw_ale_vlan_del_modify(struct cpsw_ale *ale, u16 vid, int port_mask);
+int cpsw_ale_mcast_add_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
+			      int flags, u16 vid, int mcast_state);
+int cpsw_ale_mcast_del_modify(struct cpsw_ale *ale, u8 *addr, int port,
+			      int flags, u16 vid);
+void cpsw_ale_set_unreg_mcast(struct cpsw_ale *ale, int unreg_mcast_mask,
+			      bool add);
+
 #endif
-- 
2.17.1
