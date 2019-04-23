From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 03/19] net: ethernet: ti: cpsw: drop
 CONFIG_TI_CPSW_ALE config option
Date: Tue, 23 Apr 2019 20:37:02 +0200
Message-ID: <20190423183702.GC28405@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-4-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556024950-20752-4-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 23, 2019 at 04:08:54PM +0300, Grygorii Strashko wrote:
> index 1142fcfce566..3ef5257c9bc7 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("TI CPSW ALE driver");

Hi Grygorii

If this is no longer a module, the MODULE_* macros don't make much
sense.

	Andrew
