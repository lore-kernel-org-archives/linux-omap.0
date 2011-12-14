From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Wed, 14 Dec 2011 10:56:21 -0800
Message-ID: <87r507oucq.fsf@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
	<CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
	<87fwgow9vz.fsf@ti.com>
	<CAAL8m4wR-3WDYf_c56-h1ZtCg=Ob2T+FvOOaXLSKK1pyo9oh8Q@mail.gmail.com>
	<877h1znpdo.fsf@ti.com>
	<CAAL8m4x6ToG5uuKebqSvJaYg6YQjwFK017AiOFVm0-6BtmiCCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAAL8m4x6ToG5uuKebqSvJaYg6YQjwFK017AiOFVm0-6BtmiCCA@mail.gmail.com>
	(Govindraj's message of "Wed, 14 Dec 2011 21:50:08 +0530")
Sender: linux-serial-owner@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Wed, Dec 14, 2011 at 8:59 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Govindraj <govindraj.ti@gmail.com> writes:
>>
>>> On Wed, Dec 14, 2011 at 12:56 AM, Kevin Hilman <khilman@ti.com> wro=
te:
>>>> Govindraj <govindraj.ti@gmail.com> writes:
>>>>
>>>> [...]
>>>>
>>>>> I have re-based this patch series against LO master
>>>>> commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a
>>>>>
>>>>> Same is available here [1]
>>>>>
>>>>> I have tested this patch series along with:
>>>>>
>>>>> 1.) Tero's V11 irq chaining series
>>>>> =C2=A0 =C2=A0 =C2=A0http://www.spinics.net/lists/linux-omap/msg61=
445.html
>>>>> =C2=A0 =C2=A0 (This patch series is used for uart wakeup handling=
 using
>>>>> =C2=A0 =C2=A0 =C2=A0 prcm_irq chaining)
>>>>>
>>>>> 2.) Rajendra's hwmod change
>>>>> =C2=A0 =C2=A0 =C2=A0http://www.spinics.net/lists/arm-kernel/msg14=
8632.html
>>>>> =C2=A0 =C2=A0 =C2=A0(This patch handles init_no_idle flag setting
>>>>> =C2=A0 =C2=A0 =C2=A0 without this patch there will be boot warnin=
g however
>>>>> =C2=A0 =C2=A0 =C2=A0 all pm features will work after boot up.)
>>>>>
>>>>> 3.) Vishwa's io daisy chain changes.
>>>>> =C2=A0 =C2=A0 =C2=A0http://permalink.gmane.org/gmane.linux.ports.=
arm.omap/65500
>>>>> =C2=A0 =C2=A0 =C2=A0(tested with and without this patch series pm=
 features works).
>>>>>
>>>>> Same combination of patches based on above commit id
>>>>> used for testing is available here [2].
>>>>
>>>> Please have a closer look at your branch.
>>>>
>>>> The second commit[1] commits the .rej file from a failed patch app=
ly,
>>>> so obviously doesn't do what was intended.
>>>>
>>>
>>> Sorry my bad I have refreshed the uart runtime branch [1]
>>> & test branch [2].
>>
>> Can you add another patch which fixes these compiler warnings:
>>
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c: In function '=
serial_omap_irq':
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:228:29: warnin=
g: 'ch' may be used uninitialized in this function [-Wuninitialized]
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:176:16: note: =
'ch' was declared here
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:228:29: warnin=
g: 'ch' may be used uninitialized in this function [-Wuninitialized]
>> /work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:176:16: note: =
'ch' was declared here
>>
>
> Here is the patch [1] and pushed to
> git://gitorious.org/runtime_3-0/runtime_3-0.git for_3_3/lo_rc4_uartru=
ntime

Thanks!

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
