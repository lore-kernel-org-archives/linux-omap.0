From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/2] change lpj in arm smp common code
Date: Sun, 1 Apr 2012 09:20:58 +0800
Message-ID: <20120401012057.GC2603@b20223-02.ap.freescale.net>
References: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
	<87sjhtec0w.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87sjhtec0w.fsf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 29, 2012 at 10:21:19AM -0800, Kevin Hilman wrote:
> Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
> 
> > The two patches were originally in [PATCH V6 0/7] add a generic cpufreq driver.
> > I seperated them and hope they can go to upstream earlier.
> >
> > Richard Zhao (2):
> >   ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp
> >   cpufreq: OMAP: remove loops_per_jiffy recalculate for smp
> 
> The first one should go into Russell's patch system.  Once he queues
> that, I can queue the OMAP one for the CPUfreq maintainer.
Hi Russel & Kevin,

Could you double check whether you've picked the patch searies?
I can not find them in 3.4rc.

Thanks
Richard
> 
> Kevin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
