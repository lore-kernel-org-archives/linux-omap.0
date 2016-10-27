From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 5/5] gpio: davinci: Add a separate compatible for k2g
Date: Thu, 27 Oct 2016 08:58:43 +0530
Message-ID: <9b50700c-f7c2-4374-0e7a-2d5b8302f5c0@ti.com>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
 <1476855239-32730-6-git-send-email-j-keerthy@ti.com>
 <20161026210851.jt2xoo2ap6zijowg@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161026210851.jt2xoo2ap6zijowg@rob-hp-laptop>
Sender: linux-gpio-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, lokeshvutla@ti.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org



On Thursday 27 October 2016 02:38 AM, Rob Herring wrote:
> On Wed, Oct 19, 2016 at 11:03:59AM +0530, Keerthy wrote:
>> In the case of k2g the clocks are handled differently as when compared
>> with other keystones. Hence adding a separate compatible and match tables
>> accordingly.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  .../devicetree/bindings/gpio/gpio-davinci.txt      |  2 +-
>>  drivers/gpio/gpio-davinci.c                        | 45 ++++++++++++++++++++--
>>  2 files changed, 42 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>> index 5079ba7..a76abd2 100644
>> --- a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>> @@ -1,7 +1,7 @@
>>  Davinci/Keystone GPIO controller bindings
>>
>>  Required Properties:
>> -- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio"
>> +- compatible: should be "ti,dm6441-gpio", "ti,keystone-gpio", "ti,k2g-gpio"
>
> Is this "one of" or all? Seems line the former in which case please
> reformat to one per line.

It is One of. I will reformat.

>
>>
>>  - reg: Physical base address of the controller and the size of memory mapped
>>         registers.
