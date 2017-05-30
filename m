From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mfd: lp87565: Add lp87565 PMIC support
Date: Tue, 30 May 2017 15:47:59 +0530
Message-ID: <f58bcdb9-c048-30d5-0567-a02eb32767a4@ti.com>
References: <1495541816-14801-1-git-send-email-j-keerthy@ti.com>
 <1495541816-14801-2-git-send-email-j-keerthy@ti.com>
 <20170530092347.jlystyxrscuj3wvk@dell>
 <a7204c7c-0cc0-f3a7-56af-d1f0508ad4d1@ti.com>
 <20170530101245.dtoj7v2scegmt66r@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170530101245.dtoj7v2scegmt66r@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, afd-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 30 May 2017 03:42 PM, Lee Jones wrote:
> On Tue, 30 May 2017, Keerthy wrote:
> 
>>
>>
>> On Tuesday 30 May 2017 02:53 PM, Lee Jones wrote:
>>> On Tue, 23 May 2017, Keerthy wrote:
>>>
>>>> The LP87565 chip is a power management IC for Portable Navigation Systems
>>>> and Tablet Computing devices. It contains the following components:
>>>>
>>>>         - Configurable Bucks(Single and multi-phase).
>>>>         - Configurable General Purpose Output Signals (GPO).
>>>>
>>>> The LP87565-Q1 variant device uses two 2-phase outputs configuration,
>>>> Buck0 is master for Buck0/1 output and Buck2 is master for Buck2/3
>>>> output.
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>
>>>> Changes in v2:
>>>>
>>>>   * Fixed a bunch of whitespace errors.
>>>>   * Changed the License to short form.
>>>>   * Added the generic compatible lp87565
>>>>   * Removed i2c_device_id table.
>>>>   * Introduced probe_new function in place of probe.
>>>>
>>>>  Documentation/devicetree/bindings/mfd/lp87565.txt |  45 ++++
>>>>  drivers/mfd/Kconfig                               |  14 ++
>>>>  drivers/mfd/Makefile                              |   1 +
>>>>  drivers/mfd/lp87565.c                             |  95 ++++++++
>>>>  include/linux/mfd/lp87565.h                       | 271 ++++++++++++++++++++++
>>>>  5 files changed, 426 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
>>>>  create mode 100644 drivers/mfd/lp87565.c
>>>>  create mode 100644 include/linux/mfd/lp87565.h
> 
> [...]
> 
>>>> +static int lp87565_probe(struct i2c_client *client)
>>>> +{
>>>> +	struct lp87565 *lp87565;
>>>> +	const struct of_device_id *of_id;
>>>> +	int ret;
>>>> +	unsigned int otpid;
>>>> +
>>>> +	lp87565 = devm_kzalloc(&client->dev, sizeof(*lp87565), GFP_KERNEL);
>>>> +	if (!lp87565)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	lp87565->dev = &client->dev;
>>>> +
>>>> +	lp87565->regmap = devm_regmap_init_i2c(client, &lp87565_regmap_config);
>>>> +	if (IS_ERR(lp87565->regmap)) {
>>>> +		ret = PTR_ERR(lp87565->regmap);
>>>> +		dev_err(lp87565->dev,
>>>> +			"Failed to initialize register map: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	ret = regmap_read(lp87565->regmap, LP87565_REG_OTP_REV, &otpid);
>>>> +	if (ret) {
>>>> +		dev_err(lp87565->dev, "Failed to read OTP ID\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	lp87565->rev = otpid & LP87565_OTP_REV_OTP_ID;
>>>> +
>>>> +	of_id = of_match_device(of_lp87565_match_table, &client->dev);
>>>> +	if (of_id)
>>>> +		lp87565->dev_type = (enum lp87565_device_type)of_id->data;
>>>
>>> So you can interigate the device for a revision number, but not a
>>> device type ID, is that correct?
>>
>> I hope you meant integrate? Revision of a particular type. Then device
>> type can mean something like lp87565-q1 which is modeling 4 individual
>> regulators as 2 dual phase regulators. There can be other devices which
>> has 4 single phase regulators. I have no document which talks about that
>> yet but possible.
> 
> No I meant "interrogate".  Odd that my spell checker didn't pick that
> one up.
> 
> I'll put it another way.  You are able to read the revision number
> from the device, right?  Is there another register that you can read
> from to obtain the device type?

Ah okay. Understood now. I went through data sheet all over again,
unfortunately there is no register which tells me the device type.

> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
