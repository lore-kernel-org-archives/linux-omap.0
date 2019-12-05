From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix extra rx interrupt
Date: Thu, 05 Dec 2019 12:42:25 -0800 (PST)
Message-ID: <20191205.124225.1227757906747730493.davem@davemloft.net>
References: <20191205151817.1076-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205151817.1076-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Thu, 5 Dec 2019 17:18:17 +0200

> This is an old issue, but I can't specify Fixes tag.

This is never true, there is always an appropriate Fixes: tag
even it means specifying the tag that created Linus's GIT repo.

> And, unfortunatelly,
> it can't be backported as is even in v5.4.

This I always don't understand.

You must elaborate and specify a Fixes: tag.
