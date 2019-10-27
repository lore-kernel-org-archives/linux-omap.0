From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] net: ethernet: ti: cpsw_port_offload_fwd_mark_update()
 can be static
Date: Sun, 27 Oct 2019 19:22:56 +0800
Message-ID: <20191027112256.rnfy3y572ovdmn3h@4978f4969bb8>
References: <20191024100914.16840-8-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191024100914.16840-8-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@lists.01.org, netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org


Fixes: 9da120bc2cdf ("net: ethernet: ti: introduce cpsw switchdev based driver part 2 - switch")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 cpsw_new.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index f3606ccc747f4..5ff2d72db34c5 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1441,7 +1441,7 @@ bool cpsw_port_dev_check(const struct net_device *ndev)
 	return false;
 }
 
-void cpsw_port_offload_fwd_mark_update(struct cpsw_common *cpsw)
+static void cpsw_port_offload_fwd_mark_update(struct cpsw_common *cpsw)
 {
 	int set_val = 0;
 	int i;
