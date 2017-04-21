From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 net-next] mdio_bus: Issue GPIO RESET to PHYs.
Date: Fri, 21 Apr 2017 03:38:58 +0200
Message-ID: <20170421013858.GB705@lunn.ch>
References: <1491381237-24635-1-git-send-email-rogerq@ti.com>
 <64d6494d-41d2-0faf-a434-057f796637fe@ti.com>
 <daa29a99-0a17-d316-57eb-3e6162938d8d@ti.com>
 <f372db02-a919-55b4-9200-20726cd13482@ti.com>
 <fa24ae98-3d4f-4b11-bbb4-485b9ed41ed7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa24ae98-3d4f-4b11-bbb4-485b9ed41ed7@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, davem@davemloft.net, tony@atomide.com, nsekhar@ti.com, jsarha@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> > +			gpiod_set_value_cansleep(gpiod, 1);
> > +			udelay(bus->reset_delay_us);
> > +			gpiod_set_value_cansleep(gpiod, 0);
> 
> Does that work even if the polarity of the reset line is active low?

Hi Florian

Yes, it does. The gpiod_ API takes care of that, if you set the flag
GPIO_ACTIVE_LOW in the device tree blob. This is one of the
improvements over the gpio_ API.

		Andrew
