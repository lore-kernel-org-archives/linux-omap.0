From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] printk: add option to print cpu id
Date: Fri, 3 Aug 2012 15:36:23 -0700
Message-ID: <20120803223623.GB6156@kroah.com>
References: <1344013004-32211-1-git-send-email-vikram.pandita@ti.com>
 <m2628z6euk.fsf@firstfloor.org>
 <CAFm5wm3ScpUU5wa=ei3TY0zjU4kVbOgJMmE5_QDpwy7B-TJa+A@mail.gmail.com>
 <20120803200822.GC731@harshnoise.musicnaut.iki.fi>
 <CAFm5wm2sf9LnZNj9_BDYTF9G7XH32fOL3x5n=kZ-1ih0Cek2DQ@mail.gmail.com>
 <20120803215954.GA4489@kroah.com>
 <CAFm5wm1_-JP0xjDdBvAcqqpZPQvxJPsmNtUOFQyaNw=6H_JJcg@mail.gmail.com>
 <20120803221327.GA5102@kroah.com>
 <CAFm5wm3ayofPD7oF1=z_jwE_wuqBxBHicAs=KOhjcUr7Jo0wDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFm5wm3ayofPD7oF1=z_jwE_wuqBxBHicAs=KOhjcUr7Jo0wDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andi Kleen <andi@firstfloor.org>, kay@vrfy.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Vimarsh Zutshi <vimarsh.zutshi@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 03, 2012 at 03:25:17PM -0700, Pandita, Vikram wrote:
> >> This was something that got used internally and helped at times.
> >
> > Could you have used the trace point instead?
> 
> As i understood the trace_prink(), one would need to modify existing
> printk -> trace_printk. Is my understanding correct?

No, you should just be able to watch the tracepoint, right?

> Most of the times the problem exhibits as a random hang, without having a clue
> which code to modify. That time one generic defconfig global switch is
> your first tool.
> 
> Other issue i found, using this patch, that on multi-core ARM systems,
> almost 99% of times, IRQ's are handled by CPU0,
> even if CPU0 was really busy and other CPU's were free. I am yet to
> understand a good reason why.

Can't you see that from /proc/interrupts today?

> this patch also helped in other areas as mentioned in the thread
> http://marc.info/?l=linux-omap&m=134401269106619&w=2

I still don't understand how adding the cpu number to printk enabled you
to find any problem like this.  Can't you just add the cpu number to the
printk messages you care about for your specific hardware?

greg k-h
