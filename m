From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
Date: Wed, 28 Nov 2018 05:49:13 +0100
Message-ID: <20181128044913.GB6730@lunn.ch>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
 <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> [1] https://e2e.ti.com/support/arm/sitara_arm/f/791/t/701669

Reading this, the interesting part is:

	My guess would be that the driver would have to track the
	configuration of the switch hardware to correctly pad the
	frame.

Have you tried that?

     Andrew
