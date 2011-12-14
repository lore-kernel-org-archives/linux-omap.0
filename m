From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 00/20] OMAP2+: UART: Runtime adaptation + cleanup
Date: Wed, 14 Dec 2011 07:29:07 -0800
Message-ID: <877h1znpdo.fsf@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
	<CAAL8m4wGN5ykm3-+xrGPe-WJUDBdterxAyZ=C3kH862+n1DprQ@mail.gmail.com>
	<87fwgow9vz.fsf@ti.com>
	<CAAL8m4wR-3WDYf_c56-h1ZtCg=Ob2T+FvOOaXLSKK1pyo9oh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:33109 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753859Ab1LNP3Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 10:29:16 -0500
In-Reply-To: <CAAL8m4wR-3WDYf_c56-h1ZtCg=Ob2T+FvOOaXLSKK1pyo9oh8Q@mail.gmail.com>
	(Govindraj's message of "Wed, 14 Dec 2011 14:16:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Govindraj <govindraj.ti@gmail.com> writes:

> On Wed, Dec 14, 2011 at 12:56 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>> Govindraj <govindraj.ti@gmail.com> writes:
>>
>> [...]
>>
>>> I have re-based this patch series against LO master
>>> commit id: deee6d5359969a0ce4e2760cfd7b9f379bd5698a
>>>
>>> Same is available here [1]
>>>
>>> I have tested this patch series along with:
>>>
>>> 1.) Tero's V11 irq chaining series
>>> =C2=A0 =C2=A0 =C2=A0http://www.spinics.net/lists/linux-omap/msg6144=
5.html
>>> =C2=A0 =C2=A0 (This patch series is used for uart wakeup handling u=
sing
>>> =C2=A0 =C2=A0 =C2=A0 prcm_irq chaining)
>>>
>>> 2.) Rajendra's hwmod change
>>> =C2=A0 =C2=A0 =C2=A0http://www.spinics.net/lists/arm-kernel/msg1486=
32.html
>>> =C2=A0 =C2=A0 =C2=A0(This patch handles init_no_idle flag setting
>>> =C2=A0 =C2=A0 =C2=A0 without this patch there will be boot warning =
however
>>> =C2=A0 =C2=A0 =C2=A0 all pm features will work after boot up.)
>>>
>>> 3.) Vishwa's io daisy chain changes.
>>> =C2=A0 =C2=A0 =C2=A0http://permalink.gmane.org/gmane.linux.ports.ar=
m.omap/65500
>>> =C2=A0 =C2=A0 =C2=A0(tested with and without this patch series pm f=
eatures works).
>>>
>>> Same combination of patches based on above commit id
>>> used for testing is available here [2].
>>
>> Please have a closer look at your branch.
>>
>> The second commit[1] commits the .rej file from a failed patch apply=
,
>> so obviously doesn't do what was intended.
>>
>
> Sorry my bad I have refreshed the uart runtime branch [1]
> & test branch [2].

Can you add another patch which fixes these compiler warnings:

/work/kernel/omap/pm/drivers/tty/serial/omap-serial.c: In function 'ser=
ial_omap_irq':
/work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:228:29: warning: =
'ch' may be used uninitialized in this function [-Wuninitialized]
/work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:176:16: note: 'ch=
' was declared here
/work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:228:29: warning: =
'ch' may be used uninitialized in this function [-Wuninitialized]
/work/kernel/omap/pm/drivers/tty/serial/omap-serial.c:176:16: note: 'ch=
' was declared here

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
