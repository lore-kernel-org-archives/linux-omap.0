From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v2] net: ethernet: ti: cpsw-phy-sel: check
 bus_find_device() ret value
Date: Wed, 16 May 2018 14:13:32 -0400 (EDT)
Message-ID: <20180516.141332.138841350079205530.davem@davemloft.net>
References: <20180515233725.11882-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515233725.11882-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Tue, 15 May 2018 18:37:25 -0500

> This fixes klockworks warnings: Pointer 'dev' returned from call to
> function 'bus_find_device' at line 179 may be NULL and will be dereferenced
> at line 181.
> 
>     cpsw-phy-sel.c:179: 'dev' is assigned the return value from function 'bus_find_device'.
>     bus.c:342: 'bus_find_device' explicitly returns a NULL value.
>     cpsw-phy-sel.c:181: 'dev' is dereferenced by passing argument 1 to function 'dev_get_drvdata'.
>     device.h:1024: 'dev' is passed to function 'dev_get_drvdata'.
>     device.h:1026: 'dev' is explicitly dereferenced.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> [nsekhar@ti.com: add an error message, fix return path]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> v2: use %pOF

Applied, thank you.
