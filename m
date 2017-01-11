From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: net: ti: cpsw-phy-sel: RGMII is not working on AM335x
Date: Wed, 11 Jan 2017 16:14:07 +0100
Message-ID: <20170111151407.GW22820@lunn.ch>
References: <1484122463.3777.1.camel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484122463.3777.1.camel@phytec.de>
Sender: netdev-owner@vger.kernel.org
To: Teresa Remmet <t.remmet@phytec.de>
Cc: Alexandru Gagniuc <alex.g@adaptrum.com>, "David S. Miller" <davem@davemloft.net>, Mugunthan V N <mugunthanvnm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> So I wonder what is correct now? As for me the patch makes RGMII unusable.
> Has anyone an explanation?

Hi Teresa

In your device tree, what phy-mode do you have?

And does your hardware require an RGMII delay in order that it works?

    Andrew
