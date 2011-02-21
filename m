From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] headers: fix circular dependency between
 linux/sched.h and linux/wait.h
Date: Mon, 21 Feb 2011 13:05:51 +0200
Message-ID: <AANLkTimwvgLvpvndCqcd_okA2Kk4cu7z4bD3QXTdgWJW@mail.gmail.com>
References: <1298283649-24532-1-git-send-email-dacohen@gmail.com>
	<1298283649-24532-2-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1298283649-24532-2-git-send-email-dacohen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 21, 2011 at 12:20 PM, David Cohen <dacohen@gmail.com> wrote=
:
> Currently sched.h and wait.h have circular dependency between both.
> wait.h defines macros wake_up*() which use macros TASK_* defined by
> sched.h. But as sched.h indirectly includes wait.h, such wait.h heade=
r
> file can't include sched.h too. The side effect is when some file
> includes wait.h and tries to use its wake_up*() macros, it's necessar=
y
> to include sched.h also.
> This patch moves all TASK_* macros from linux/sched.h to a new header
> file linux/task_sched.h. This way, both sched.h and wait.h can includ=
e
> task_sched.h and fix the circular dependency. No need to include sche=
d.h
> anymore when wake_up*() macros are used.

Just include <linux/sched.h> in your driver.
This include splitting in small pieces is troublesome as well.

Why are you moving TASK_COMM_LEN?

> =A0include/linux/sched.h =A0 =A0 =A0| =A0 61 +-----------------------=
------------------
> =A0include/linux/task_sched.h | =A0 64 ++++++++++++++++++++++++++++++=
++++++++++++++
> =A0include/linux/wait.h =A0 =A0 =A0 | =A0 =A01 +
> =A03 files changed, 66 insertions(+), 60 deletions(-)
> =A0create mode 100644 include/linux/task_sched.h

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> +#include <linux/task_sched.h>
