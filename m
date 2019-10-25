From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 net-next 04/12] net: ethernet: ti: cpsw: move set of
 common functions in cpsw_priv
Date: Fri, 25 Oct 2019 15:01:09 +0200
Message-ID: <20191025130109.GB10212@lunn.ch>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024100914.16840-5-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191024100914.16840-5-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 24, 2019 at 01:09:06PM +0300, Grygorii Strashko wrote:
> As a preparatory patch to add support for a switchdev based cpsw driver,
> move common functions to cpsw-priv.c so that they can be used across both
> drivers.

Hi Grygorii

Bike shedding, but it seems odd to move common code into a private
file. How common is the current code in cpsw-common.c?

      Andrew
