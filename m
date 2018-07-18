From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 4/5] net: add support for nvmem to
 eth_platform_get_mac_address()
Date: Wed, 18 Jul 2018 18:42:18 +0200
Message-ID: <20180718164218.GD12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-5-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180718161035.7005-5-brgl@bgdev.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Lukas Wunner <lukas@wunner.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

> +		if (!IS_ERR(nvmem)) {
> +			addr = nvmem_cell_read(nvmem, &alen);
> +			if (!IS_ERR(addr)) {
> +				from = "nvmem";
> +				/* Don't use ether_addr_copy() in case we
> +				 * didn't get the right size.
> +				 */

Please verify the size. A short read can still give a valid MAC
address, so the is_valid_ether_addr(addr) is not sufficient.

> +				memcpy(addrbuf, addr, alen);

Another reason to check the length is that you appear to have a buffer
overflow here, if alen > 6.

	 Andrew

> +				kfree(addr);
> +				addr = addrbuf;
> +			}
> +
> +			nvmem_cell_put(nvmem);
> +		}
> +	}
> +
>  	if (!addr || !is_valid_ether_addr(addr))
>  		return -ENODEV;
>  
> -- 
> 2.17.1
> 
