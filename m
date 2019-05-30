From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: cpsw_ethtool: fix ethtool ring
 param set
Date: Thu, 30 May 2019 14:49:07 -0700 (PDT)
Message-ID: <20190530.144907.723803908854753596.davem@davemloft.net>
References: <20190529214753.21804-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190529214753.21804-1-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Thu, 30 May 2019 00:47:53 +0300

> Fixes: 37e2d99b59c4765112533a1d38174fea58d28a51 ("ethtool: Ensure new
> ring parameters are within bounds during SRINGPARAM")
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Please do not chop up Fixes: tags into multiple lines.

Please do not place an empty line between Fixes: and other tags,
they should all be together.

Thank you.
