From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] Convert drivers to new irq trigger modes
Date: Thu, 9 Feb 2006 08:25:36 +0200
Message-ID: <20060209062536.GC11799@two.research.nokia.com>
References: <43E8D9CA.8000204@gmail.com>
	<20060208051451.GA22845@two.research.nokia.com>
	<43EA4234.4070807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43EA4234.4070807@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 08, 2006 at 08:10:44PM +0100, Dirk Behme wrote:

> >> 	int			irq;
> >>+	int			irq_type;
> >
> >This doesn't seem to be used anywhere.
> 
> To which file do you refer here? isp1301_omap.c, tps65010.c 
> or omap_ts.h? I use irq_type in all of them.

Sorry, that part of the patch was obviously correct.  I don't know what I
was smoking at the time. =)

> >You should be ORring here.  Otherwise you lose the SA_SAMPLE_RANDOM flag.
> 
> It is intended to lose SA_SAMPLE_RANDOM here. 
> SA_SAMPLE_RANDOM is the default and shall be used by 
> request_irq() on boards which don't need special trigger 
> setting. But on boards which need special trigger level 
> setting this shall be overridden by the correct setting.

SA_SAMPLE_RANDOM doesn't have anything to do with triggering.  It's used to
indicate whether an IRQ source can be used to feed the kernel entropy pools. 
If the IRQ in question cannot be considered to happen at random intervals,
the flag must not be set.

Cheers,
Juha
