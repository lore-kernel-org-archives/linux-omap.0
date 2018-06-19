From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] net: ethernet: fix suspend/resume in davinci_emac
Date: Tue, 19 Jun 2018 18:11:58 +0200
Message-ID: <CAMRc=MdR_3aEk+8v5hV45k3hkCR16K6NGr8VNQ93DOyLrYq4yw@mail.gmail.com>
References: <20180619124400.11878-1-brgl@bgdev.pl> <20180619135219.GA7312@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180619135219.GA7312@wunner.de>
Sender: stable-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "David S . Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

2018-06-19 15:52 GMT+02:00 Lukas Wunner <lukas@wunner.de>:
> On Tue, Jun 19, 2018 at 02:44:00PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This patch reverts commit 3243ff2a05ec ("net: ethernet: davinci_emac:
>> Deduplicate bus_find_device() by name matching") and adds a comment
>> which should stop anyone from reintroducing the same "fix" in the future.
>>
>> We can't use bus_find_device_by_name() here because the device name is
>> not guaranteed to be 'davinci_mdio'. On some systems it can be
>> 'davinci_mdio.0' so we need to use strncmp() against the first part of
>> the string to correctly match it.
>>
>> Fixes: 3243ff2a05ec ("net: ethernet: davinci_emac: Deduplicate bus_find_device() by name matching")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Acked-by: Lukas Wunner <lukas@wunner.de>
>
> My apologies Bartosz, it wasn't clear to me that the driver deliberately
> only matched against the prefix of the name.  Sorry for the breakage.
>

No issue. I submitted a follow-up series with additional changes
required to make suspend/resume work. Please leave your Acked-by there
as well as I forgot to pick it up.

Thanks in advance,
Bartosz Golaszewski
