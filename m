From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 16/19] net: ethernet: ti: cpsw: move common hw
 init code in separate func
Date: Tue, 23 Apr 2019 20:53:22 +0200
Message-ID: <20190423185322.GI28405@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-17-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556024950-20752-17-git-send-email-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 23, 2019 at 04:09:07PM +0300, Grygorii Strashko wrote:
> +	ret = cpsw_init_common(cpsw, ss_regs, ale_ageout,
> +			       (u32 __force)ss_res->start + CPSW2_BD_OFFSET,
> +			       descs_pool_size);

Hi Grygorii

Could you put it onto your TODO list to remove this nasty casting.

Thanks

      Andrew
