From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 1/1] headers: fix circular dependency between
 linux/sched.h and linux/wait.h
Date: Mon, 21 Feb 2011 14:11:42 +0200
Message-ID: <AANLkTi=kL1+qKys0ZCTRb_9GgzadS8Stbai+cR-KNoAU@mail.gmail.com>
References: <1298283649-24532-1-git-send-email-dacohen@gmail.com>
	<1298283649-24532-2-git-send-email-dacohen@gmail.com>
	<AANLkTimwvgLvpvndCqcd_okA2Kk4cu7z4bD3QXTdgWJW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimwvgLvpvndCqcd_okA2Kk4cu7z4bD3QXTdgWJW@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 21, 2011 at 1:05 PM, Alexey Dobriyan <adobriyan@gmail.com> =
wrote:
> On Mon, Feb 21, 2011 at 12:20 PM, David Cohen <dacohen@gmail.com> wro=
te:
>> Currently sched.h and wait.h have circular dependency between both.
>> wait.h defines macros wake_up*() which use macros TASK_* defined by
>> sched.h. But as sched.h indirectly includes wait.h, such wait.h head=
er
>> file can't include sched.h too. The side effect is when some file
>> includes wait.h and tries to use its wake_up*() macros, it's necessa=
ry
>> to include sched.h also.
>> This patch moves all TASK_* macros from linux/sched.h to a new heade=
r
>> file linux/task_sched.h. This way, both sched.h and wait.h can inclu=
de
>> task_sched.h and fix the circular dependency. No need to include sch=
ed.h
>> anymore when wake_up*() macros are used.
>
> Just include <linux/sched.h> in your driver.

Sounds a reasonable solution for me.

> This include splitting in small pieces is troublesome as well.

But I disagree it's troublesome. It's transparent to everyone else.
The only side effect is to not have to include sched.h when using a
macro define on wait.h.

>
> Why are you moving TASK_COMM_LEN?

This one can be moved back to sched.h.

Br,

David

>
>> =C2=A0include/linux/sched.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 61 +-------=
----------------------------------
>> =C2=A0include/linux/task_sched.h | =C2=A0 64 +++++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0include/linux/wait.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A03 files changed, 66 insertions(+), 60 deletions(-)
>> =C2=A0create mode 100644 include/linux/task_sched.h
>
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> +#include <linux/task_sched.h>
>
