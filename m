From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/8] OMAP: convert I2C driver to PM QoS for latency constraints
Date: Fri, 16 Sep 2011 17:39:46 +0200
Message-ID: <CAORVsuVH=iK4-ajBjpU+rdquV5MV=JjkHzRcJavJ5=d2e7dCxw@mail.gmail.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
	<1314969204-21704-2-git-send-email-j-pihet@ti.com>
	<87aaa5whj1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:60661 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab1IPPjq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 11:39:46 -0400
Received: by vwl1 with SMTP id 1so7238820vwl.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 08:39:46 -0700 (PDT)
In-Reply-To: <87aaa5whj1.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

Kevin,

On Fri, Sep 16, 2011 at 12:46 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
>> API to the new PM QoS API.
>> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA=
_LATENCY
>> class of PM QoS. The resulting MPU constraints are used by cpuidle t=
o
>> decide the next power state of the MPU subsystem.
>>
>> Currently only OMAP3 is placing constraints on the MPU.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> [...]
>
>> @@ -648,8 +648,16 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct =
i2c_msg msgs[], int num)
>> =A0 =A0 =A0 if (r < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> - =A0 =A0 if (dev->set_mpu_wkup_lat !=3D NULL)
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev->set_mpu_wkup_lat(dev->dev, dev->laten=
cy);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* When waiting for completion of a i2c transfer, we nee=
d to
>> + =A0 =A0 =A0* set a wake up latency constraint for the MPU. This is=
 to
>> + =A0 =A0 =A0* ensure quick enough wakeup from idle, when transfer
>> + =A0 =A0 =A0* completes.
>> + =A0 =A0 =A0* Used on OMAP3 Only
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (cpu_is_omap34xx())
>
> We don't want any cpu_is_* checking =A0in drivers.
>
> If this is only done on certain SoCs, then a flag should be passed fr=
om
> device init code via pdata.
>
> That being said, I don't see why this shouldn't be set for all SoCs
> since it's using the FIFO size to determine the latency.
I am OK to have the constraints active for all OMAPs. Side question:
what if different SOCs need different values for the constraint?

>
> Kevin
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
