From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] net: ethernet: ti: cpsw: fix tx vlan priority
 mapping
Date: Sun, 22 Apr 2018 14:56:03 -0400 (EDT)
Message-ID: <20180422.145603.2079222042973638224.davem@davemloft.net>
References: <1524167349-11004-1-git-send-email-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524167349-11004-1-git-send-email-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Thu, 19 Apr 2018 22:49:09 +0300

> The CPDMA_TX_PRIORITY_MAP in real is vlan pcp field priority mapping
> register and basically replaces vlan pcp field for tagged packets.
> So, set it to be 1:1 mapping. Otherwise, it will cause unexpected
> change of egress vlan tagged packets, like prio 2 -> prio 5.
> 
> Fixes: e05107e6b747 ("net: ethernet: ti: cpsw: add multi queue support")
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

Applied and queud up for -stable.
