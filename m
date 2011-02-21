From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH resend] video: omap24xxcam: Fix compilation
Date: Mon, 21 Feb 2011 14:09:07 +0200
Message-ID: <AANLkTinf3Wj=nw_2Sx4r-VSsCH+=fzx-25hynH8hB0d9@mail.gmail.com>
References: <1297068547-10635-1-git-send-email-weber@corscience.de>
	<4D5A6353.7040907@maxwell.research.nokia.com>
	<20110215113717.GN2570@legolas.emea.dhcp.ti.com>
	<4D5A672A.7040000@samsung.com>
	<4D5A6874.1080705@corscience.de>
	<20110215115349.GQ2570@legolas.emea.dhcp.ti.com>
	<4D5A6EEC.5000908@maxwell.research.nokia.com>
	<AANLkTik+6fguqgH8Bpnpqo7Axmquy3caRMELTZVmuN1j@mail.gmail.com>
	<20110219150024.GA4487@legolas.emea.dhcp.ti.com>
	<AANLkTik5dwNZrUxjgjKeAQOsp610d6y_TNGg1b5Vc5Zd@mail.gmail.com>
	<20110221073640.GA3094@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20110221073640.GA3094@legolas.emea.dhcp.ti.com>
Sender: linux-media-owner@vger.kernel.org
To: balbi@ti.com
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Thomas Weber <weber@corscience.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-omap@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Hans Verkuil <hverkuil@xs4all.nl>, Tejun Heo <tj@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 21, 2011 at 9:36 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Sat, Feb 19, 2011 at 06:04:58PM +0200, David Cohen wrote:
>> > I have to disagree. The fundamental problem is the circular depend=
ency
>> > between those two files:
>> >
>> > sched.h uses wait_queue_head_t defined in wait.h
>> > wait.h uses TASK_* defined in sched.h
>> >
>> > So, IMO the real fix would be clear out the circular dependency. M=
aybe
>> > introducing <linux/task.h> to define those TASK_* symbols and incl=
ude
>> > that on sched.h and wait.h
>> >
>> > Just dig a quick and dirty to try it out and works like a charm
>>
>> We have 2 problems:
>> =C2=A0- omap24xxcam compilation broken
>> =C2=A0- circular dependency between sched.h and wait.h
>>
>> To fix the broken compilation we can do what the rest of the kernel =
is
>> doing, which is to include sched.h.
>> Then, the circular dependency is fixed by some different approach
>> which would probably change *all* current usage of TASK_*.
>
> considering that 1 is caused by 2 I would fix 2.
>
>> IMO, there's no need to create a dependency between those issues.
>
> There's no dependency between them, it's just that the root cause for
> this problem is a circular dependency between wait.h and sched.h

I did a try to fix this circular dependency and the comment I got was
to include sched.h in omap24xxcam.c file:
http://marc.info/?l=3Dlinux-omap&m=3D129828637120270&w=3D2

I'm working to remove v4l2 internal device interface from omap24xxcam
and then I need this driver's compilation fixed.
The whole kernel is including sched.h when wake_up*() macro is used,
so this should be our first solution IMO.
As I said earlier, no need to make this compilation fix be dependent
of wait.h fix (if it's really going to be changed).

I think we should proceed with this patch.

Br,

David

>
> --
> balbi
>
