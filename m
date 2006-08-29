From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
Date: Tue, 29 Aug 2006 12:51:57 -0700
Message-ID: <200608291251.57807.david-b@pacbell.net>
References: <8C5B35906ACE4C48ACB3E1FAC65DB5B6231F5B@dlee08.ent.ti.com>
	<200608151517.16378.david-b@pacbell.net>
	<20060829143454.GI4204@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060829143454.GI4204@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 August 2006 7:34 am, Tony Lindgren wrote:
> 
> Sounds like it should be capable of waking up the system if 32KHz clock
> is on and the wake-up events are configured properly.

Yes.  I had more of a look at things, and have a patch (yet to be tested)
that should let many more things be wakeup event sources.  MPUIO irqs,
GPIOs not in the first bank, non-MPUI/GPIO irqs (like RTC), etc.


> Anyways, pushing today. Let's also plan on removing the old driver then.

Let's get the wakeup thing fixed, then I'll forward rtc-omap upstream if
nobody reports any significant problems.

Might as well leave the old version in the OMAP tree until the new one
gets pulled down.

- Dave
