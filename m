From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: RE: The clock problem in OMAP2 McSPI
Date: Fri, 17 Aug 2007 12:05:53 +0900
Message-ID: <003501c7e07b$8801d850$e1ac580a@swcenter.sec.samsung.co.kr>
References: <002801c7e061$2da499c0$e1ac580a@swcenter.sec.samsung.co.kr>
	<200708161921.10232.david-b@pacbell.net>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <200708161921.10232.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'David Brownell' <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> 
> On Thursday 16 August 2007, Kyungmin Park wrote:
> > After booting, it oops with following messages[2].
> >
> > So I reverted only clock parts as before. Then it's work well.
> > I think it has some clock problem.
> >
> > Do you have any idea?
> 
> Nope, sorry.  I looked at that driver code, and what I
> see is neatly paired clk_enable()/clk_disable() calls ...
> stuff that should be "obviously correct".  And which
> works fine here...

I agree. The code of clock is completely matched and only enables it needed
for McSPI

> 
> I don't see how that should be able to cause a disable()
> of something that's already got usecount 0.
> 
> I wouldn't *think* that the updates in the clock framework
> have caused problems.  But regardless, to debug this I'd
> start by tracing the refcounts of that functional clock.
> 
> The only slightly odd unusual thing in that driver should
> be that the two clocks would normally be disabled until
> there's some I/O to be done (either to the McSPI registers
> or to a SPI device).  Most drivers leave clocks enabled all
> the time, needlessly wasting power.

If it required the some delay time to work correctly?
Since the clock pointer is always correct and it has ick and fck.
Or other kernel features such as tickless, high-res affects the clock
framework?

Thank you,
Kyungmin Park
