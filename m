From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [RFC] Send OMAP clocksource and clockevent to rt mailing list
Date: Wed, 20 Dec 2006 16:02:14 -0800
Message-ID: <1166659334.6906.123.camel@vence.hilman.org>
References: <45883982.8080207@gmail.com>
	<1166576011.6906.77.camel@vence.hilman.org>
	<45890397.2080809@gmail.com>
	<20061220184439.GF22783@atomide.com>  <4589ACB5.1000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4589ACB5.1000401@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 2006-12-20 at 22:35 +0100, Dirk Behme wrote:
> tony@atomide.com wrote:
> > * Dirk Behme <dirk.behme@googlemail.com> [061220 01:41]:
> >>I now sent our clocksource/clockevent patches to -rt mailing 
> >>list [1]. If clocksource goes to RMK as well, we have two 
> >>paths we can get it into mainline. Let us see which is the 
> >>faster and better one. The biggest risk will be some merge 
> >>conflicts if both are successful ;)
> > 
> > No problem with merge conclicts on the RMK queue, I can easily
> > refresh that patch series accordingly. So let's send what is
> > needed to be included in the RT series.
> 
> I think at least our latest clocksource [1] patch should go 
> to RMK.
> 
> Kevin: What's about clockevent and RMK?

Sorry for the confusion.  Only clocksource patches are going to RMK for
now since the clockevents are dependent on tglx's -hrt-dyntick patch
(part of -rt)

Kevin
