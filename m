From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel
 driver
Date: Wed, 20 Feb 2019 12:33:26 -0800
Message-ID: <20190220203326.GT15711@atomide.com>
References: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
 <1550676319-6440-7-git-send-email-grygorii.strashko@ti.com>
 <20190220.112244.1206973642383679896.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220.112244.1206973642383679896.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: grygorii.strashko@ti.com, kishon@ti.com, robh+dt@kernel.org, netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* David Miller <davem@davemloft.net> [190220 19:23]:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> Date: Wed, 20 Feb 2019 17:25:19 +0200
> 
> > Deprecate cpsw-phy-sel driver as it's been replaced with new
> > TI phy-gmii-sel PHY driver.
> > 
> > Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks for the ack, but actually I'd prefer you to pick
this patch at some future date. I suggest Grygorii just
repost this one after v5.1-rc1.

This way I can keep my last pending v5.1 branch limited
to dts changes to make the arm-soc life easier.

Regards,

Tony
