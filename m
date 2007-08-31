From: Tony Lindgren <tony@atomide.com>
Subject: Re: wake up from a serial port
Date: Fri, 31 Aug 2007 10:40:45 -0700
Message-ID: <20070831174045.GK12350@atomide.com>
References: <20070827111405.GD13538@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901B8CFED@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901B8CFED@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070827 05:21]:
> > 
> > BTW, I never got the 2420 serial wake events to work, maybe they
> > need separate interrupt handlers registered. But the GPIO trick
> > should still work even if the serial wake-up events won't work.
> 
> These in 2420 can't wake core from RETETION.  They can wake the core
> from  clockstop.

OK, thanks that explains. So multiplexing the rx lines for GPIO
temporarily is the way to go then.

> I'll throw rough numbers out for (chip) each domain has its own
> combination.  Each lower state requires the previous state to be hit all
> at 1.05v. clcokstop=~1.2mA, ~retention=150uA, off=~50uA.  Clock stop can
> be higher depending on the 'partial' activity necessary, and perhaps
> also lower.

OK

Tony
