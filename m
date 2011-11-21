From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v8 17/20] OMAP2+: UART: Use custom activate func for
 console uart.
Date: Mon, 21 Nov 2011 19:21:53 +0530
Message-ID: <CAAL8m4yAfzVEH7wW5zrOrnjCi_QnvCvXAZ0wfJ-6cKWNZ25Mfg@mail.gmail.com>
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-3-git-send-email-govindraj.raja@ti.com> <87vcqhuns9.fsf@ti.com>
 <CAAL8m4yft7_SQFrXtDZg5X5SJrKep0_j5D9_y1-QooSox+HZpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4yft7_SQFrXtDZg5X5SJrKep0_j5D9_y1-QooSox+HZpg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 21, 2011 at 7:17 PM, Govindraj <govindraj.ti@gmail.com> wrote:
> On Sat, Nov 19, 2011 at 2:54 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> Omap-uart can be used as console uart to print early boot
>>> messages using earlyprintk so for console uart prevent
>>> hwmod reset or idling during bootup.
>>>
>>> Identify the console_uart set the id and use the custom
>>> pm_latency ops for console uart for the first time
>>> to idle console uart left enabled from bootup and then enable
>>> them back and reset pm_latency ops to default ops.
>>>
>>> Thanks to Kevin Hilman <khilman@ti.com> for suggesting
>>> this approach.
>>
>> You're welcome, but Rajendra's solution is much better. ;)
>
> Agree.
>
>>
>> Can you updated your branch without these custom hooks and using
>> Rajendra's INIT_NO_IDLE change to the hwmod core.
>>
>
> Yes done, rebased on 3.2-rc2 and created a new branch [1].
>
> Removed custom activate function usage and used Rajendra's hwmod patch[2]
>
> --
> Thanks,
> Govindraj.R
>
> [1]:
> git://gitorious.org/runtime_3-0/runtime_3-0.git
> 3.2-rc1_uart_runtime
   ^^^^^^^^^^^^^^^^^^^^^^^^^

small correction new branch is
3.2-rc2_uart_runtime

--
Thanks,
Govindraj.R
