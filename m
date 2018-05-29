From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] net: davinci: fix building davinci mdio code without CONFIG_OF
Date: Tue, 29 May 2018 16:31:19 +0200
Message-ID: <CAK8P3a2-421Y3Hwcu0SG0rORhO-wF06ULTJSAMrNypivS1PJjQ@mail.gmail.com>
References: <20180528155059.2736080-1-arnd@arndb.de> <3b99eb56-f303-98b8-cb1e-7ff134769c43@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b99eb56-f303-98b8-cb1e-7ff134769c43@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, Grygorii Strashko <grygorii.strashko@ti.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 29, 2018 at 3:25 PM, Sekhar Nori <nsekhar@ti.com> wrote:

>> @@ -374,7 +372,7 @@ static int davinci_mdio_probe(struct platform_device *pdev)
>>               return -ENOMEM;
>>       }
>>
>> -     if (dev->of_node) {
>> +     if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
>>               const struct of_device_id       *of_id;
>>
>>               ret = davinci_mdio_probe_dt(&data->pdata, pdev);
>
> I was expecting this one change to fix the issue since the if() block
> should be compiled away removing references to davinci_mdio_probe_dt().
>
> The code does get compiled out and there are no references to
> davinci_mdio_probe_dt() in the final object when !CONFIG_OF.
>
> But the compile error remains if the #ifdefs you removed above are
> installed back. Not sure why.

The way that "if (IS_ENABLED())" works, everything gets compiled at
first, but then the compiler uses dead code elimination to remove it
from the output after verifying that everything builds.

       Arnd
