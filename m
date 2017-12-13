From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 net-next] net: ethernet: ti: cpdma: correct error
 handling for chan create
Date: Wed, 13 Dec 2017 15:51:23 -0500 (EST)
Message-ID: <20171213.155123.2302738718764109294.davem@davemloft.net>
References: <1513112795-20045-1-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513112795-20045-1-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Tue, 12 Dec 2017 23:06:35 +0200

> It's not correct to return NULL when that is actually an error and
> function returns errors in any other wrong case. In the same time,
> the cpsw driver and davinci emac doesn't check error case while
> creating channel and it can miss actual error. Also remove WARNs
> replacing them on dev_err msgs.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied.
