From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH linux-next 01/10] dt-bindings: phy: add cpsw port
 interface mode selection phy bindings
Date: Tue, 27 Nov 2018 10:22:52 -0800
Message-ID: <20181127182252.GV53235@atomide.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
 <20181126001531.12974-2-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126001531.12974-2-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [181126 00:15]:
> Add CPSW Port's Interface Mode Selection PHY (phy-gmii-sel) DT Bindings

Looks good to me. Please send the dts changes separately
when they're OK to merge after the driver dependencies
have cleared.

For this patch:

Acked-by: Tony Lindgren <tony@atomide.com>
