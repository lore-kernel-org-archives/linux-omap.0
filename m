From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 01/18] nvmem: add support for cell lookups
Date: Mon, 16 Jul 2018 13:20:13 +0100
Message-ID: <c460e73f-bfc4-abc6-e61c-26290632a3ab@linaro.org>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629094039.7543-2-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org



On 29/06/18 10:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski<bgolaszewski@baylibre.com>
> 
> We can currently only register nvmem cells from device tree or by
> manually calling nvmem_add_cells(). The latter options however forces
> users to make sure that the nvmem provider with which the cells are
> associated is registered before the call.
> 
> This patch proposes a new solution inspired by other frameworks that
> offer resource lookups (GPIO, PWM etc.). It adds functions that allow
> machine code to register nvmem lookup which are later lazily used to
> add corresponding nvmem cells and remove them if no longer needed.
> 
> Signed-off-by: Bartosz Golaszewski<bgolaszewski@baylibre.com>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
