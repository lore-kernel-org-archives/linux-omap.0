From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 02/11] dt-bindings: phy: add cpsw port interface mode
 selection phy bindings
Date: Tue, 9 Oct 2018 07:40:00 -0700
Message-ID: <20181009144000.GL5662@atomide.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-3-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008234949.15416-3-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [181008 23:54]:
> +Examples:
> +	phy_gmii_sel: phy-gmii-sel {
> +		compatible = "ti,am3352-phy-gmii-sel";
> +		syscon-scm = <&scm_conf>;
> +		#phy-cells = <2>;
> +	};

Now that this driver can live in it's proper place in the
dts, you may want to consider just using standard reg
property for it instead of the syscon-scm. And also get
rid of the syscon reads and writes.

Regards,

Tony
