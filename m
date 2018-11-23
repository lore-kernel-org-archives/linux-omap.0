From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/17] soc: ti: pruss: enable OCP master ports in SYSCFG
 always
Date: Fri, 23 Nov 2018 08:35:22 -0800
Message-ID: <20181123163522.GB53235@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-8-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542886753-17625-8-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181122 11:39]:
> @@ -160,6 +159,11 @@ static int pruss_enable_module(struct device *dev)
>  	pruss_soc_bus_rmw(psoc_bus->syscfg, SYSCFG_STANDBY_MODE_MASK,
>  			  SYSCFG_STANDBY_MODE_SMART);
>  
> +	/* enable OCP master ports/disable MStandby */
> +	ret = pruss_soc_bus_enable_ocp_master_ports(dev);
> +	if (ret)
> +		pruss_disable_module(dev);
> +
>  	return ret;

Seems like all you should need to do here with ti-sysc is to
leave out SYSC_IDLE_SMART and SYSC_IDLE_SMART_WKUP in the dts
for ti,sysc-midle property for am335x.

Regards,

Tony
