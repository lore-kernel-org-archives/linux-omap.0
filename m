From: Will Deacon <will.deacon@arm.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Mon, 30 Jan 2012 17:24:38 +0000
Message-ID: <20120130172438.GC17814@mudshark.cambridge.arm.com>
References: <20120127171009.GL2347@mudshark.cambridge.arm.com>
	<CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
	<CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
	<CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
	<CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
	<CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
	<CACVXFVMDXO3DDj0mGh=+uDYfCoS_Ck1STVK0=UXjiAbtJTa=hA@mail.gmail.com>
	<CAMsRxfLqvPN_k7vuC3qzBjwX2ihBdPxZvmSCPZ3frWgptWXQGA@mail.gmail.com>
	<yw1xsjixgolb.fsf@unicorn.mansr.com>
	<CAMsRxfJLsnBnKBrEXOSOWUTbgfeZtVZ6nR8jt388=baL5Mn22Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <CAMsRxfJLsnBnKBrEXOSOWUTbgfeZtVZ6nR8jt388=baL5Mn22Q@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: "eranian@gmail.com" <eranian@gmail.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "Cousson,
	Benoit" <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 30, 2012 at 05:15:53PM +0000, stephane eranian wrote:
> Still need to investigate why the frequency mode does
> not yield the correct number of samples even with low frequency.
> 
> 
> $ taskset -c 1 perf record -e cycles -F 100 noploop 10
> $ perf report -D | tail -20
> Aggregated stats:
>            TOTAL events:        475
>             MMAP events:         11
>             COMM events:          2
>             EXIT events:          2
>           SAMPLE events:        460
> cycles stats:
>            TOTAL events:        475
>             MMAP events:         11
>             COMM events:          2
>             EXIT events:          2
>           SAMPLE events:        460
> 
> 460 samples is way too low. Should be 100x10 = 1000 samples or close to it.

Can you stick noploop.c somewhere (I'm lazy :) and I'll try it on one of my
A9 boards?

Thanks,

Will

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
