From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 1/7] OMAP2+: hwmod: remove unused voltagedomain pointer
Date: Fri, 25 Mar 2011 10:30:37 +0530
Message-ID: <AANLkTim4PODqUjSjeXN7RDj2iqe6C6hMFK5sx7pVZ6Xv@mail.gmail.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
	<1300493932-17362-2-git-send-email-khilman@ti.com>
	<4D874DC9.6020203@ti.com>
	<87vczcfq19.fsf@ti.com>
	<AANLkTi==Mz=szoa78EaRKgqTddOeu5xEeg5hfNWbWWO2@mail.gmail.com>
	<87tyes39ew.fsf@ti.com>
	<4D8B5FCB.1050006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:56382 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1749667Ab1CYFAk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 01:00:40 -0400
Received: by bwz1 with SMTP id 1so813834bwz.36
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 22:00:37 -0700 (PDT)
In-Reply-To: <4D8B5FCB.1050006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsely <paul@pwsan.com>

Hi,

On Thu, Mar 24, 2011 at 8:44 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 3/24/2011 3:00 PM, Hilman, Kevin wrote:
>>
>> Hi Shweta,
>>
>> "Gulati, Shweta"<shweta.gulati@ti.com> =A0writes:
>>
>> [...]
>>
>>>>>
>>>>> And what about vdd_name? It should probably be removed as well.
>>>>>
>>>>
>>>> Yes, but it's currently used by the SR layer (currently the only u=
ser.)
>>>>
>>>> Removing it required cleaning up the SR layer as well, so I decide=
d to
>>>> leave the SR cleanups for someone else for the moment while I focu=
s on
>>>> the voltage layer(s)
>>>>
>>> Even if we try to remove 'vdd_name', how should we get 'struct
>>> voltagedomain'
>>> info corresponding to sr_mpu, sr_core in sr_dev_init API?
>>>
>>> As functional clock of SR1 and SR2 are from wake up domain, so even=
 if
>>> we try to use current Clockdomain and Powerdomain framework APIs, t=
o
>>> get 'clkdomain' pointer and then retrieve 'pwrdomain' pointer, fina=
lly
>>> getting 'voltdomain' pointer we would get 'WKUP' voltage domain ptr
>>> not the 'mpu' or 'core' voltdomain pointer.
>>
>> Correct.
>>
>> I got this far and realized not only does the voltage layer need a
>> cleanup, the SR layer needs a cleanup, but I need to focus on one th=
ing
>> at a time.
>>
>> As you noticed, what we need is the voltage domain of the SR sensor,=
 not
>> the voltage domain of the SR IP.
>>
>> Probably the best way to do this is ad the sensor voltage domain to =
the
>> dev_attr of each SR module.
>
> Yep, I do agree. SR instances are all inside the CORE, but there is a
> dedicated sensor in each scalable voltage domain.
> dev_attr is the perfect place for that. In fact I do not understand w=
hy it
> was not added there initially???
>
> Even the kerneldoc is confusing and not accurate:
> =A0* @vdd_name: voltage domain name
>
> Whereas, SR is using that to provide the name of the voltage rail con=
trolled
> by it.
>
> Let's provide a quick patch to get rid of that and replace it by a de=
v_attr.
>
> Shweta, are you volunteer? :-)
Yes, I would submit Patch adding volt domain info in dev_attr of SR ins=
tances.

> Thanks,
> Benoit
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
