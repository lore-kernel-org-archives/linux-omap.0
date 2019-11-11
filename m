From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 net-next 00/12] net: ethernet: ti: introduce new cpsw
 switchdev based driver
Date: Mon, 11 Nov 2019 09:08:26 -0800
Message-ID: <20191111170826.GT5610@atomide.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024160549.GY5610@atomide.com>
 <dc621a9d-eb92-5df9-81d7-ad2b037ac3c7@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dc621a9d-eb92-5df9-81d7-ad2b037ac3c7@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [191109 15:16]:
> Hi Tony,
> 
> On 24/10/2019 19:05, Tony Lindgren wrote:
> > Hi,
> > 
> > * Grygorii Strashko <grygorii.strashko@ti.com> [191024 10:10]:
> > > This the RFC v5 which introduces new CPSW switchdev based driver which is
> > > operating in dual-emac mode by default, thus working as 2 individual
> > > network interfaces. The Switch mode can be enabled by configuring devlink driver
> > > parameter "switch_mode" to 1/true:
> > > 	devlink dev param set platform/48484000.ethernet_switch \
> > > 	name switch_mode value 1 cmode runtime
> > 
> > Just wondering about the migration plan.. Is this a replacement
> > driver or used in addition to the old driver?
> > 
> 
> Sry, I've missed you mail.
> 
> As it's pretty big change the idea is to keep both drivers at least for sometime.
> Step 1: add new driver and enable it on one platform. Do announcement.
> Step 2: switch all one-port and dual mac drivers to the new driver
> Step 3: switch all other platform to cpsw switchdev and deprecate old driver.

OK sounds good to me. So for the dts changes, we keep the old binding
and just add a new module there?

Or do you also have to disable some parts of the old dts?

Regards,

Tony
