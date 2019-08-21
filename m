From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: ethernet: ti: use
 devm_platform_ioremap_resource() to simplify code
Date: Wed, 21 Aug 2019 13:42:37 -0700 (PDT)
Message-ID: <20190821.134237.1144802507635095173.davem@davemloft.net>
References: <20190821124850.9592-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821124850.9592-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuehaibing@huawei.com
Cc: grygorii.strashko@ti.com, ivan.khoronzhuk@linaro.org, andrew@lunn.ch, ynezz@true.cz, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 21 Aug 2019 20:48:50 +0800

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
