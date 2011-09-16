From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/8] OMAP: convert I2C driver to PM QoS for latency constraints
Date: Fri, 16 Sep 2011 09:06:52 -0700
Message-ID: <87d3f0sc83.fsf@ti.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
	<1314969204-21704-2-git-send-email-j-pihet@ti.com>
	<87aaa5whj1.fsf@ti.com>
	<CAORVsuVH=iK4-ajBjpU+rdquV5MV=JjkHzRcJavJ5=d2e7dCxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:52172 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755344Ab1IPQG6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 12:06:58 -0400
Received: by mail-gw0-f48.google.com with SMTP id 22so3772302gwj.21
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 09:06:57 -0700 (PDT)
In-Reply-To: <CAORVsuVH=iK4-ajBjpU+rdquV5MV=JjkHzRcJavJ5=d2e7dCxw@mail.gmail.com>
	(Jean Pihet's message of "Fri, 16 Sep 2011 17:39:46 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Kevin,
>
> On Fri, Sep 16, 2011 at 12:46 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>> Hi Jean,
>>
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
>>> API to the new PM QoS API.
>>> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DM=
A_LATENCY
>>> class of PM QoS. The resulting MPU constraints are used by cpuidle =
to
>>> decide the next power state of the MPU subsystem.
>>>
>>> Currently only OMAP3 is placing constraints on the MPU.
>>>
>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>
>> [...]
>>
>>> @@ -648,8 +648,16 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct=
 i2c_msg msgs[], int num)
>>> =C2=A0 =C2=A0 =C2=A0 if (r < 0)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>>>
>>> - =C2=A0 =C2=A0 if (dev->set_mpu_wkup_lat !=3D NULL)
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev->set_mpu_wkup_lat(d=
ev->dev, dev->latency);
>>> + =C2=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0* When waiting for completion of a i2c transf=
er, we need to
>>> + =C2=A0 =C2=A0 =C2=A0* set a wake up latency constraint for the MP=
U. This is to
>>> + =C2=A0 =C2=A0 =C2=A0* ensure quick enough wakeup from idle, when =
transfer
>>> + =C2=A0 =C2=A0 =C2=A0* completes.
>>> + =C2=A0 =C2=A0 =C2=A0* Used on OMAP3 Only
>>> + =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 if (cpu_is_omap34xx())
>>
>> We don't want any cpu_is_* checking =C2=A0in drivers.
>>
>> If this is only done on certain SoCs, then a flag should be passed f=
rom
>> device init code via pdata.
>>
>> That being said, I don't see why this shouldn't be set for all SoCs
>> since it's using the FIFO size to determine the latency.
> I am OK to have the constraints active for all OMAPs. Side question:
> what if different SOCs need different values for the constraint?

This latency calculation is based on FIFO size and drain rate, so it
should be completely SoC independent.

However, if for some reason there are SoC dependencies, the SoC specifi=
c
parts need to be passed in to the driver.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
