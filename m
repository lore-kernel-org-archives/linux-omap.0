From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] net: ethernet: ti: cpsw: deprecate cpsw-phy-sel
 driver
Date: Thu, 21 Feb 2019 08:36:38 -0800
Message-ID: <20190221163638.GW15711@atomide.com>
References: <20190220203326.GT15711@atomide.com>
 <20190220.124155.2226787912266109280.davem@davemloft.net>
 <20190220210127.GU15711@atomide.com>
 <20190220.161831.2067856031892978.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220.161831.2067856031892978.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: grygorii.strashko@ti.com, kishon@ti.com, robh+dt@kernel.org, netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* David Miller <davem@davemloft.net> [190221 00:18]:
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 20 Feb 2019 13:01:27 -0800
> 
> > What I can do is set up a separate branch with just this
> > patch on top of the dts changes that the arm-soc guys can
> > then merge towards the end of the merge cycle. If that
> > works for you, let me know and I'll do it.
> 
> Yes, it does work for me.

OK I've applied this patch into omap-for-v5.1/cpsw.

Thanks,

Tony
