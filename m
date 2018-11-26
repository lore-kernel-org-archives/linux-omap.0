From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH linux-next 09/10] dt-bindings: net: ti: deprecate
 cpsw-phy-sel bindings
Date: Mon, 26 Nov 2018 13:58:38 -0600
Message-ID: <20181126195838.GA19167@bogus>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
 <20181126001531.12974-10-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126001531.12974-10-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 25, 2018 at 06:15:30PM -0600, Grygorii Strashko wrote:
> The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
> deprecate cpsw-phy-sel bindings.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  Documentation/devicetree/bindings/net/cpsw-phy-sel.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please add acks/reviewed-bys when posting new versions.

Rob
