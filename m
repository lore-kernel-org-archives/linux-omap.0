From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 0/2] net: davinci_emac: fix suspend/resume (both a
 regression and a common clk problem)
Date: Wed, 20 Jun 2018 19:44:00 -0700
Message-ID: <d8ef484b-af29-f25c-fbeb-abf6105e34f7@gmail.com>
References: <20180620080356.11900-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620080356.11900-1-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org



On 06/20/2018 01:03 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Earlier I sent the first patch as a solution to a regression introduced
> during the v4.16 merge window, but after testing David's common clock
> series on top of 4.18-rc1 + this patch it turned out that the problem
> persisted.
> 
> This is a follow-up containing the regression fix and an additional
> patche that makes suspend/resume work with David's changes.
> 
> v1 -> v2:
> - dropped patch 2/3
> - in patch 2/2: check the device's parent's compatible

Much better:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> Bartosz Golaszewski (2):
>   net: ethernet: fix suspend/resume in davinci_emac
>   net: davinci_emac: match the mdio device against its compatible if
>     possible
> 
>  drivers/net/ethernet/ti/davinci_emac.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 

-- 
Florian
