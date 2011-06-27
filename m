From: "Grosen, Mark" <mgrosen-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC 5/8] remoteproc: add davinci implementation
Date: Mon, 27 Jun 2011 18:20:25 +0000
Message-ID: <FFF198FBBF957F4393BA834040FEFFA202EC68@DFLE35.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-6-git-send-email-ohad@wizery.com>
	<4E035B78.3080200@mvista.com>
	<FFF198FBBF957F4393BA834040FEFFA202D66E@DFLE35.ent.ti.com>
	<4E04A9AE.3030801@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4E04A9AE.3030801-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> From: Sergei Shtylyov
> Sent: Friday, June 24, 2011 8:14 AM
> 
> Grosen, Mark wrote:
> 
> >>     It should work on DA830 as well,
> 
>     So please make it dependent on ARCH_DAVINCI_DA8XX.
> 
> >> but not on real DaVinci, so the name is misleading...
> 
> > Yes, we debated calling it da8xx, but felt that with minor changes it could
> > accomodate the other SoCs in the davinci family.
> 
>     I don't think it's a good idea. Using cpu_is_*() is drivers is bad. Using
> #ifdef's is not an option either.
> 
> > However, it may be better
> > to start with just the da8xx/omapl13x parts and then rename if we add the
> > others.

Sergei, I'll respond more to this in a response to Sekhar's ideas. We may be
able to make this work generically for davinci w/o idef's.

> Looking into my old PSC manual (can't get the recent documentation from TI's
> site right now), the bit is called LRSTz.
>     It's worth moving this #define into <mach/psc.h> as well.

Ok, I agree we should try to match the HW names as much as possible

> >>> +/* register for DSP boot address in SYSCFG0 module (section 11.5.6) */
> >>> +#define HOST1CFG	0x44
> 
> >>     Worth declaring in <mach/da8xx.h> instead...
> 
> > Possibly - since it is only used for the DSP, I thought it would be better
> > to keep local to this implementation. I'll adopt whichever approach is the
> > convention.
> 
>     Well, the general approach is to keep the #define's where they are
> used, so maybe we should keep this #define here.

Will review as part of the general cleanup.

> 
> >>> +static inline int davinci_rproc_start(struct rproc *rproc, u64
> >> bootaddr)
> >>> +{
> >>> +	struct device *dev = rproc->dev;
> >>> +	struct davinci_rproc_pdata *pdata = dev->platform_data;
> >>> +	struct davinci_soc_info *soc_info = &davinci_soc_info;
> >>> +	void __iomem *psc_base;
> >>> +	struct clk *dsp_clk;
> >>> +
> >>> +	/* hw requires the start (boot) address be on 1KB boundary */
> >>> +	if (bootaddr & 0x3ff) {
> >>> +		dev_err(dev, "invalid boot address: must be aligned to
> >> 1KB\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	dsp_clk = clk_get(dev, pdata->clk_name);
> 
> >>     We could match using clkdev functionality, but the clock entry
> >> would need to be changed then...
> 
> > I followed the existing pattern I saw in other drivers.
> 
> Probably MUSB? We're trying to move away from passing the clock name to thge
> drivers, using match by device instead.
> 
> > If there is a new, better way, please point me to an example.
> 
>     Look at the da850_clks[] in mach-davinci/da850.c: if the device name is
> specified as a first argument to CLK() macro (instead of clock name the second
> argument), the matching is done by device, so you don't need to specify the
> clock name to clk_get(), passing NULL instead.

Thanks, I'll look at this and ask for Sekhar and Kevin's preferences.

Mark
