From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
Date: Tue, 3 Jul 2018 11:47:16 -0500
Message-ID: <83c551d9-9e66-fc72-7f8d-c43337d05a71@lechnology.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On 07/03/2018 11:39 AM, Florian Fainelli wrote:
> 
> 
> On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> On da850-evm board we can read the MAC address from MTD. It's currently
>> done in the relevant board file, but we want to get rid of all the MAC
>> reading callbacks from the board file (SPI and NAND). Move the reading
>> of the MAC address from SPI to the emac driver's probe function.
> 
> This should be made something generic to all drivers, not just something
> the davinci_emac driver does, something like this actually:
> 
> https://lkml.org/lkml/2018/3/24/312
> 

I was thinking about suggesting adding a nvmem provider for MTD devices
as well. It would fix the kernel config dependency problems I was running
into since nvmem lookups can do -EPROBE_DEFER.
