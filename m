From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/5] net: add an info message to
 eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 08:13:00 +0900 (KST)
Message-ID: <20180719.081300.1581730029693790076.davem@davemloft.net>
References: <20180718161035.7005-1-brgl@bgdev.pl>
        <20180718161035.7005-3-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718161035.7005-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: brgl@bgdev.pl
Cc: nsekhar@ti.com, khilman@kernel.org, linux@armlinux.org.uk, grygorii.strashko@ti.com, srinivas.kandagatla@linaro.org, lukas@wunner.de, robh@kernel.org, f.fainelli@gmail.com, dan.carpenter@oracle.com, ivan.khoronzhuk@linaro.org, david@lechnology.com, gregkh@linuxfoundation.org, andrew@lunn.ch, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bgolaszewski@baylibre.com
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jul 2018 18:10:32 +0200

>  
> +	dev_info(dev, "read MAC address from %s\n", from);
>  	ether_addr_copy(mac_addr, addr);
>  	return 0;

Ugh, please don't do this.

We probe various bits of information from various sources during
driver probe, and none of them are more or less important than
the MAC address.  So singling this out for log info output is
really not such a great idea.

Thank you.
