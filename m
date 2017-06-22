From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] drivers: net: cpsw-common: Fix reading of mac address
 for am43 SoCs
Date: Thu, 22 Jun 2017 11:16:35 -0400 (EDT)
Message-ID: <20170622.111635.1512769508376550536.davem@davemloft.net>
References: <20170621084204.1512-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170621084204.1512-1-lokeshvutla@ti.com>
Sender: netdev-owner@vger.kernel.org
To: lokeshvutla@ti.com
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>
Date: Wed, 21 Jun 2017 14:12:04 +0530

> cpsw driver tries to get macid for am43xx SoCs using the compatible
> ti,am4372. But not all variants of am43x uses this complatible like
> epos evm uses ti,am438x. So use a generic compatible ti,am43 to get
> macid for all am43 based platforms.
> 
> Reviewed-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Applied.
