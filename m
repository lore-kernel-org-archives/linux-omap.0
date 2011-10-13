From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v6 10/16] OMAP2+: UART: Modify omap_uart_can_sleep function
Date: Thu, 13 Oct 2011 08:59:57 +0200
Message-ID: <CAORVsuUsE09P0v-Ro7PctkE96mF4Cnefe9cASYJu447tVNBJ-g@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
	<87vcrv2xox.fsf@ti.com>
	<CAAL8m4xTmz+-ureDiGPoKUu634q1Wy=h01kpfRWCk9LFCV0+Dg@mail.gmail.com>
	<87wrcangkq.fsf@ti.com>
	<CAAL8m4zAOw9=qFCYV6-FxqGxQKwNZf71McCUtXSxoFMdOqz5PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4zAOw9=qFCYV6-FxqGxQKwNZf71McCUtXSxoFMdOqz5PA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Govindraj,

On Thu, Oct 13, 2011 at 3:09 AM, Govindraj <govindraj.ti@gmail.com> wro=
te:
=2E..
>>
>> Yes, but obviously comes at the expense of power savings. =A0IOW, Th=
is is
>> a hard-coded power vs. performance trade off that we are trying to g=
et
>> away from.
>>
>> So, the root of the problem is that the MPU wakeup latency is causin=
g a
>> "sluggish" console. =A0The solution? =A0request an MPU wakeup latenc=
y
>> constraint.
>>
>
> Okay, Will explore this.
>
>> This is a classic use-case for such a constraint, and the serial dri=
ver
>> should have the option of requesting a constraint to prevent the slu=
ggish
>> console. =A0The constraint only needs to be held until the auto-susp=
end
>> delay expires, so should be relased in the ->runtime_suspend() metho=
d of
>> the driver.
>>
>> This constraint needs to be configurable, probably from the board fi=
le,
>> so that it is optional, and so users who don't care about sluggish
>> consoles (or non-console UART users who don't care about response ti=
me)
>> have the option of preferring power savings over UART responsiveness=
=2E
>>
>> As a reference, the i2c driver is currently doing something similar
>> in that it request an MPU constraint to prevent the MPU from going i=
nto
>> retention/off while waiting for an i2c interrupt to arrive.
>>
>
> Thanks, will check and try to use the mpu constraints
As a reference the pm-qos branch of
https://gitorious.org/jpihet/omap-pm has the latest code for the
per-device constraints framework.

Please refer to the documentation at Documentation/power/pm_qos_interfa=
ce.txt.
The commit dbec9ed1 [1] shows how I2C is using the framework.

[1] https://gitorious.org/jpihet/omap-pm/commit/dbec9ed1a6d6341d2ad2352=
a9578d66d15d198f4

Regards,
Jean

>
> --
> Govindraj.R.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
