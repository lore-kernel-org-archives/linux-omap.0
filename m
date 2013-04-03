From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4 0/6] Generic PHY Framework
Date: Wed, 03 Apr 2013 12:33:03 -0400 (EDT)
Message-ID: <20130403.123303.544482473271388131.davem@davemloft.net>
References: <515BC559.1070602@ti.com>
	<20130403.023157.1254170239558661397.davem@davemloft.net>
	<515BCDB2.2040506@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <515BCDB2.2040506@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: kishon@ti.com
Cc: balbi@ti.com, gregkh@linuxfoundation.org, arnd@arndb.de, akpm@linux-foundation.org, rob@landley.net, sylvester.nawrocki@gmail.com, swarren@wwwdotorg.org, cesarb@cesarb.net, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, b-cousson@ti.com, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, mchehab@redhat.com, santosh.shilimkar@ti.com, broonie@opensource.wolfsonmicro.com, swarren@nvidia.com, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Wed, 3 Apr 2013 12:05:30 +0530

> This patch series is about drivers/phy which will be used for now by
> usb, sata and maybe some video PHY's. Network itself has a
> comprehensive PHY in drivers/net/phy which we'd like to merge it with
> drivers/phy so that we have all the phy stuff in drivers/phy but we
> are not planning too far ahead here.

Ok, that makes sense, thanks.
