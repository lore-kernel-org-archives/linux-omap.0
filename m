From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 03/20] net: ethernet: ti: cpsw: drop
 CONFIG_TI_CPSW_ALE config option
Date: Sat, 27 Apr 2019 00:08:21 +0200
Message-ID: <20190426220821.GC23059@lunn.ch>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
 <1556298762-8632-4-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556298762-8632-4-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 26, 2019 at 08:12:25PM +0300, Grygorii Strashko wrote:
> All TI drivers CPSW/NETCP can't work without ALE, hence simplify
> build of those drivers by always linking cpsw_ale and drop
> CONFIG_TI_CPSW_ALE config option.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
