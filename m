From: Tony Lindgren <tony@atomide.com>
Subject: Re: clk_get kernel dump
Date: Mon, 20 Feb 2006 16:05:38 -0800
Message-ID: <20060221000538.GJ30248@atomide.com>
References: <20060214175603.GE7135@atomide.com>
	<20060215143716.48574.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060215143716.48574.qmail@web32901.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060215 06:37]:
> --- Tony Lindgren <tony@atomide.com> wrote:
> 
> > 
> > Might be the common DSP code trying to set NULL clocks on omap2. I've
> > patched the clock framework to check that:
> > 
> >
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=8fc55a5be4a212efc51a335ddcd5ba066f46de6c
> > 
> > So updating to current git tree should help.
> 
> My tree is having this patch and clock fwk is latest as per the git
> tree. But the dump seems to coming from debug_mutex_waiter_free(...)
> function. 

In case you still have this problem, my h4 boots just fine here, BTW.

Tony
