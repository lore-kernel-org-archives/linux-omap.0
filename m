From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 1/2] net: ethernet: ti: cpsw_ale: use const for API having pointer on mac address
Date: Fri, 12 Oct 2018 18:28:14 +0300
Message-ID: <20181012152815.31320-2-ivan.khoronzhuk@linaro.org>
References: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

It allows to use function under callbacks with same const qualifier of
mac address for farther changes.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++++------
 drivers/net/ethernet/ti/cpsw_ale.h |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 5766225a4ce1..798c989d5d93 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -136,7 +136,7 @@ static inline void cpsw_ale_get_addr(u32 *ale_entry, u8 *addr)
 		addr[i] = cpsw_ale_get_field(ale_entry, 40 - 8*i, 8);
 }
 
-static inline void cpsw_ale_set_addr(u32 *ale_entry, u8 *addr)
+static inline void cpsw_ale_set_addr(u32 *ale_entry, const u8 *addr)
 {
 	int i;
 
@@ -175,7 +175,7 @@ static int cpsw_ale_write(struct cpsw_ale *ale, int idx, u32 *ale_entry)
 	return idx;
 }
 
-static int cpsw_ale_match_addr(struct cpsw_ale *ale, u8 *addr, u16 vid)
+static int cpsw_ale_match_addr(struct cpsw_ale *ale, const u8 *addr, u16 vid)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS];
 	int type, idx;
@@ -309,7 +309,7 @@ static inline void cpsw_ale_set_vlan_entry_type(u32 *ale_entry,
 	}
 }
 
-int cpsw_ale_add_ucast(struct cpsw_ale *ale, u8 *addr, int port,
+int cpsw_ale_add_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
@@ -336,7 +336,7 @@ int cpsw_ale_add_ucast(struct cpsw_ale *ale, u8 *addr, int port,
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_add_ucast);
 
-int cpsw_ale_del_ucast(struct cpsw_ale *ale, u8 *addr, int port,
+int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
@@ -352,7 +352,7 @@ int cpsw_ale_del_ucast(struct cpsw_ale *ale, u8 *addr, int port,
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast);
 
-int cpsw_ale_add_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
+int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid, int mcast_state)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
@@ -386,7 +386,7 @@ int cpsw_ale_add_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_add_mcast);
 
-int cpsw_ale_del_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
+int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index d4fe9016429b..cd07a3e96d57 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -105,13 +105,13 @@ void cpsw_ale_start(struct cpsw_ale *ale);
 void cpsw_ale_stop(struct cpsw_ale *ale);
 
 int cpsw_ale_flush_multicast(struct cpsw_ale *ale, int port_mask, int vid);
-int cpsw_ale_add_ucast(struct cpsw_ale *ale, u8 *addr, int port,
+int cpsw_ale_add_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
-int cpsw_ale_del_ucast(struct cpsw_ale *ale, u8 *addr, int port,
+int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid);
-int cpsw_ale_add_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
+int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid, int mcast_state);
-int cpsw_ale_del_mcast(struct cpsw_ale *ale, u8 *addr, int port_mask,
+int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid);
 int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 			int reg_mcast, int unreg_mcast);
-- 
2.17.1
