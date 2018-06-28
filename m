From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 01/15] nvmem: add support for cell lookups
Date: Thu, 28 Jun 2018 10:33:27 +0100
Message-ID: <1b3736c0-246e-4725-b64f-da916b9a0383@linaro.org>
References: <20180626102245.30711-1-brgl@bgdev.pl>
 <20180626102245.30711-2-brgl@bgdev.pl>
 <25ebceca-8cdd-edae-6393-dd29eb323c53@linaro.org>
 <CAMRc=Md8TM+zLn=T=BQeVHG-PGAvx-PHrs9y1t5zhdYo+m0ovg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=Md8TM+zLn=T=BQeVHG-PGAvx-PHrs9y1t5zhdYo+m0ovg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org



On 28/06/18 08:56, Bartosz Golaszewski wrote:
>> We should also have something like nvmem_remove_lookup_table() for
>> consistency, and it should ensure that it clears the cells entry too.
>>
> What do you mean by clearing the cells entry exactly?
I meant, Removing entry from the nvmem_cells list.

Initially I though we should remove the entry form nvmem_cells list, 
but It would complicate this path if some consumer has reference to it.

So, just removing the lookup list should be good! Lets not worry about 
removing from nvmem_cells list.


--srini

> 
> Bart
> 
