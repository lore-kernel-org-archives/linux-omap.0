From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] printk: add option to print cpu id
Date: Sat, 4 Aug 2012 09:51:42 +0100
Message-ID: <20120804085142.GP7405@n2100.arm.linux.org.uk>
References: <1344013004-32211-1-git-send-email-vikram.pandita@ti.com> <m2628z6euk.fsf@firstfloor.org> <CAFm5wm3ScpUU5wa=ei3TY0zjU4kVbOgJMmE5_QDpwy7B-TJa+A@mail.gmail.com> <20120803200822.GC731@harshnoise.musicnaut.iki.fi> <CAFm5wm2sf9LnZNj9_BDYTF9G7XH32fOL3x5n=kZ-1ih0Cek2DQ@mail.gmail.com> <20120803215954.GA4489@kroah.com> <CAFm5wm1_-JP0xjDdBvAcqqpZPQvxJPsmNtUOFQyaNw=6H_JJcg@mail.gmail.com> <20120803221327.GA5102@kroah.com> <CAFm5wm3ayofPD7oF1=z_jwE_wuqBxBHicAs=KOhjcUr7Jo0wDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFm5wm3ayofPD7oF1=z_jwE_wuqBxBHicAs=KOhjcUr7Jo0wDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Mike Turquette <mturquette@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Vimarsh Zutshi <vimarsh.zutshi@gmail.com>, kay@vrfy.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 03, 2012 at 03:25:17PM -0700, Pandita, Vikram wrote:
> Other issue i found, using this patch, that on multi-core ARM systems,
> almost 99% of times, IRQ's are handled by CPU0,
> even if CPU0 was really busy and other CPU's were free. I am yet to
> understand a good reason why.

That is because you're probably not running irqbalanced on your platforms.

Firstly, the hardware does no IRQ balancing itself - you have to manually
route IRQs to CPUs in the hardware, and if you ask for an IRQ to be
delivered to several CPUs, all CPUs will get it each time it fires (unlike
x86 IOAPIC which picks a CPU to route the IRQ to.)

The ARM kernel does no IRQ balancing itself across CPUs, because when I
tried to implement it, every algorithm I tried gave completely sub-optimal
results, and irqbalanced existed to do the job in userspace.  So as there
is a userspace solution which works, there was no point to doing this in
the kernel.

Please use the irqbalance daemon to spread IRQs across your CPUs.
