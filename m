From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: Re: [PATCH v4 5/5] Input: Add tps65217 power button driver
Date: Mon, 29 Aug 2016 11:09:34 +0200
Message-ID: <6a55ea5d-c276-f01d-2712-fc4e1c6a1633@grinn-global.com>
References: <20160620105056.25843-1-m.niestroj@grinn-global.com>
 <20160620105056.25843-6-m.niestroj@grinn-global.com>
 <20160621131735.GA896@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160621131735.GA896@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ping

On 21.06.2016 15:17, Rob Herring wrote:
> On Mon, Jun 20, 2016 at 12:50:56PM +0200, Marcin Niestroj wrote:
>> This driver enables us to use tps65217's power button as KEY_POWER on
>> am335x boards (directly connected button in chiliboard, accessible pin
>> via expansion header in beaglebone). This patch has been tested with
>> chiliboard.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
>> ---
>> Depends on patches 1-4 in series
>>
>> Changes v2 -> v4: none
>>
>> Changes v1 -> v2:
>>  * Added information about parent device in tps65217 power button
>>    device-tree binding documentation (suggested by Rob)
>>
>>  .../bindings/input/tps65217-pwrbutton.txt          |  17 +++
>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
>>  drivers/input/misc/Kconfig                         |  10 ++
>>  drivers/input/misc/Makefile                        |   1 +
>>  drivers/input/misc/tps65217-pwrbutton.c            | 131 +++++++++++++++++++++
>>  4 files changed, 159 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/tps65217-pwrbutton.txt
>>  create mode 100644 drivers/input/misc/tps65217-pwrbutton.c
>

-- 
Marcin Niestroj
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
