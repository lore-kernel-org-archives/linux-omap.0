From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.17-rc4-omap-git] rtc-omap, rtc framework driver
Date: Tue, 29 Aug 2006 17:34:55 +0300
Message-ID: <20060829143454.GI4204@atomide.com>
References: <8C5B35906ACE4C48ACB3E1FAC65DB5B6231F5B@dlee08.ent.ti.com>
	<200608151517.16378.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200608151517.16378.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [060816 01:17]:
> On Tuesday 15 August 2006 3:03 pm, Johnson, Steve-OMAP wrote:
> > David,
> > 
> > Thanks.  I'll let marketing know and ask them to fix the graphic.
> 
> Good, so issue #2 is resolved ... this _is_ OMAP1-only, the Kconfig is right.
> 
> How about #1?  Likely it's too late to resolve that doc ambiguity, but it'd
> be good to know the answer anyway. :)

Sounds like it should be capable of waking up the system if 32KHz clock
is on and the wake-up events are configured properly.

Anyways, pushing today. Let's also plan on removing the old driver then.

Regards,

Tony
