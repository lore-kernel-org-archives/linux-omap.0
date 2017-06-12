From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v5 3/3] drivers:power:twl4030-charger: add deferred
 probing for phy and iio
Date: Mon, 12 Jun 2017 11:24:28 -0500
Message-ID: <754fbc28-f5ff-4736-1d46-f467667b130d@ti.com>
References: <cover.1495363097.git.hns@goldelico.com>
 <6ed105f6c9c21c24184913a7be9e665453549d79.1495363097.git.hns@goldelico.com>
 <20170607204444.zumcreuqdnv7euv2@earth>
 <01A3D2F5-9E09-4E93-A363-93130DCEB7DF@goldelico.com>
 <1b9f3e92-36ac-2a73-7b2d-037b19fafaad@ti.com>
 <DC2DA07F-72A1-45B9-A4F5-BD83D930974D@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DC2DA07F-72A1-45B9-A4F5-BD83D930974D@goldelico.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Marek Belisko <marek@goldelico.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, notasas@gmail.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 06/09/2017 11:59 PM, H. Nikolaus Schaller wrote:
> Hi Grygorii,
> 
>> Am 09.06.2017 um 18:25 schrieb Grygorii Strashko <grygorii.strashko@ti.com>:
>>
>>
>>
>> On 06/09/2017 01:05 AM, H. Nikolaus Schaller wrote:
>>> Hi,
>>>
>>>> Am 07.06.2017 um 22:44 schrieb Sebastian Reichel <sre@kernel.org>:
>>>>
>>>> Hi,
>>>>
>>>> On Sun, May 21, 2017 at 12:38:18PM +0200, H. Nikolaus Schaller wrote:
>>>>> This fixes an issue if both this twl4030_charger driver and
>>>>> phy-twl4030-usb are compiled as modules and loaded in random order.
>>>>> It has been observed on GTA04 and OpenPandora devices that in worst
>>>>> case the boot process hangs and in best case the AC detection fails
>>>>> with a warning.
>>>>>
>>>>> Therefore we add deferred probing checks for the usb_phy and the
>>>>> iio channel for AC detection.
>>>>>
>>>>> For implementing this we must reorder code because we can't safely
>>>>> return -EPROBE_DEFER after allocating any devm managed interrupt
>>>>> (it might already/still be enabled without working interrupt handler).
>>>>>
>>>>> So the check for required resources that may abort probing by
>>>>> returning -EPROBE_DEFER, must come first.
>>>>
>>>> This sounds fishy. EPROBE_DEFER should not be different from
>>>> other error codes in this regard and devm_ requested resources
>>>> should be free'd on any error. Why is irq handler not working?
>>>
>>> 1. there is no other error code involved, before we try to convert the driver to handle EPROBE_DEFER.
>>> So it is not that EPROBE_DEFER is special but that we add an error return path for it.
>>>
>>> 2. I don't know why it is not working - I just know that the handler seems to be triggered before
>>> all resources are available (if probe() is aborted with EPROBE_DEFER error paths) which ends up in kernel panics.
>>>
>>> Therefore just to be safe, I have reordered things a little (without changing the function):
>>>
>>> 1. check for resources (with some EPROBE_DEFER)
>>> 2. allocate non-devm (with optional EPROBE_DEFER)
>>> 3. allocate devm
>>>
>>> So this should be safe in any case.
>>>
>>> Please also compare a discussion
>>>
>>> https://lkml.org/lkml/2013/2/22/65
>>>
>>>>
>>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>>> ---
>>>>> drivers/power/supply/twl4030_charger.c | 37 ++++++++++++++++++++--------------
>>>>> 1 file changed, 22 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
>>>>> index 785a07bc4f39..945eabdbbc89 100644
>>>>> --- a/drivers/power/supply/twl4030_charger.c
>>>>> +++ b/drivers/power/supply/twl4030_charger.c
>>>>> @@ -984,6 +984,28 @@ static int twl4030_bci_probe(struct platform_device *pdev)
>>>>>
>>>>> 	platform_set_drvdata(pdev, bci);
>>>>>
>>>>> +	if (bci->dev->of_node) {
>>>>> +		struct device_node *phynode;
>>>>> +
>>>>> +		phynode = of_find_compatible_node(bci->dev->of_node->parent,
>>>>> +						  NULL, "ti,twl4030-usb");
>>>>> +		if (phynode) {
>>>>> +			bci->transceiver = devm_usb_get_phy_by_node(
>>>>> +				bci->dev, phynode, &bci->usb_nb);
>>>>> +			if (IS_ERR(bci->transceiver) &&
>>>>> +			    PTR_ERR(bci->transceiver) == -EPROBE_DEFER)
>>>>> +				return -EPROBE_DEFER;	/* PHY not ready */
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	bci->channel_vac = iio_channel_get(&pdev->dev, "vac");
>>>>> +	if (IS_ERR(bci->channel_vac)) {
>>>>> +		if (PTR_ERR(bci->channel_vac) == -EPROBE_DEFER)
>>>>> +			return -EPROBE_DEFER;	/* iio not ready */
>>>>> +		dev_warn(&pdev->dev, "could not request vac iio channel");
>>>>> +		bci->channel_vac = NULL;
>>>>> +	}
>>>>> +
>>>>
>>>> You should not request non-devm managed iio_channel before
>>>> devm-managed power-supply.
>>>
>>> Well, it is not *me* doing that.
>>>
>>> It is the unpatched driver which already does. See:
>>>
>>> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/supply/twl4030_charger.c?h=v4.12-rc4#n1069
>>>
>>> I have just moved this line to a different location to be able to add a proper EPROBE_DEFER return path.
>>>
>>>> This could be fixed by switching to
>>>> devm_iio_channel_get(), which also cleans up some code.
>>>
>>> Yes, this could be an alternative solution.
>>> We still need EPROBE_DEFER handling.
>>>
>>>>
>>>> I suspect, that this is also your IRQ problem, since iio_channel
>>>> is currently free'd before irqs are free'd, but its used in irq
>>>> code.
>>>
>>> Hm. No.
>>>
>>> In upstream code it is never freed on probe failure because there is only
>>> an error return (goto fail) after allocating irqs in case the
>>> twl_i2c_write_u8 fails. Which usually doesn't.
>>>
>>> The EPROBE_DEFER returned by iio_channel_get not being ready simply prints
>>> a warning and turns off AC detection (bci->channel_vac = NULL) forever.
>>>
>>>>
>>>>> 	bci->ac = devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
>>>>> 					     NULL);
>>>>> 	if (IS_ERR(bci->ac)) {
>>>>> @@ -1017,25 +1039,10 @@ static int twl4030_bci_probe(struct platform_device *pdev)
>>>>> 		return ret;
>>>>> 	}
>>>>>
>>>>> -	bci->channel_vac = iio_channel_get(&pdev->dev, "vac");
>>>>> -	if (IS_ERR(bci->channel_vac)) {
>>>
>>> My first attempt to fix EPROBE_DEFER was to add this
>>>
>>> +		if (PTR_ERR(bci->channel_vac) == -EPROBE_DEFER)
>>> +			return -EPROBE_DEFER;	/* iio not ready */
>>>
>>>>> -		bci->channel_vac = NULL;
>>>>> -		dev_warn(&pdev->dev, "could not request vac iio channel");
>>>>> -	}
>>>>> -
>>>>> 	INIT_WORK(&bci->work, twl4030_bci_usb_work);
>>>>> 	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
>>>>>
>>>>> 	bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
>>>>> -	if (bci->dev->of_node) {
>>>>> -		struct device_node *phynode;
>>>>> -
>>>>> -		phynode = of_find_compatible_node(bci->dev->of_node->parent,
>>>>> -						  NULL, "ti,twl4030-usb");
>>>>> -		if (phynode)
>>>>> -			bci->transceiver = devm_usb_get_phy_by_node(
>>>>> -				bci->dev, phynode, &bci->usb_nb);
>>>
>>> and this
>>>
>>> +			if (IS_ERR(bci->transceiver) &&
>>> +			    PTR_ERR(bci->transceiver) == -EPROBE_DEFER) {
>>> +				ret = -EPROBE_DEFER;	/* PHY not ready */
>>> +				goto fail;
>>>
>>> This did run (and potentially return) after installing devm_request_threaded_irq leading
>>> to observation of severe kernel panics by interrupts.
>>>
>>> Moving the iio channel allocation before devm_request_threaded_irq made them go away.
>>>
>>>>> -	}
>>>>>
>>>>> 	/* Enable interrupts now. */
>>>>> 	reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |
>>>>
>>>> -- Sebastian
>>>
>>> How important is it to keep the current sequence of devm_request_threaded_irq() + (devm_)iio_channel_get() untouched?
>>>
>>> The reason I ask is that it is more likely for (devm_)iio_channel_get() to fail than devm_request_threaded_irq().
>>>
>>> Hence the iio channel should imho be always allocated first, so that we skip allocating+freeing unused irq handlers in case
>>> of iio not being ready.
>>>
>>> Therefore, I suggest to keep the proposed reordering even if we think devm-conversion of iio_channel_get() alone
>>> would solve it equally well.
>>>
>>> Next: should there be two separate patches? One for converting the non-devm iio_channel_get() and cleaning up error path.
>>> And one for adding EPROBE_DEFER error path.
>>>
>>> Or keep it in a single patch because they only make sense if done together (you can't add/remove deferred probing
>>> without converting and/or moving iio_channel_get())?
>>>
>>> So please advise how to proceed.
>>>
>>
>> You should request irq as late as possible in probe - it's safest way to go always.
>> You see crushes simply because request_irq enables IRQ and IRQ can trigger immediately, so
>> IRQ handler will run and all required resources should be ready and initialized.
>>
>> In this case:
>> twl4030_bci_interrupt() -> twl4030_charger_update_current() -> ac_available() -> iio_read_channel_processed()
>> OOOPS.
>>
>> So, first thing to do is to reorder probe to ensure that sequence is safe.
> 
> That is exactly what I guessed when proposing the reordering patch.
> 
>> Then other stuff - devm, EPROBE_DEFER ...
> 
> IMHO, reordering alone doesn't make much sense as a single patch. Or does it?
> 

The question is - is there bug in driver or not? As per current code seems yes.
You can easily test it by directly calling twl4030_charger_interrupt() right after
IRQ is requested. there is a bug if it will crush.
As for me it more reasonable to move forward using smaller steps.


Thanks for you work and patches.

-- 
regards,
-grygorii
