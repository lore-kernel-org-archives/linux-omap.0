From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: davinci_cpdma: make function
 cpdma_desc_pool_create static
Date: Fri, 22 Jun 2018 09:31:50 +0900 (KST)
Message-ID: <20180622.093150.372475753380132826.davem@davemloft.net>
References: <20180621171645.29734-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621171645.29734-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: colin.king@canonical.com
Cc: f.fainelli@gmail.com, ivan.khoronzhuk@linaro.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu, 21 Jun 2018 18:16:45 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The function cpdma_desc_pool_create is local to the source and does not
> need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> warning: symbol 'cpdma_desc_pool_create' was not declared. Should it
> be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks Colin.
