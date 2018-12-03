From: David Miller <davem@davemloft.net>
Subject: Re: [net-next][PATCH 0/4] davinci_emac: read the MAC address from
 nvmem
Date: Mon, 03 Dec 2018 15:40:59 -0800 (PST)
Message-ID: <20181203.154059.2288769104592341753.davem@davemloft.net>
References: <20181130082100.6241-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130082100.6241-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: brgl@bgdev.pl
Cc: grygorii.strashko@ti.com, nicolas.ferre@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com, robh+dt@kernel.org, frowand.list@gmail.com, nsekhar@ti.com, khilman@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, bgolaszewski@baylibre.com
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 30 Nov 2018 09:20:56 +0100

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series is part of a bigger series that aims at removing the platform
> data structure from the at24 EEPROM driver[1].
> 
> We provide a generalized version of of_get_nvmem_mac_address(), switch the
> only user of the of_ variant to using it, remove the previous
> implementation and use the new routine in the davinci_emac driver.
> 
> [1] https://lkml.org/lkml/2018/11/13/884

This looks good, series applied.
