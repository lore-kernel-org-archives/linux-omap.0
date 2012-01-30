From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 30 Jan 2012 19:14:43 +0000
Message-ID: <20120130191443.GB27764@mudshark.cambridge.arm.com>
References: <CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
 <CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
 <CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
 <CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
 <CACVXFVMDXO3DDj0mGh=+uDYfCoS_Ck1STVK0=UXjiAbtJTa=hA@mail.gmail.com>
 <CAMsRxfLqvPN_k7vuC3qzBjwX2ihBdPxZvmSCPZ3frWgptWXQGA@mail.gmail.com>
 <yw1xsjixgolb.fsf@unicorn.mansr.com>
 <CAMsRxfJLsnBnKBrEXOSOWUTbgfeZtVZ6nR8jt388=baL5Mn22Q@mail.gmail.com>
 <20120130172438.GC17814@mudshark.cambridge.arm.com>
 <CAMsRxfLc-wxx9pELJSdV2DmzGHpVmWOg7SAs=jm-s=5jaNh4HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:51616 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752404Ab2A3TPC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 14:15:02 -0500
Content-Disposition: inline
In-Reply-To: <CAMsRxfLc-wxx9pELJSdV2DmzGHpVmWOg7SAs=jm-s=5jaNh4HQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "eranian@gmail.com" <eranian@gmail.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Ming Lei <ming.lei@canonical.com>, "Cousson, Benoit" <b-cousson@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

On Mon, Jan 30, 2012 at 05:45:19PM +0000, stephane eranian wrote:
> There you go, no attachment, not sure the omap list
> supports this.

Cheers Stephane.

> There is something quite interesting to observe.
> 
> While I run perf record -e cycles -F 100 noploop 10, I watch
> /proc/interrupts. The number of interrupts is way lower than
> expected. Therefore the number of samples is way too low:
> 
> $ perf record -e cycles -F 100 noploop 10
> $ perf report -D | tail -20
> cycles stats:
>            TOTAL events:        535
>             MMAP events:         11
>             COMM events:          2
>             EXIT events:          2
>           SAMPLE events:        520
>
> The delta in /proc/interrupts on CPU1 is 520 interrupts.

Yes, that is about half of what you'd expect. Running on my A9 platform
(vexpress) I get:

$ perf record -e cycles -F 100 noploop 10
$ perf report -D | tail -20
cycles stats:
           TOTAL events:       1007
            MMAP events:         18
            COMM events:          2
            EXIT events:          2
          SAMPLE events:        985

> So looks like the frequency adjustment which is hooked off of the
> timer tick is either not called at each timer tick, the timer ticks are
> not at regular interval, or the math is wrong.

My hunch is that that the interval is probably varying, but I don't know much
about OMAP4 and its clocks.

> If I go with the fixed period mode:
> $ perf stat -e cycles noploop 10
> noploop for 10 seconds
>  Performance counter stats for 'noploop 10':
>        10079156960 cycles                    #    0.000 GHz
>       10.004547117 seconds time elapsed
> 
> That means, if I want 100 samples/sec: = 10079156960/(10*100)=10079157
> $ perf record -e cycles -c 10079157 noploop 10
> $ perf report -D | tail -20
> cycles stats:
>            TOTAL events:       1003
>             MMAP events:         11
>             COMM events:          2
>             EXIT events:          2
>         THROTTLE events:          1
>       UNTHROTTLE events:          1
>           SAMPLE events:        986
> 
> Now, we're getting the right answer!

Just to confirm, for me:

$ perf stat -e cycles ./noploop 10
noploop for 10 seconds

 Performance counter stats for './noploop 10':

        4001163930 cycles                    #    0.000 GHz

      10.006534024 seconds time elapsed

$ perf record -e cycles -c 4001163 ./noploop 10
$ perf report -D | tail -20
  Aggregated stats:
           TOTAL events:       1020
            MMAP events:         18
            COMM events:          2
            EXIT events:          2
          SAMPLE events:        998
cycles stats:
           TOTAL events:       1020
            MMAP events:         18
            COMM events:          2
            EXIT events:          2
          SAMPLE events:        998

which is close enough :)

> We need to elucidate what's going on in perf_event_task_tick().
> I have tried with my throttling fix and it did not help. We are
> not subject to throttling with such a low rate.

Ok. I would start by looking at the clock ticks if I were you, since this
seems to be alright on my board.

Will
