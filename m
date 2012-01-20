From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 18:14:44 +0530
Message-ID: <CAAL8m4xoT72T+3gtOEGdJOuUna04hDGS=xUuoRX4_EPNrT23pQ@mail.gmail.com>
References: <1327055619.1921.57.camel@deskari> <CAAL8m4xNj=-=tz7Fkv_MQzvQy5iNj9n10=00KAi0=ixtQ1GVVA@mail.gmail.com>
 <1327057644.1921.59.camel@deskari> <CAAL8m4zN7iRAWcV32+z+MrFcgaOnk_r-npA9uLLS+S7w1O2LYg@mail.gmail.com>
 <CAORVsuXGf4Cvxnsbw1yRoRmWiX+M4CZMU2Wpnj4PF=k2i4u-aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53316 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750950Ab2ATMpH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 07:45:07 -0500
Received: by lahc1 with SMTP id c1so295729lah.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 04:45:05 -0800 (PST)
In-Reply-To: <CAORVsuXGf4Cvxnsbw1yRoRmWiX+M4CZMU2Wpnj4PF=k2i4u-aw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>, Rajendra Nayak <rnayak@ti.com>

On Fri, Jan 20, 2012 at 6:02 PM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> Govindraj,
>
> On Fri, Jan 20, 2012 at 12:21 PM, Govindraj <govindraj.ti@gmail.com> =
wrote:
>> On Fri, Jan 20, 2012 at 4:37 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>>> On Fri, 2012-01-20 at 16:19 +0530, Govindraj wrote:
>>>> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti=
=2Ecom> wrote:
>>>> > Hi,
>>>> >
>>>> > I'm testing v3.3-rc1 on OMAP3 overo, and I'm having problems pro=
bably
>>>> > related to PM.
>>>> >
>>>> > First, when I boot up, the console (via USB serial) is very lagg=
y, it
>>>> > often takes many seconds until the key pressed appears so it's m=
ore or
>>>> > less unusable.
>>>>
>>>> can you try enabling CONFIG_CPU_IDLE ?
>>>
>>> Enabling CPU_IDLE does remove the problems. I don't know what it's
>>> supposed to do, but it seems to keep the MPU and DSS in ON state al=
l the
>>> time, so the problem disappears.
>>
>> 3.3-rc1 has uart runtime patches merged we have removed uart depende=
ncy
>> for system to enter low powers states and used pm_qos calls,
>> but pm_qos api's seem do get activated only by enabling =A0config_cp=
u_idle.
>>
>> Question to kevin/Paul,
>>
>> Shouldn't system be doing wfi if cpu_idle is not enabled ?
>>
>> since we are mapping omap3_pm_idle to pm_idle thread
>> system enters low power states even if config_cpu_idle is not enable=
d.
>> Is this expected behavior?

> Yes the wfi instruction gets executed in all cases.
> However with CPU_IDLE enabled a valid C-state is selected, depending
> on the requested PM QoS constraints. Then the MPU and CORE next power
> states are programmed accordingly.
>

okay, but if cpuidle is not selected shouldn't it prevent system from g=
oing
to low power state.


--
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
