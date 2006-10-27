From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: Fixup omap-rtc (was: Git tree updated to
	2.6.19-rc2)
Date: Fri, 27 Oct 2006 15:45:05 +0300
Message-ID: <20061027124503.GA25245@atomide.com>
References: <20061023203925.GC11967@atomide.com>
	<20061024110502.GQ1123@earth.li>
	<200610241057.09630.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610241057.09630.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061024 21:54]:
> On Tuesday 24 October 2006 4:05 am, Jonathan McDowell wrote:
> 
> > Haven't hit any of these with the Amstrad Delta defconfig so far (just
> > done a compile and boot so far), but did need the patch below to get
> > omap-rtc to compile.
> > 
> > Signed-Off-By: Jonathan McDowell <noodles@earth.li>
> 
> Looks right.  In fact, that RTC should IMO be added to defconfig
> for all the OMAP platforms ...

OK, I've pushed Jonathan's patch and also removed other unnecessary
pt_regs.

Some boards use external RTC, but I agree we should add it in general.

Tony
