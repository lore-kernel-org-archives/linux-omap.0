From: stephane eranian <eranian@googlemail.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Fri, 27 Jan 2012 18:16:47 +0100
Message-ID: <CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
References: <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
	<20120127121311.GB2347@mudshark.cambridge.arm.com>
	<yw1x1uqlnw1o.fsf@unicorn.mansr.com>
	<20120127132826.GD2347@mudshark.cambridge.arm.com>
	<CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
	<CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
	<20120127155454.GH2347@mudshark.cambridge.arm.com>
	<CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
	<20120127165941.GK2347@mudshark.cambridge.arm.com>
	<CAMsRxf+iv06zOCMzhYONeLaf6RvOLp38T53mR--8ESHvCXMeFQ@mail.gmail.com>
	<20120127171009.GL2347@mudshark.cambridge.arm.com>
Reply-To: eranian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <20120127171009.GL2347@mudshark.cambridge.arm.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: Will Deacon <will.deacon@arm.com>
Cc: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, "Cousson,
	Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 27, 2012 at 6:10 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jan 27, 2012 at 05:03:28PM +0000, stephane eranian wrote:
>> On Fri, Jan 27, 2012 at 5:59 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > That said, if you see any bugs in the code please do shout!
>> >
>> I suspect there is something wrong, we shouldn't hit the max_rate_limit.
>> You may have bursts of interrupts (samples). I'll check on that this week-end.
>
> Ok, thanks. Keep in mind that you probably have variable rate clocks, which
> will affect the cycle counter frequency.
>
I assume it does not vary the clock if the workload is steady and just burning
cycles, e.g.: for(;;);

>> >> > A7 and A15 have the ability to filter counters based on privilege level, so
>> >> > you can get more accurate userspace counts there.
>> >>
>> >> Ok, that's better. Need to update libpfm4 for A15 with priv levels then!
>> >
>> > How do you handle that in libpfm4? On ARM, the event encodings remain the same,
>> > you just need to set some extra bits to determine which levels are included or
>> > excluded (you can do this with the perf tool by using the :{u,k,h} suffix on an
>> > event description).
>> >
>> It depends what you call the encoding? If the priv level can be encoded in the
>> attr->config field, then that's easy. If it needs to be set somewhere else, then
>> we need to figure out how you encode it in the attr struct. Either in some other
>> bits in attr->config or use attr->config1, for instance. You tell me.
>
> The way it's done with perf is to set the exclude{user,kernel,hv} fields in
> the attr. The ARM perf backend then translates these into the relevant bits
> which get orred into the config_base before hitting the hardware.
>
Well, that's also how we do it with libpfm4 on X86. This is because
with perf_events,
the exclude_* fields have priority over what you set in the attr->config field.

> Will

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
