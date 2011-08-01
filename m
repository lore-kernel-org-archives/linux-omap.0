From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: Re: timing in driver function
Date: Mon, 1 Aug 2011 11:55:33 -0500
Message-ID: <CAPCu-pQD42TLM2x+Of0XwVu3bkGqfsMQRQfW3V_-S=NxKJVaxQ@mail.gmail.com>
References: <4E36C30E.9060809@matrix-vision.de>
	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D09A78D@dbde03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:34318 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753262Ab1HAQze convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Aug 2011 12:55:34 -0400
Received: by mail-yw0-f50.google.com with SMTP id 12so852401ywa.9
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 09:55:33 -0700 (PDT)
In-Reply-To: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D09A78D@dbde03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Michael Jones <michael.jones@matrix-vision.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 1, 2011 at 10:34 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> Michael Jones wrote:
>> I have a function in a driver which takes ~50ms to execute, which I'=
ve
>> measured by reading jiffies at the beginning and end. But jiffies on=
ly
>> counts at 128Hz on my system, so this was a very coarse measurement.=
 Now
>> I would like to find out more exactly where the time is going inside
>> this function. So my basic question is, what is the best way to meas=
ure
>> lapsed time with reasonable resolution on an OMAP?
>>
>> As I had done with the jiffies measurement, what I imagined was
>> inserting lines into my function, sampling the value of some counter=
 at
>> various points within it. This approach is crude but simple and woul=
d
>> suffice for my case.
>>
>> Since it must be a very common task, I thought I'd ask here what the
>> recommended approach is. I see a few directions...
>>
>> 1. Using the OMAP's 32kHz timer, which is provided as a "struct
>> clocksource". It seems like what I would want is to call
>> clocksource_32k.read(), but I don't know how to retrieve clocksource=
_32k.
>>
>
> If you're looking for a one-off profiling, then as a hack, you could
> export a function that unconditionally returns the value of the 32kHz
> timer's count register (32KSYNCNT_CR) and use that for profiling.
>
How about using GPT using dm-timer APIs?
> - Anand
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20

Thank you and Regards
Subbu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
