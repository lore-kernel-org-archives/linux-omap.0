From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: Re: [PATCH v4 5/5] Input: Add tps65217 power button driver
Date: Mon, 22 Aug 2016 12:09:17 +0200
Message-ID: <8fe03c82-24aa-106f-80ee-e297eaf0d4e2@grinn-global.com>
References: <20160620105056.25843-1-m.niestroj@grinn-global.com>
 <20160620105056.25843-6-m.niestroj@grinn-global.com>
 <20160621131735.GA896@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20160621131735.GA896@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

ping

On 21.06.2016 15:17, Rob Herring wrote:
> On Mon, Jun 20, 2016 at 12:50:56PM +0200, Marcin Niestroj wrote:
>> This driver enables us to use tps65217's power button as KEY_POWER on
>> am335x boards (directly connected button in chiliboard, accessible pin
>> via expansion header in beaglebone). This patch has been tested with
>> chiliboard.
>>
>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
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
> Acked-by: Rob Herring <robh@kernel.org>
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
