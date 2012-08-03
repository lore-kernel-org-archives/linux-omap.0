From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] printk: add option to print cpu id
Date: Fri, 3 Aug 2012 15:13:27 -0700
Message-ID: <20120803221327.GA5102@kroah.com>
References: <1344013004-32211-1-git-send-email-vikram.pandita@ti.com>
 <m2628z6euk.fsf@firstfloor.org>
 <CAFm5wm3ScpUU5wa=ei3TY0zjU4kVbOgJMmE5_QDpwy7B-TJa+A@mail.gmail.com>
 <20120803200822.GC731@harshnoise.musicnaut.iki.fi>
 <CAFm5wm2sf9LnZNj9_BDYTF9G7XH32fOL3x5n=kZ-1ih0Cek2DQ@mail.gmail.com>
 <20120803215954.GA4489@kroah.com>
 <CAFm5wm1_-JP0xjDdBvAcqqpZPQvxJPsmNtUOFQyaNw=6H_JJcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFm5wm1_-JP0xjDdBvAcqqpZPQvxJPsmNtUOFQyaNw=6H_JJcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andi Kleen <andi@firstfloor.org>, kay@vrfy.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Vimarsh Zutshi <vimarsh.zutshi@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 03, 2012 at 03:07:39PM -0700, Pandita, Vikram wrote:
> On Fri, Aug 3, 2012 at 2:59 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Aug 03, 2012 at 02:24:20PM -0700, Pandita, Vikram wrote:
> >> Aaro
> >>
> >> On Fri, Aug 3, 2012 at 1:08 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> >> > Hi,
> >> >
> >> > On Fri, Aug 03, 2012 at 11:25:37AM -0700, Pandita, Vikram wrote:
> >> >> > And really: Wasting 1/3 of the 80 character line is too much.
> >> >>
> >> >> You _WASTE_ 4 chars only if you are interested in this info by
> >> >> enabling: CONFIG_PRINTK_CPUID
> >> >
> >> > I guess you waste 4 + 3 chars? You could optimize the length by checking
> >> > CONFIG_NR_CPUS?
> >>
> >> Good point.
> >> Looks there is a variable 'nr_cpu_ids' that could be used as well.
> >>
> >> If there is general consensus that the patch can help the arm
> >> community, and others in general,
> >> this optimization should be easy to implement - saving few chars space
> >> in each line of console output.
> >>
> >> For now i will stick to this v3 version of path, unless you think otherwise.
> >
> > I don't think is is something that anyone needs, and if you do, as
> > pointed out, you can use the trace function to make it happen.
> >
> 
> This was something that got used internally and helped at times.

Could you have used the trace point instead?

greg k-h
