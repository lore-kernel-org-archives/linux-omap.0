From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 1/3] pinctrl: pinctrl-single must be initialized early.
Date: Tue, 18 Sep 2012 22:10:08 +0300
Message-ID: <B7D59159-4456-468B-A414-9B57BCEE018D@antoniou-consulting.com>
References: <1348070841-23354-1-git-send-email-panto@antoniou-consulting.com> <1348070841-23354-2-git-send-email-panto@antoniou-consulting.com> <20120918182150.GY11762@atomide.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120918182150.GY11762@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Sep 18, 2012, at 9:21 PM, Tony Lindgren wrote:

> Hi,
> 
> * Pantelis Antoniou <panto@antoniou-consulting.com> [120918 11:13]:
>> When using pinctrl-single to handle i2c initialization, it has
>> to be done early.
>> On the beaglebone the regulator is connected to the i2c0 bus,
>> and for sure that's the case for many other am33xx boards.
> 
> Usually it's better to initialize things later than earlier as
> that cuts down nasty dependencies and let's us have a proper
> debug console before we start initializing things beyond
> interrupts and drivers.
> 

Agreed.

> Maybe just fix up the i2c-omap.c not to use subsys_initcall()?
> And then deferred probe should be able to sort out the dependencies
> for other drivers depending on i2c?
> 

As long as we get the regulator to work early in the game no problem.
I don't know if deferring the probe will work in this case.
I could give it a shot and see if it works at all.

FWIW, the regulator is on I2C0 which doesn't need any pinmux setup.
So in theory I2C0 is ready to go without any pinctrl action, however
the other busses require it.

It's not clear how to do so without making the driver all hacky.
Perhaps a property that signals that no pinctrl binding is required.


> Regards,
> 
> Tony
> 

Regards

-- Pantelis

>> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>> ---
>> drivers/pinctrl/pinctrl-single.c | 12 +++++++++++-
>> 1 file changed, 11 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
>> index 76a4260..3acf7f9 100644
>> --- a/drivers/pinctrl/pinctrl-single.c
>> +++ b/drivers/pinctrl/pinctrl-single.c
>> @@ -980,7 +980,17 @@ static struct platform_driver pcs_driver = {
>> 	},
>> };
>> 
>> -module_platform_driver(pcs_driver);
>> +static int __init pcs_init(void)
>> +{
>> +	return platform_driver_register(&pcs_driver);
>> +}
>> +postcore_initcall(pcs_init);
>> +
>> +static void __exit pcs_exit(void)
>> +{
>> +	platform_driver_unregister(&pcs_driver);
>> +}
>> +module_exit(pcs_exit);
>> 
>> MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
>> MODULE_DESCRIPTION("One-register-per-pin type device tree based pinctrl driver");
>> -- 
>> 1.7.12
>> 
