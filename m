From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v3 3/5] clk: introduce the common clock framework
Date: Thu, 1 Dec 2011 18:32:11 +0000
Message-ID: <20111201183211.GC18120@opensource.wolfsonmicro.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	<1321926047-14211-4-git-send-email-mturquette@linaro.org>
	<alpine.DEB.2.00.1111291619110.6289@utopia.booyaka.com>
	<CAJOA=zM4vcyTt_RBEVm6JxmzW-Dna0gpuWda7ytq_mqFSuXw9g@mail.gmail.com>
	<alpine.DEB.2.00.1111302308280.6289@utopia.booyaka.com>
	<20111201144205.GA2103@sirena.org.uk>
	<alpine.DEB.2.00.1112011124221.6289@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112011124221.6289-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 01, 2011 at 11:30:16AM -0700, Paul Walmsley wrote:

> So for example, if you had a driver that did:

> c = clk_get(dev, clk_name);
> clk_enable(c);
> clk_set_rate(c, clk_rate);

> and c was currently not enabled by any other driver on the system, and 
> nothing else had called clk_block_rate_change(c), then the rate change 
> would be allowed to proceed.  (modulo any notifier activity, etc.)  

> So clk_{allow,block}_rate_change() was simply intended to allow or 
> restrict other users of the same clock, not the current user.

Ah, sorry!  I'd totally misunderstood what you were proposing.
