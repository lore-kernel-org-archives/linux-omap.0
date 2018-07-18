From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
Date: Thu, 19 Jul 2018 08:10:54 +0900 (KST)
Message-ID: <20180719.081054.2060054138371290633.davem@davemloft.net>
References: <20180718161035.7005-1-brgl@bgdev.pl>
        <20180718161035.7005-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718161035.7005-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: brgl@bgdev.pl
Cc: nsekhar@ti.com, khilman@kernel.org, linux@armlinux.org.uk, grygorii.strashko@ti.com, srinivas.kandagatla@linaro.org, lukas@wunner.de, robh@kernel.org, f.fainelli@gmail.com, dan.carpenter@oracle.com, ivan.khoronzhuk@linaro.org, david@lechnology.com, gregkh@linuxfoundation.org, andrew@lunn.ch, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bgolaszewski@baylibre.com
List-Id: linux-omap@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 18 Jul 2018 18:10:31 +0200

> @@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
> -	const unsigned char *addr;
> -	struct device_node *dp;
> +	struct device_node *dp = dev_is_pci(dev) ?
> +			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
> +	const unsigned char *addr = NULL;
>  
> -	if (dev_is_pci(dev))
> -		dp = pci_device_to_OF_node(to_pci_dev(dev));
> -	else
> -		dp = dev->of_node;
> -

Reverse christmas tree is why the assignments are in the body of
the function instead of the declaration area.

Please don't do this, thanks.
