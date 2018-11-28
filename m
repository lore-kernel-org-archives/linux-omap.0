From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
Date: Wed, 28 Nov 2018 23:02:11 +0100
Message-ID: <20181128220211.GA5037@lunn.ch>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
 <20181126022711.GD32164@lunn.ch>
 <7a194258-2888-2268-42d1-27ac513a5c8a@ti.com>
 <20181128044913.GB6730@lunn.ch>
 <6047b35d-d3c2-14f7-b42d-754b581a3c55@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6047b35d-d3c2-14f7-b42d-754b581a3c55@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> This is dynamic configuration related to ALE VLAN entries and
> I do not see the way to support its auto-detection with current driver,
> unfortunately.

I think you can subscribe to switchdev events which will tell you.

  Andrew
