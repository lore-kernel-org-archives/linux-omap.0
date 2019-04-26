From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 05/20] net: ethernet: ti: cpsw: use local var
 dev in probe
Date: Sat, 27 Apr 2019 00:10:28 +0200
Message-ID: <20190426221028.GE23059@lunn.ch>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
 <1556298762-8632-6-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556298762-8632-6-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 26, 2019 at 08:12:27PM +0300, Grygorii Strashko wrote:
> Use local variable struct device *dev in probe to simplify code.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> changes in v2:
>  - fixed dev variable alignment

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
