From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] Send OMAP clocksource and clockevent to rt mailing list
Date: Wed, 20 Dec 2006 10:34:15 +0100
Message-ID: <45890397.2080809@gmail.com>
References: <45883982.8080207@gmail.com>
	<1166576011.6906.77.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1166576011.6906.77.camel@vence.hilman.org>
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

Kevin Hilman wrote:
> Tony, I was going to submit the clocksoure/clockevent to RMK, but since
> we missed the merge window, can we just add the clocksource/clockevent
> patches to the patch queue that's already going to RMK?

Clocksource yes, I have it in my pending patches list. But 
clockevent still needs CONFIG_PREEMPT_RT patch? So this 
can't directly go to RMK?

I now sent our clocksource/clockevent patches to -rt mailing 
list [1]. If clocksource goes to RMK as well, we have two 
paths we can get it into mainline. Let us see which is the 
faster and better one. The biggest risk will be some merge 
conflicts if both are successful ;)

Dirk

[1] http://news.gmane.org/gmane.linux.rt.user
(works now)
