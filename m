From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH v9 1/8] drivers: phy: add generic PHY framework
Date: Fri, 28 Jun 2013 12:27:15 +0900
Message-ID: <000d01ce73af$62a95a60$27fc0f20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-doc-owner@vger.kernel.org
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, 'Rob Landley' <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, 'Benoit Cousson' <benoit.cousson@linaro.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, 'Cesar Eduardo Barros' <cesarb@cesarb.net>, "David S. Miller" <davem@davemloft.net>, 'Rajendra Nayak' <rnayak@ti.com>, Shawn Guo <shawn.guo@linaro.org>, 'Santosh Shilimkar' <santosh.shilimkar@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Balaji T K <balajitk@ti.com>, 'George Cherian' <george.cherian@ti.co>
List-Id: linux-omap@vger.kernel.org

On Wed, 26 Jun 2013 17:17:29 +0530, Kishon Vijay Abraham Iwrote:
> The PHY framework provides a set of APIs for the PHY drivers to
> create/destroy a PHY and APIs for the PHY users to obtain a reference to the
> PHY with or without using phandle. For dt-boot, the PHY drivers should
> also register *PHY provider* with the framework.
>
> PHY drivers should create the PHY by passing id and ops like init, exit,
> power_on and power_off. This framework is also pm runtime enabled.
>
> The documentation for the generic PHY framework is added in
> Documentation/phy.txt and the documentation for dt binding can be found at
> Documentation/devicetree/bindings/phy/phy-bindings.txt
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Tested-by: Jingoo Han <jg1.han@samsung.com>

It looks great to me!

I tested this General PHY framework with Exynos5250 eDP.
It works properly.
I will share the patch 'Generic PHY driver for the Exynos SoC DP PHY', soon.
Thanks.

Best regards,
Jingoo Han

> ---
>  .../devicetree/bindings/phy/phy-bindings.txt       |   66 +++
>  Documentation/phy.txt                              |  129 +++++
>  MAINTAINERS                                        |    7 +
>  drivers/Kconfig                                    |    2 +
>  drivers/Makefile                                   |    2 +
>  drivers/phy/Kconfig                                |   13 +
>  drivers/phy/Makefile                               |    5 +
>  drivers/phy/phy-core.c                             |  544 ++++++++++++++++++++
>  include/linux/phy/phy.h                            |  344 +++++++++++++
>  9 files changed, 1112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-bindings.txt
>  create mode 100644 Documentation/phy.txt
>  create mode 100644 drivers/phy/Kconfig
>  create mode 100644 drivers/phy/Makefile
>  create mode 100644 drivers/phy/phy-core.c
>  create mode 100644 include/linux/phy/phy.h

