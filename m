From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
Date: Fri, 1 Jun 2012 09:15:45 +0530
Message-ID: <CAJ6a13YzgxK1QJVLd+ZKRM=w4mM3P3YXicwdazpBaRDqdUDHqA@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<87397by2h9.fsf@ti.com>
	<CAJ6a13aJwesHw0frCV+EfvYaep09cZGcu_PopuHzye1HS2tgvg@mail.gmail.com>
	<CAJ6a13YLogA7M=rzSJAW6fHZOujFY0Crfdz9Sc5qL0mt8kX9CA@mail.gmail.com>
	<87obpdv6f4.fsf@ti.com>
	<874nqwynxd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <874nqwynxd.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, greg@kroah.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, j-pihet@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 1, 2012 at 4:10 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kevin Hilman <khilman@ti.com> writes:
>
>> "J, KEERTHY" <j-keerthy@ti.com> writes:
>>
>>> On Tue, May 15, 2012 at 11:16 AM, J, KEERTHY <j-keerthy@ti.com> wro=
te:
>>>> On Tue, May 8, 2012 at 5:21 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>>>> Rafael,
>>>>>
>>>>> Keerthy <j-keerthy@ti.com> writes:
>>>>>
>>>>>> From: J Keerthy <j-keerthy@ti.com>
>>>>>>
>>>>>> AVS(Adaptive Voltage Scaling) is a power management technique wh=
ich
>>>>>> controls the operating voltage of a device in order to optimize =
(i.e. reduce)
>>>>>> its power consumption. The voltage is adapted depending on stati=
c factors
>>>>>> (chip manufacturing process) and dynamic factors (temperature
>>>>>> depending performance).
>>>>>> The TI AVS solution is named Smartreflex.
>>>>>>
>>>>>> To that end, create the AVS driver in drivers/power/avs and
>>>>>> move the OMAP SmartReflex code to the new directory. The
>>>>>> class driver is still retained in the mach-omap2 directory.
>>>>>
>>>>> How should we handle this for upstream?
>>>>>
>>>>> It does a bunch of cleanup under arch/arm then does the move to
>>>>> drivers/power the end. =A0To avoid conflicts with other OMAP core=
 changes,
>>>>> I would suggest we take this through the OMAP tree.
>>>>>
>>>>> With your ack, I'd be glad to take it.
>>>>
>>>> Hello Rafael,
>>>>
>>>> A gentle ping on this series.
>>>
>>> Hi Greg,
>>>
>>> This series has Kevin's comments incorporated.
>>>
>>> Kevin,
>>>
>>> Can i have your Ack for this series?
>>>
>>
>> Well, as mentioned above, I'm waiting for Rafael's ack, then I will
>> merge it.
>>
>> Because of all the arch/arm/mach-omap2/* changes, I would like to me=
rge
>> this via the OMAP tree to avoid conflicts with other stuff we have
>> changing in arch/arm/mach-omap2/*
>
> OK, I had an off-line discussion with Rafael and he's OK that I take
> these. =A0I will add an ack from Rafael and queue this series up for =
v3.6.

Thanks Kevin.

>
> Thanks,
>
> Kevin



--=20
Regards and Thanks,
Keerthy
