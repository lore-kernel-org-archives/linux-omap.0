From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 13/20] net: ethernet: ti: davinci_mdio: use
 devm_ioremap()
Date: Sat, 27 Apr 2019 00:12:32 +0200
Message-ID: <20190426221232.GF23059@lunn.ch>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
 <1556298762-8632-14-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556298762-8632-14-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 26, 2019 at 08:12:35PM +0300, Grygorii Strashko wrote:
> The Davinci MDIO in most of the case implemented as module inside of TI
> CPSW subsystem and fully depends on CPSW to be enabled, but historically
> it's implemented as separate Platform device/driver and defined in DT files
> in two ways:
> - as standalone node
> - as child node of CPSW subsystem.
> 
> In later case it's required to split CPSW subsystem "reg" property to
> exclude MDIO I/O range which is not useful.
> 
> Hence, replace devm_ioremap_resource() with devm_ioremap() to allow define
> full I/O range in parent CPSW subsystem without spliting.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
