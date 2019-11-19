From: Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH v7 net-next 07/13] net: ethernet: ti: introduce cpsw
 switchdev based driver part 1 - dual-emac
Date: Tue, 19 Nov 2019 15:12:21 -0800
Message-ID: <20191119151221.14ff2d28@cakuba.netronome.com>
References: <20191119221925.28426-1-grygorii.strashko@ti.com>
        <20191119221925.28426-8-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119221925.28426-8-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 20 Nov 2019 00:19:19 +0200, Grygorii Strashko wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Part 1:
>  Introduce basic CPSW dual_mac driver (cpsw_new.c) which is operating in
> dual-emac mode by default, thus working as 2 individual network interfaces.
> Main differences from legacy CPSW driver are:
> 
>  - optimized promiscuous mode: The P0_UNI_FLOOD (both ports) is enabled in
> addition to ALLMULTI (current port) instead of ALE_BYPASS. So, Ports in
> promiscuous mode will keep possibility of mcast and vlan filtering, which
> is provides significant benefits when ports are joined to the same bridge,
> but without enabling "switch" mode, or to different bridges.
>  - learning disabled on ports as it make not too much sense for
>    segregated ports - no forwarding in HW.
>  - enabled basic support for devlink.
> 
> 	devlink dev show
> 		platform/48484000.switch
> 
> 	devlink dev param show
> 	 platform/48484000.switch:
> 	name ale_bypass type driver-specific
> 	 values:
> 		cmode runtime value false
> 
>  - "ale_bypass" devlink driver parameter allows to enable
> ALE_CONTROL(4).BYPASS mode for debug purposes.
>  - updated DT bindings.

Could you please add documentation for the devlink parameter under
Documentation/networking/devlink-params-* ?
