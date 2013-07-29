From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] of: provide of_platform_unpopulate()
Date: Mon, 29 Jul 2013 19:31:56 +1000
Message-ID: <1375090316.3859.37.camel@pasglop>
References: <1374257691-31981-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374257691-31981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, George Cherian <george.cherian@ti.com>, linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Vivek Gautam <gautam.vivek@samsung.com>, linux-omap@vger.kernel.org, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 2013-07-19 at 20:14 +0200, Sebastian Andrzej Siewior wrote:
> The problem is that platform_device_del() "releases" each ressource in its
> tree. This does not work on platform_devices created by OF becuase they
> were never added via insert_resource(). As a consequence old->parent in
> __release_resource() is NULL and we explode while accessing ->child.
> So I either I do something completly wrong _or_ nobody here tested the
> rmmod path of their driver.

But that's wrong. I am not familar with all that new code, but from step
up, not having the resources in the resource tree is a bad idea to begin
with....

> This patch provides a common function to unregister / remove devices
> which added to the system via of_platform_populate(). While this works
> now on my test case I have not tested any of the driver I modify here so
> feedback is greatly appreciated.

Ben.
