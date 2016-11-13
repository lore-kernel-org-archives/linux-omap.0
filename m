From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: davinci_cpdma: don't stop ctlr if
 it was stopped
Date: Sun, 13 Nov 2016 13:40:48 -0500 (EST)
Message-ID: <20161113.134048.861455528448275480.davem@davemloft.net>
References: <1478873447-1309-1-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1478873447-1309-1-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: mugunthanvnm@ti.com, grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Fri, 11 Nov 2016 16:10:47 +0200

> No need to stop ctlr if it was already stopped. It can cause timeout
> warns. Steps:
> - ifconfig eth0 down
> - ethtool -l eth0 rx 8 tx 8
> - ethtool -l eth0 rx 1 tx 1
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied.
