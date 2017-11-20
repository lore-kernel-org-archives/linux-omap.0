From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 1/4] omapdrm: fix compatible string for td028ttec1
Date: Mon, 20 Nov 2017 06:36:48 +0100
Message-ID: <01FF562E-B2A7-465C-B763-A63872C7DD53@goldelico.com>
References: <cover.1510822218.git.hns@goldelico.com>
 <474bfc72b67e1d0e2a223084a69f04d2baa1dda8.1510822218.git.hns@goldelico.com>
 <4753a425-d050-7f2d-35ae-b387accfd99e@ti.com>
 <130D3B71-C0CE-4755-BF06-971681F630BC@goldelico.com>
 <d90ee1ee-8a33-de04-bb8b-2f10e0a80a61@ti.com>
 <908C52B9-83E2-49B3-B5B4-D8F27A96ECD6@goldelico.com>
 <a6b4c02d-a5ff-b0e6-ca59-afaf1148fe2a@ti.com>
 <689D4636-A169-4C4A-89C2-7039C78E853F@goldelico.com>
 <2e67402b-4a32-9da9-3b06-e271c23d2422@ti.com>
 <D565D101-4EAF-4B3C-907F-A826EF53B5AF@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <D565D101-4EAF-4B3C-907F-A826EF53B5AF@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Sean Paul <seanpaul@chromium.org>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

> Am 16.11.2017 um 19:56 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> Hi Andrew,
> 
>> Am 16.11.2017 um 19:32 schrieb Andrew F. Davis <afd@ti.com>:
>> 
>> On 11/16/2017 12:18 PM, H. Nikolaus Schaller wrote:
>>> 
>>>> Am 16.11.2017 um 18:08 schrieb Andrew F. Davis <afd@ti.com>:
>>>> 
>>>> On 11/16/2017 10:10 AM, H. Nikolaus Schaller wrote:
>>>>> Hi Andrew,
>>>>> 
>>>>>> Am 16.11.2017 um 16:53 schrieb Andrew F. Davis <afd@ti.com>:
>>>>>> 
>>>>>> On 11/16/2017 07:43 AM, H. Nikolaus Schaller wrote:
>>>>>>> 
>>>>>>>> Am 16.11.2017 um 13:32 schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
>>>>>>>> 
>>>>>>>> On 16/11/17 10:50, H. Nikolaus Schaller wrote:
>>>>>>>>> The vendor name was "toppoly" but other panels and the vendor list
>>>>>>>>> have defined it as "tpo". So let's fix it in driver and bindings.
>>>>>>>>> 
>>>>>>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>>>>>>> ---
>>>>>>>> 
>>>>>>>> 
>>>>>>>>> -MODULE_ALIAS("spi:toppoly,td028ttec1");
>>>>>>>>> +MODULE_ALIAS("spi:tpo,td028ttec1");
>>>>>>>> 
>>>>>>>> Doesn't this mean that the module won't load if you have old bindings?
>>>>>>> 
>>>>>>> Hm.
>>>>>>> 
>>>>>>> Well, I think it can load but doesn't automatically from DT strings which might
>>>>>>> be unexpected.
>>>>>>> 
>>>>>>>> Can't we have two module aliases?
>>>>>>> 
>>>>>>> I think we can. Just a random example:
>>>>>>> https://elixir.free-electrons.com/linux/latest/source/drivers/w1/slaves/w1_therm.c#L754
>>>>>>> 
>>>>>>> So we should keep both.
>>>>>> 
>>>>>> Even better would be to drop both MODULE_ALIAS and let the
>>>>>> MODULE_DEVICE_TABLE macro define them for your from the SPI id table.
>>>>> 
>>>>> Why would that be better?
>>>>> 
>>>> 
>>>> MODULE_ALIAS is ugly, you already have a table (usually) of device names
>>>> that are supported by the driver, the module aliases should be generated
>>>> from that table. This also keeps supported device list in one place.
>>>> 
>>>>> As far as I see it will need more code and changes than adding one line of
>>>>> MODULE_ALIAS.
>>>>> 
>>>>>> Although it doesn't look like this driver has an SPI id table, you
>>>>>> should probably add one, I be interested to see if this module is always
>>>>>> being matched through the "spi" or the "of" alias..
>>>>> 
>>>>> Could you please propose how that code should look like, so that I can test?
>>>>> 
>>>> 
>>>> Sure,
>>>> 
>>>> start with
>>>> $ udevadm monitor
>>>> and see what string the kernel is looking for when trying to find a
>>>> module for this device.
>>> 
>>> Well, the module is loaded automatically from DT at boot time well before
>>> I can start udevadm. So that is the most tricky part to setup the system
>>> to suppress this...
>>> 
>>>> 
>>>> If it is only ever looking for "of:toppoly,td028ttec1", then you can
>>>> drop the MODULE_ALIAS and be done as it was never getting used anyway.
>>> 
>>> Since it is an SPI client, I am sure it looks for "spi:something.
>>> 
>>>> 
>>>> What I expect though is "spi:toppoly,td028ttec1", in which case you
>>>> should add
>>>> 
>>>> static const struct spi_device_id td028ttec1_ids[] = {
>>>> 	{ "toppoly,td028ttec1", 0 },
>>>> 	{ "tpo,td028ttec1", 0},
>>>> 	{ /* sentinel */ }
>>>> };
>>>> MODULE_DEVICE_TABLE(spi, td028ttec1_ids);
>>> 
>>> We already have a static const struct of_device_id td028ttec1_of_match[]
>>> table with the same information.
>>> 
>>> So we still have two places to keep in sync.
>>> 
>>> Or can we remove the td028ttec1_of_match[]? AFAIK not.
>>> 
>>>> 
>>>> link to it in the td028ttec1_spi_driver struct:
>>>> .id_table = td028ttec1_ids,
>>>> 
>>>> Then test again to see that the module still loads with the new and old
>>>> DT string.
>>> 
>>> In total I am not really convinced that adding 7 lines of code is better
>>> than one (the "tpo," alias) that is tested and works...
>>> 
>>> And it looks like a lot of unplanned code testing for me which takes more
>>> than 5 minutes :)
>>> 
>>> So I'd prefer to leave that exercise of fixing the MODULE_ALIAS/DEVICE_TABLE
>>> to someone else...
>>> 
>> 
>> That's fine, someday I'll probably get some script to do this for all
>> the drivers that still have MODULE_ALIAS and an existing table.
> 
> That would be cool!
> 
> On a second thought, I think there is a quick experiment for this driver
> not needing to monitor events.
> 
> 1st attempt: remove ALIASES => if it still loads it would be fine
> 2nd attempt: add your id table => if it loads again, it is fine
> if not, let's keep ALIASES.
> 
> Maybe I can try tomorrow.

I found time to give it a try and indeed:

1. with module_aliases

root@letux:~# lsmod | fgrep td028
panel_tpo_td028ttec1    16384  1 
omapdss_base           16384  5 connector_analog_tv,encoder_opa362,panel_tpo_td028ttec1,omapdrm,omapdss
root@letux:~# modprobe -c | fgrep td028
alias of:N*T*Comapdss,toppoly,td028ttec1 panel_tpo_td028ttec1
alias of:N*T*Comapdss,toppoly,td028ttec1C* panel_tpo_td028ttec1
alias of:N*T*Comapdss,tpo,td028ttec1 panel_tpo_td028ttec1
alias of:N*T*Comapdss,tpo,td028ttec1C* panel_tpo_td028ttec1
alias spi:toppoly,td028ttec1 panel_tpo_td028ttec1
alias spi:tpo,td028ttec1 panel_tpo_td028ttec1
root@letux:~# 

=> two MODULE_ALIASEs are possible.

2. without module_aliases

No display and:

root@letux:~# lsmod | fgrep td028
root@letux:~# modprobe -c | fgrep td028
alias of:N*T*Comapdss,toppoly,td028ttec1 panel_tpo_td028ttec1
alias of:N*T*Comapdss,toppoly,td028ttec1C* panel_tpo_td028ttec1
alias of:N*T*Comapdss,tpo,td028ttec1 panel_tpo_td028ttec1
alias of:N*T*Comapdss,tpo,td028ttec1C* panel_tpo_td028ttec1
root@letux:~# 

=> spi: entries are needed.

3. with MODULE_DEVICE_TABLE

Display is back and:

root@letux:~# lsmod | fgrep td028
panel_tpo_td028ttec1    16384  1 
omapdss_base           16384  5 connector_analog_tv,encoder_opa362,panel_tpo_td028ttec1,omapdrm,omapdss
root@letux:~# modprobe -c | fgrep td028
alias of:N*T*Comapdss,toppoly,td028ttec1 panel_tpo_td028ttec1
alias of:N*T*Comapdss,toppoly,td028ttec1C* panel_tpo_td028ttec1
alias of:N*T*Comapdss,tpo,td028ttec1 panel_tpo_td028ttec1
alias of:N*T*Comapdss,tpo,td028ttec1C* panel_tpo_td028ttec1
alias spi:toppoly,td028ttec1 panel_tpo_td028ttec1
alias spi:tpo,td028ttec1 panel_tpo_td028ttec1
root@letux:~#

=> MODULE_DEVICE_TABLE works equally well.

I have prepared a separate patch so that a first one adds
another MODULE_ALIAS and the new one replaces both MODULE_ALIASes
with MODULE_DEVICE_TABLE.

I will submit a [PATCH v3] asap.

BR and thanks,
Nikolaus
