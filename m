From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Send OMAP clocksource and clockevent to rt mailing list
Date: Thu, 21 Dec 2006 11:51:52 -0800
Message-ID: <20061221195152.GC10399@atomide.com>
References: <45883982.8080207@gmail.com>
	<1166576011.6906.77.camel@vence.hilman.org>
	<45890397.2080809@gmail.com> <20061220184439.GF22783@atomide.com>
	<4589ACB5.1000401@gmail.com>
	<1166659334.6906.123.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1166659334.6906.123.camel@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [061220 16:02]:
> On Wed, 2006-12-20 at 22:35 +0100, Dirk Behme wrote:
> > tony@atomide.com wrote:
> > > * Dirk Behme <dirk.behme@googlemail.com> [061220 01:41]:
> > >>I now sent our clocksource/clockevent patches to -rt mailing 
> > >>list [1]. If clocksource goes to RMK as well, we have two 
> > >>paths we can get it into mainline. Let us see which is the 
> > >>faster and better one. The biggest risk will be some merge 
> > >>conflicts if both are successful ;)
> > > 
> > > No problem with merge conclicts on the RMK queue, I can easily
> > > refresh that patch series accordingly. So let's send what is
> > > needed to be included in the RT series.
> > 
> > I think at least our latest clocksource [1] patch should go 
> > to RMK.
> > 
> > Kevin: What's about clockevent and RMK?
> 
> Sorry for the confusion.  Only clocksource patches are going to RMK for
> now since the clockevents are dependent on tglx's -hrt-dyntick patch
> (part of -rt)

Sounds good to me.

Tony
