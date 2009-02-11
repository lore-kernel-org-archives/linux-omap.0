From: "Alejandro Blanca G." <alex.blanca@gmail.com>
Subject: Re: OMAP I2C question
Date: Wed, 11 Feb 2009 13:11:29 -0600
Message-ID: <b6ab3a160902111111s15d2143pf7a72159aeb9cdad@mail.gmail.com>
References: <499303C3.3030101@mlbassoc.com>
	 <b6ab3a160902110936m6f8798fbv70f5371b76594869@mail.gmail.com>
	 <b6ab3a160902110937t3cb1f26dmb99713464a14f444@mail.gmail.com>
	 <49930F15.4070302@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:13150 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbZBKTLa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Feb 2009 14:11:30 -0500
Received: by yx-out-2324.google.com with SMTP id 8so177544yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Feb 2009 11:11:29 -0800 (PST)
In-Reply-To: <49930F15.4070302@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org

My mistake.

Thought I had replied to the list, but referencing you.

I'm deeply deeply sorry for the trouble.

Thanks for forwarding it to the list.

Best regards,

Alex B.

On Wed, Feb 11, 2009 at 11:47 AM, Gary Thomas <gary@mlbassoc.com> wrote:
> Note: these questions should go to the mailing list, not me.  I'm not
> an expert here, just trying to get it working as well...
>
> Alejandro Blanca G. wrote:
>> Sorry, forgot to add that we are using the I2C tools on a Beagle, with
>> the latest kernel (2.6.29-rc4-omap1).
>>
>> Regards,
>>
>> Alex B.
>>
>> On Wed, Feb 11, 2009 at 11:36 AM, Alejandro Blanca G.
>> <alex.blanca@gmail.com> wrote:
>>> Hi Gary.
>>>
>>> Would this prevent the I2C tools
>>> (http://www.lm-sensors.org/wiki/I2CTools) from working?
>>>
>>> In the latest kernels we've built, we have been unable to use
>>> "i2cdetect" to verify the presence of I2C devices. The error we get
>>> is:
>>>
>>> "Error: Can't use SMBus Quick Write command on this bus (ISA bus?)".
>>>
>>> From the description you provide, it seems related.
>>>
>>> Best regards,
>>>
>>> Alex B.
>>>
>>> On Wed, Feb 11, 2009 at 10:58 AM, Gary Thomas <gary@mlbassoc.com> wrote:
>>>> Why is I2C_FUNC_SMBUS_QUICK functionality missing in i2c-omap.c?
>>>>
>>>> This prevents using drivers which use the generic i2c_probe()
>>>> method of finding devices.
>>>>
>>>> --
>>>> ------------------------------------------------------------
>>>> Gary Thomas                 |  Consulting for the
>>>> MLB Associates              |    Embedded world
>>>> ------------------------------------------------------------
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>
>
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
>
