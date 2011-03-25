From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 13/19] OMAP2+: voltage: keep track of powerdomains in
 each voltagedomain
Date: Fri, 25 Mar 2011 17:52:20 +0100
Message-ID: <AANLkTinoOp6izhTK0wFhS29Z5EjPg4n3jFTfjzxUHCrT@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-14-git-send-email-khilman@ti.com>
	<AANLkTi=JD=QJKBWekHDW08JOxrvntmTfMfTK9Eq_xH9Y@mail.gmail.com>
	<87hbartcrf.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52088 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab1CYQwV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 12:52:21 -0400
Received: by qyg14 with SMTP id 14so831813qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 09:52:20 -0700 (PDT)
In-Reply-To: <87hbartcrf.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, Mar 25, 2011 at 4:56 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
> [...]
>
>>> +
>>> +/**
>>> + * voltdm_for_each - call function on each registered voltagedomai=
n
>>> + * @fn: callback function *
>>> + *
>>> + * Call the supplied function @fn for each registered voltagedomai=
n.
>>> + * The callback function @fn can return anything but 0 to bail out
>>> + * early from the iterator. =A0Returns the last return value of th=
e
>>> + * callback function, which should be 0 for success or anything el=
se
>>> + * to indicate failure; or -EINVAL if the function pointer is null=
=2E
>>
>> The function description does not match the prototype.
>>
>
> in what way?
>
> the description is wrong in how it describes the "bail out" but I don=
't
> see what you mean for the prototype.
'user' is not in the list of parmaters, not it is present in the
function description.

>
> [...]
>
>>>
>>> +struct powerdomain;
>>> +
>>> +/*
>>> + * Maximum number of powerdomains that can be associated with a vo=
ltagedomain.
>>> + */
>>> +#define VOLTDM_MAX_PWRDMS =A0 =A0 =A0 =A0 =A0 =A0 10
>> This is not used in the patch. Is it needed?
>>
>
> Nope. =A0Will drop.
Ok

>
> Thanks,
>
> Kevin
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
