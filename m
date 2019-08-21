From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] net: cpsw: fix NULL pointer exception in the probe
 error path
Date: Wed, 21 Aug 2019 14:00:14 -0700 (PDT)
Message-ID: <20190821.140014.255300007478960933.davem@davemloft.net>
References: <20190821144123.22248-1-antoine.tenart@bootlin.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821144123.22248-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: antoine.tenart@bootlin.com
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com
List-Id: linux-omap@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Wed, 21 Aug 2019 16:41:23 +0200

> In certain cases when the probe function fails the error path calls
> cpsw_remove_dt() before calling platform_set_drvdata(). This is an
> issue as cpsw_remove_dt() uses platform_get_drvdata() to retrieve the
> cpsw_common data and leds to a NULL pointer exception. This patches
> fixes it by calling platform_set_drvdata() earlier in the probe.
> 
> Fixes: 83a8471ba255 ("net: ethernet: ti: cpsw: refactor probe to group common hw initialization")
> Reported-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied and queued up for -stable, thanks.
