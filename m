From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/5] net: ethernet: ti: cpsw: combine budget and weight
 split and check
Date: Sat, 10 Dec 2016 17:30:44 -0500 (EST)
Message-ID: <20161210.173044.1580240100890445540.davem@davemloft.net>
References: <1481372630-14914-1-git-send-email-ivan.khoronzhuk@linaro.org>
        <1481372630-14914-4-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1481372630-14914-4-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: mugunthanvnm@ti.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Sat, 10 Dec 2016 14:23:48 +0200

> Re-split weight along with budget. It simplify code a little
> and update state after every rate change. Also it's necessarily
> to move arguments checks to this combined function. Replace
> maximum rate check for an interface on maximum possible rate.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied.
