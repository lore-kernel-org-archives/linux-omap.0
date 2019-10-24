From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 net-next 00/12] net: ethernet: ti: introduce new cpsw
 switchdev based driver
Date: Thu, 24 Oct 2019 09:05:49 -0700
Message-ID: <20191024160549.GY5610@atomide.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191024100914.16840-1-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Grygorii Strashko <grygorii.strashko@ti.com> [191024 10:10]:
> This the RFC v5 which introduces new CPSW switchdev based driver which is 
> operating in dual-emac mode by default, thus working as 2 individual
> network interfaces. The Switch mode can be enabled by configuring devlink driver
> parameter "switch_mode" to 1/true:
> 	devlink dev param set platform/48484000.ethernet_switch \
> 	name switch_mode value 1 cmode runtime

Just wondering about the migration plan.. Is this a replacement
driver or used in addition to the old driver?

Regards,

Tony
