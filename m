From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] [PATCH] ARM:  Add clocksource driver for OMAP1 and OMAP2
Date: Fri, 01 Dec 2006 19:21:13 +0100
Message-ID: <45707299.3080207@gmail.com>
References: <4550A70B.7020609@gmail.com>
	<200611301114.09352.david-b@pacbell.net>
	<456F4025.5010403@gmail.com>
	<200611301322.35918.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200611301322.35918.david-b@pacbell.net>
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

David Brownell wrote:
> On Thursday 30 November 2006 12:33 pm, Dirk Behme wrote:
 >
>>Mmh, maybe I'm wrong here or anything is long term 
>>misconfigured, but looks to me that I don't get a login 
>>prompt with this patch and rt applied. With [1] I get
> 
> That's what I meant when I said the 32k timer doesn't
> work for me -- that's _without_ the RT patch too.  The
> Linux-OMAP list archives don't have a way to get non-HTML
> versions of _single_ messages so I had to copy the [1] bits
> by hand.  Presumably something significant differed?  If so,
> what? 

> +++ h4/arch/arm/plat-omap/timer32k.c	2006-11-28 15:06:13.000000000 -0800

> +		clocksource_khz2mult(32768, clocksource_32k.shift);

Using clocksource_hz2mult instead (you see, hz vs. khz) does 
the trick here ;)

Will send an update.

Dirk
