From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 net-next 06/12] net: ethernet: ti: introduce cpsw
 switchdev based driver part 1 - dual-emac
Date: Fri, 1 Nov 2019 21:39:13 +0100
Message-ID: <20191101203913.GD31534@lunn.ch>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024100914.16840-7-grygorii.strashko@ti.com>
 <20191029122422.GL15259@lunn.ch>
 <d87c72e1-cb91-04a2-c881-0d8eec4671e2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d87c72e1-cb91-04a2-c881-0d8eec4671e2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> > > +static const struct devlink_ops cpsw_devlink_ops;
> > 
> > It would be nice to avoid this forward declaration.
> 
> It's not declaration, it's definition of devlink_ops without any standard callbacks implemented.

Ho Grygorii

Ah, yes.

How about

= {
  };

to make it clearer?

> > > +static const struct devlink_param cpsw_devlink_params[] = {
> > > +	DEVLINK_PARAM_DRIVER(CPSW_DL_PARAM_ALE_BYPASS,
> > > +			     "ale_bypass", DEVLINK_PARAM_TYPE_BOOL,
> > > +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> > > +			     cpsw_dl_ale_ctrl_get, cpsw_dl_ale_ctrl_set, NULL),
> > > +};
> > 
> > Is this documented?
> 
> In patch 9. But I'll update it and add standard devlink parameter definition, like:
> 
> ale_bypass	[DEVICE, DRIVER-SPECIFIC]
> 		Allows to enable ALE_CONTROL(4).BYPASS mode for debug purposes
> 		Type: bool
> 		Configuration mode: runtime

And please you the standard file naming and location,
Documentation/networking/devlink-params-foo.txt

Thanks
	Andrew
