From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] net: ethernet: ti: cpsw: cpsw_ale_set_vlan_untag() can
 be static
Date: Sun, 27 Oct 2019 18:02:06 +0800
Message-ID: <20191027100206.hjpsvdjeophopzmg@4978f4969bb8>
References: <20191024100914.16840-2-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191024100914.16840-2-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@lists.01.org, netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org


Fixes: 7e6abf354826 ("net: ethernet: ti: cpsw: allow untagged traffic on host port")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 cpsw_ale.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 23e7714ebee7b..3ed5ad372c1cb 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -417,8 +417,8 @@ static void cpsw_ale_set_vlan_mcast(struct cpsw_ale *ale, u32 *ale_entry,
 	writel(unreg_mcast, ale->params.ale_regs + ALE_VLAN_MASK_MUX(idx));
 }
 
-void cpsw_ale_set_vlan_untag(struct cpsw_ale *ale, u32 *ale_entry,
-			     u16 vid, int untag_mask)
+static void cpsw_ale_set_vlan_untag(struct cpsw_ale *ale, u32 *ale_entry,
+				    u16 vid, int untag_mask)
 {
 	cpsw_ale_set_vlan_untag_force(ale_entry,
 				      untag_mask, ale->vlan_field_bits);
