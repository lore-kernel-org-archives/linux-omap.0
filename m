From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] net: ethernet: ti: ale: ensure vlan/mdb deleted
 when no members
Date: Sat, 30 Nov 2019 09:46:06 -0800 (PST)
Message-ID: <20191130.094606.1605980362790188417.davem@davemloft.net>
References: <20191129175809.815-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191129175809.815-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, ilias.apalodimas@linaro.org, andrew@lunn.ch, nsekhar@ti.com, ivan.khoronzhuk@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 29 Nov 2019 19:58:09 +0200

> The recently updated ALE APIs cpsw_ale_del_mcast() and
> cpsw_ale_del_vlan_modify() have an issue and will not delete ALE entry even
> if VLAN/mcast group has no more members. Hence fix it here and delete ALE
> entry if !port_mask.
> 
> The issue affected only new cpsw switchdev driver.
> 
> Fixes: e85c14370783 ("net: ethernet: ti: ale: modify vlan/mdb api for switchdev")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied.
