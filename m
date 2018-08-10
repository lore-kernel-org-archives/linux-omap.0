From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 14/29] net: simplify eth_platform_get_mac_address()
Date: Fri, 10 Aug 2018 17:39:17 +0300
Message-ID: <CAHp75Ve28aNe+FCK3p4OLsDf7dNo-iJ1VR=pyx+Y9OUn3sjYBw@mail.gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180810080526.27207-15-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180810080526.27207-15-brgl@bgdev.pl>
Sender: netdev-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 10, 2018 at 11:05 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We don't need to use pci_device_to_OF_node() - we can retrieve
> dev->of_node directly even for pci devices.
>

>         struct device_node *dp;
>
> -       if (dev_is_pci(dev))
> -               dp = pci_device_to_OF_node(to_pci_dev(dev));
> -       else
> -               dp = dev->of_node;
> -
> +       dp = dev->of_node;
>         addr = NULL;
>         if (dp)
>                 addr = of_get_mac_address(dp);

Looking more at this I could even propose to change all above by

addr = device_get_mac_address(dev, mac_addr, ETH_ALEN);

Thoughts?

-- 
With Best Regards,
Andy Shevchenko
