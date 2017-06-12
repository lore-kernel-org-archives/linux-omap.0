From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4] mfd: lp87565: Add lp87565 PMIC support
Date: Mon, 12 Jun 2017 11:27:09 +0200
Message-ID: <CABxcv=nHOtGtwpt+fAMtHf6DpAzerxoho45yCJiJoS8cP-0c4Q@mail.gmail.com>
References: <1496894894-6969-1-git-send-email-j-keerthy@ti.com>
 <20170609142855.tfixhw3cb5qjkcne@rob-hp-laptop> <7596b39a-3135-7cca-e3dc-18c05cf54a8b@ti.com>
 <7e352aa3-4483-1fa4-e424-cc90f62cdf46@ti.com> <20170612091133.kt2doom32bun6ujp@dell>
 <373e82d1-39fb-9cbb-300a-aa8a99544cdc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <373e82d1-39fb-9cbb-300a-aa8a99544cdc-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Lee and Keerthy,

On Mon, Jun 12, 2017 at 11:17 AM, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> wrote:
>
>
> On Monday 12 June 2017 02:41 PM, Lee Jones wrote:
>> On Sun, 11 Jun 2017, Keerthy wrote:
>>
>>>
>>>
>>> On Sunday 11 June 2017 10:36 AM, Keerthy wrote:
>>>>
>>>>
>>>> On Friday 09 June 2017 07:58 PM, Rob Herring wrote:
>>>>> On Thu, Jun 08, 2017 at 09:38:14AM +0530, Keerthy wrote:
>>>>>> The LP87565 chip is a power management IC for Portable Navigation Systems
>>>>>> and Tablet Computing devices. It contains the following components:
>>>>>>
>>>>>>         - Configurable Bucks(Single and multi-phase).
>>>>>>         - Configurable General Purpose Output Signals (GPO).
>>>>>>
>>>>>> The LP87565-Q1 variant device uses two 2-phase outputs configuration,
>>>>>> Buck0 is master for Buck0/1 output and Buck2 is master for Buck2/3
>>>>>> output.
>>>>>>
>>>
>>> Lee Jones,
>>>
>>> Shall i add back i2c_device_id as pointed here:
>>> http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1417316.html
>>
>> Hasn't that been fixed yet?
>>

There are only 2 patch series remaining to be merged so we can finally
fix this in the I2C core, making sure that no drivers will be
regressed. One of the series is for MFD and have been around for a
while (it already contains all the relevant acks AFAICT), it would be
very helpful if you can look at it and merge if you think is correct:

https://lkml.org/lkml/2017/5/4/11

>> I guess so then. :(
>
> Okay. So with that i assume i should reintroduce probe instead of probe_new.
>

It's orthogonal, you can have probe_new and also the I2C device ID
table (the OF table will be used for matching, you just need the I2C
table to export the aliases with MODULE_DEVICE_TABLE(i2c,.. ).

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
