From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v5 3/3] drivers:power:twl4030-charger: add deferred
 probing for phy and iio
Date: Mon, 12 Jun 2017 13:42:48 -0500
Message-ID: <a91d2ad7-5985-789e-e4ad-04057dfdd8a3@ti.com>
References: <cover.1495363097.git.hns@goldelico.com>
 <6ed105f6c9c21c24184913a7be9e665453549d79.1495363097.git.hns@goldelico.com>
 <20170607204444.zumcreuqdnv7euv2@earth>
 <01A3D2F5-9E09-4E93-A363-93130DCEB7DF@goldelico.com>
 <1b9f3e92-36ac-2a73-7b2d-037b19fafaad@ti.com>
 <DC2DA07F-72A1-45B9-A4F5-BD83D930974D@goldelico.com>
 <754fbc28-f5ff-4736-1d46-f467667b130d@ti.com>
 <D12A5BD7-65A1-49E6-A25C-B2A2162FCA05@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <D12A5BD7-65A1-49E6-A25C-B2A2162FCA05@goldelico.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 06/12/2017 12:02 PM, H. Nikolaus Schaller wrote:
> Hi Grygorii,
> 
>> Am 12.06.2017 um 18:24 schrieb Grygorii Strashko <grygorii.strashko@ti.com>:
>>
>>
>>
>> On 06/09/2017 11:59 PM, H. Nikolaus Schaller wrote:
>>> Hi Grygorii,
>>>
>>>> Am 09.06.2017 um 18:25 schrieb Grygorii Strashko <grygorii.strashko@ti.com>:
>>>>
>>>>
>>>>>
>>>>> So please advise how to proceed.
>>>>>
>>>>
>>>> You should request irq as late as possible in probe - it's safest way to go always.
>>>> You see crushes simply because request_irq enables IRQ and IRQ can trigger immediately, so
>>>> IRQ handler will run and all required resources should be ready and initialized.
>>>>
>>>> In this case:
>>>> twl4030_bci_interrupt() -> twl4030_charger_update_current() -> ac_available() -> iio_read_channel_processed()
>>>> OOOPS.
>>>>
>>>> So, first thing to do is to reorder probe to ensure that sequence is safe.
>>>
>>> That is exactly what I guessed when proposing the reordering patch.
>>>
>>>> Then other stuff - devm, EPROBE_DEFER ...
>>>
>>> IMHO, reordering alone doesn't make much sense as a single patch. Or does it?
>>>
>>
>> The question is - is there bug in driver or not? As per current code seems yes.
> 
> If we all agree, do we need another confirmation?
> 
>> You can easily test it by directly calling twl4030_charger_interrupt() right after
>> IRQ is requested. there is a bug if it will crush.
> 
> In the variant without EPROBE_DEFER you won't see it since ac_available either
> has a valid iio channel or NULL.
> 
> The problem is only if we add an EPROBE_DEFER return if getting the iio channel
> fails. This seems to make trouble if we don't take care of it. There are certainly
> several options to work around but IMHO reordering is the best one (and even works
> w/o devm for iio - which should be added in a separate step).
> 
> And there is a strong argument for reordering to have the most likely failure
> first (iio fails more likely due to DEFER than allocating an irq). But only if
> we process the iio failure at all.
> 
> So there are one a little doubtful argument for reordering (driver bug) and
> a strong one.
> 
>> As for me it more reasonable to move forward using smaller steps.
> 
> Well, I wonder what it does help to fix a bug which does not even become visible
> if we don't add EPROBE_DEFER?

Sry, but have you tried test I've proposed (I can't try it by myself now, sry)? 
There is not only iio channel can be a problem - for example "current_worker"
 initialized after IRQ request, but can be scheduled from IRQ handler.

> 
> So I would count two steps:
> a) add EPROBE_DEFER and reorder code to make it work
> b) convert to devm for iio
> 

Few words regarding devm_request_irq() - it's useful, from one side, and
dangerous form another :(, as below init sequence is proved to be unsafe
and so it has to be used very carefully:

probe() {
 <do some initialization>
 <create some object:> objX = create_objX() -- no devm
 devm_request_irq(IrqY) -- IrqY handler using objX

 <init step failed>
	goto err;
...

err:
 [a]
 release_objX() - note IRQ is still enabled here
}
dd_core if err:
 devres_release_all() - IRQ disabled and freed only here

remove() {
 [b]
 release_objX() -- note IRQ is still enabled here
}
dd_core:
 devres_release_all() - IRQ disabled and freed only here

IRQ has to be explicitly disabled at points [a] & [b] 

Sequence to move forward can be up to you in general,
personally I'd try to add devm_iio and move  devm_request_irq()
down right before "/* Enable interrupts now. */" line first.

-- 
regards,
-grygorii
