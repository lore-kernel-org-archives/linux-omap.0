From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 10/16] OMAP2+: UART: Modify omap_uart_can_sleep function
Date: Thu, 13 Oct 2011 06:39:18 +0530
Message-ID: <CAAL8m4zAOw9=qFCYV6-FxqGxQKwNZf71McCUtXSxoFMdOqz5PA@mail.gmail.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
 <87vcrv2xox.fsf@ti.com> <CAAL8m4xTmz+-ureDiGPoKUu634q1Wy=h01kpfRWCk9LFCV0+Dg@mail.gmail.com>
 <87wrcangkq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87wrcangkq.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 13, 2011 at 1:11 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>
>> On Tue, Oct 11, 2011 at 11:54 PM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>
>>>> Modify the omap_uart_can_sleep function to check uart is active
>>>> or not to be used by pm code to enter low power states.
>>>
>>> Doesn't the driver now control when the UART clocks are gated (usin=
g
>>> runtime PM autosuspend)?
>>>
>>> IMO, this check should be completely removed and the driver should
>>> be managing this with the autosuspend timeout.
>>>
>>>> Removing this check can cause console response little sluggish.
>>>
>>> Sluggish in what way?
>>>
>>
>> response is slower like when we type something or cat debugfs/pm_cou=
nt
>> see things little slower on console, there is no character loss.
>>
>> Happens even though we have not set the autosuspend timeout and uart
>> clocks are active, which basically means allowing mpu to enter
>> retention keeping uart active.
>
> OK, I see now.
>
>> this delay in response or sluggishness is not there on my 3430SDP or
>> 3630zoom board but I was able to see this behavior on a beagle
>> board(xm rev c).
>
> Here's why:
>
> The difference is the powerdomain that the console UART is on for the=
se
> boards. =A0UART1,2 are in CORE, UART2/3 are in PER. =A0 SDP uses UART=
1 (CORE),
> Zoom3 doesn't use OMAP UARTs at all, and Beagle uses UART3 (PER).
>
> Due to a HW sleepdep between MPU and CORE, MPU will not transition un=
til
> CORE does, which means MPU will not transition until UART 1 & 2 are
> idle.
>
> On Beagle, the console is ttyO2 (UART3) which is in PER, and since th=
e
> MPU is free to transition independently of PER, that is what is
> happening, resulting in slower response time on for any boards that h=
ave
> PER-UART consoles.
>
>> retaining this uart_can_sleep check in omap3_can_sleep ensures a bet=
ter
>> console user experience. (not allowing mpu to enter retention
>> until uart clocks are cut)
>
> Yes, but obviously comes at the expense of power savings. =A0IOW, Thi=
s is
> a hard-coded power vs. performance trade off that we are trying to ge=
t
> away from.
>
> So, the root of the problem is that the MPU wakeup latency is causing=
 a
> "sluggish" console. =A0The solution? =A0request an MPU wakeup latency
> constraint.
>

Okay, Will explore this.

> This is a classic use-case for such a constraint, and the serial driv=
er
> should have the option of requesting a constraint to prevent the slug=
gish
> console. =A0The constraint only needs to be held until the auto-suspe=
nd
> delay expires, so should be relased in the ->runtime_suspend() method=
 of
> the driver.
>
> This constraint needs to be configurable, probably from the board fil=
e,
> so that it is optional, and so users who don't care about sluggish
> consoles (or non-console UART users who don't care about response tim=
e)
> have the option of preferring power savings over UART responsiveness.
>
> As a reference, the i2c driver is currently doing something similar
> in that it request an MPU constraint to prevent the MPU from going in=
to
> retention/off while waiting for an i2c interrupt to arrive.
>

Thanks, will check and try to use the mpu constraints

--
Govindraj.R.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
