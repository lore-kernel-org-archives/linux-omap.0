From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 2/3] net: add support for nvmem to
 eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 12:09:29 +0300
Message-ID: <20180719090929.arbysqo2bk3esoar@mwanda>
References: <20180719082028.26116-1-brgl@bgdev.pl>
 <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda>
 <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, arm-soc <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Maybe it would be simpler as three separate functions:

int of_eth_get_mac_address() <- rename existing function to this
int nvmem_eth_get_mac_address() <- patch 2
int mtd_eth_nvmem_get_mac_address() patch 3

	int ret;

	ret = of_eth_get_mac_address(dev, mac_addr);
	if (!ret)
		return 0;
	ret = nvmem_eth_get_mac_address(dev, mac_addr);
	if (ret == -EPROBEDEFER)
		return ret;
	if (!ret)
		return 0;
	ret = mtd_eth_nvmem_get_mac_address(dev, mac_addr);
	if (!ret)
		return 0;

	return -ENODEV;

regards,
dan carpenter
