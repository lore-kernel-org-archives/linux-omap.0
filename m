From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCHv2] omap: rx51: Platform support for lp5523 led chip
Date: Tue, 5 Apr 2011 15:00:11 +0300
Message-ID: <4D9B044B.7000604@nokia.com>
References: <alpine.DEB.1.10.1103311524420.2634@esdhcp041196.research.nokia.com> <1301578692-29286-1-git-send-email-ameya.palande@nokia.com> <20110331142635.GF5465@legolas.emea.dhcp.ti.com> <4D949E18.6090704@nokia.com> <20110331154421.GN5465@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:40505 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904Ab1DEMA7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Apr 2011 08:00:59 -0400
In-Reply-To: <20110331154421.GN5465@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, mathias.nyman@nokia.com, linux-arm-kernel@lists.infradead.org

Hi Felipe,

On 03/31/2011 06:44 PM, ext Felipe Balbi wrote:
> On Thu, Mar 31, 2011 at 06:30:32PM +0300, Ameya Palande wrote:
>> Hi Felipe,
>>
>> On 03/31/2011 05:26 PM, ext Felipe Balbi wrote:
>>> Hi,
>>>
>>> On Thu, Mar 31, 2011 at 04:38:12PM +0300, Ameya Palande wrote:
>>>> +static int rx51_lp5523_setup(void)
>>>> +{
>>>> +	int err;
>>>> +
>>>> +	err = gpio_request_one(RX51_LP5523_CHIP_EN_GPIO, GPIOF_DIR_OUT,
>>>> +			"lp5523_enable");
>>>> +	if (err<   0) {
>>>> +		pr_err("Unable to get lp5523_enable GPIO\n");
>>>> +		return err;
>>>> +	}
>>>> +
>>>> +	return err;
>>>
>>> isn't enough to return gpio_request_one(RX51_LP5523_CHIP_EN_GPIO,
>>> GPIOF_DIR_OUT, "lp5523_enable"); ??
>>
>> But then we won't know the failure reason for lp5523_probe()
>> I would prefer printing an error!
>
> see that both gpio_request() and gpio_direction_output() have debugging
> prints for error cases ;-)

Any comments about the version 3 of this patch?

Cheers,
Ameya.
