From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 04/28] nvmem: provide nvmem_device_name()
Date: Wed, 8 Aug 2018 20:42:42 +0300
Message-ID: <CAHp75Ve6ugVGJ9JqCYri0_k93DgkPMua7g8dC5CMhT4uFHMgoA@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-5-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808153150.23444-5-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Naren <naren.kernel@gmail.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lukas Wunner <lukas@wunner.de>, Dan Carpenter <dan.carpenter@oracle.co>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Kernel users don't have any means of checking the names of nvmem
> devices. Add a routine that returns the name of the nvmem provider.
>
> This will be useful for nvmem notifier subscribers - otherwise they
> can't check what device is being added/removed.

> +const char *nvmem_device_name(struct nvmem_device *nvmem)
> +{
> +       return dev_name(&nvmem->dev);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_device_name);

Just wondering if *_dev_name() is more common pattern in the kernel
(at least pci_dev_name() comes immediately to mind).


-- 
With Best Regards,
Andy Shevchenko
