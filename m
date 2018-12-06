From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: Use of_node_name_eq for node name comparisons
Date: Wed, 05 Dec 2018 20:51:27 -0800 (PST)
Message-ID: <20181205.205127.959001731251775241.davem@davemloft.net>
References: <20181205195050.4759-16-robh@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205195050.4759-16-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com, grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Wed,  5 Dec 2018 13:50:32 -0600

> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
> 
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Wingman Kwok <w-kwok2@ti.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to net-next, thanks Rob.
