From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/1] headers: fix circular dependency between
 linux/sched.h and linux/wait.h
Date: Mon, 21 Feb 2011 18:06:02 +0100
Message-ID: <1298307962.24121.27.camel@twins>
References: <1298299131-17695-1-git-send-email-dacohen@gmail.com>
	 <1298299131-17695-2-git-send-email-dacohen@gmail.com>
	 <1298303677.24121.1.camel@twins>
	 <AANLkTimOT6jNG3=TiRMJR0dgEQ6EHjcBPJ1ivCu3Wj5Q@mail.gmail.com>
	 <1298305245.24121.7.camel@twins>
	 <20110221162939.GK23087@legolas.emea.dhcp.ti.com>
	 <1298306607.24121.18.camel@twins>
	 <20110221165443.GL23087@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110221165443.GL23087@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: David Cohen <dacohen@gmail.com>, linux-kernel@vger.kernel.org, mingo@elte.hu, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 2011-02-21 at 18:54 +0200, Felipe Balbi wrote:

> What you seem to have missed is that sched.h doesn't include wait.h, it
> includes completion.h and completion.h needs wait.h due the
> wait_queue_head_t it uses.

Yeah, so? sched.h doesn't need completion.h, but like with wait.h I'd
argue the other way around, completion.h would want to include sched.h

> If someone finds a cleaner way to drop that need, then I'm all for it as
> my original suggestion to the original patch was to include sched.h in
> wait.h, but it turned out that it's not possible due to the reasons
> already explained.

Feh,. I'm saying the proposed solution stinks and if you want to make
things better you need to work on fixing whatever is in the way of
including sched.h from wait.h.

1) remove the inclusion of completion.h -- easy we can live with an
incomplete type.

2) move the other wait_queue_head_t users (signal_struct sighand_struct)
out of sched.h

3) ...

4) profit!

Just isolating the TASK_state bits isn't going to be enough, wait.h also
wants wake_up goo and schedule*(), therefore either include sched.h from
whatever .c file you're using wait.h bits or do the above cleanup.
