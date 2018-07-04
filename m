From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
Date: Wed, 4 Jul 2018 14:34:12 +0530
Message-ID: <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
 <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Ladislav Michl <ladis@linux-mips.org>
Cc: Rob Herring <robh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, David Lechner <david@lechnology.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Florian Fainelli <f.fainelli@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 04 July 2018 01:59 PM, Bartosz Golaszewski wrote:
> 2018-07-04 9:09 GMT+02:00 Ladislav Michl <ladis@linux-mips.org>:
>> On Tue, Jul 03, 2018 at 09:39:51AM -0700, Florian Fainelli wrote:
>>>
>>>
>>> On 06/29/2018 02:40 AM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> On da850-evm board we can read the MAC address from MTD. It's currently
>>>> done in the relevant board file, but we want to get rid of all the MAC
>>>> reading callbacks from the board file (SPI and NAND). Move the reading
>>>> of the MAC address from SPI to the emac driver's probe function.
>>>
>>> This should be made something generic to all drivers, not just something
>>> the davinci_emac driver does, something like this actually:
>>>
>>> https://lkml.org/lkml/2018/3/24/312
>>
>> ...and that's would also make it work when MAC address is stored
>> in 24c08 EEPROM, which is quite common.
>>
> 
> This is what the second patch for davinci_emac in this series does. I
> agree that this should become more generic at some point - we should
> probably have a routine somewhere in net that would try to get the MAC
> address from all possible sources (nvmem, of etc.). This is somewhat
> related to the work I want to do on nvmem to make the at24 setup()
> callback more generic.
> 
> Unfortunately we don't have it yet and I will not have time to work on
> it before v4.20 so if there are no serious objections, I'd like to get
> this series merged for v4.19 and then we can refactor the MAC reading
> later.
> 
> How does it sound?

I don't think the series introduces any regressions. We need to have MTD
and SPI flash built into the kernel even today to get mac address on
DA850 EVM. So from that perspective, I don't have objections (I need to
actually test still).

OTOH, it will be nice to do the conversion once and not piecemeal. That
way there is less churn and scope for regressions.

So from a mach-davinci perspective, I don't have a very strong position
either way.

Thanks,
Sekhar
