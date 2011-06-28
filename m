From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC 5/8] remoteproc: add davinci implementation
Date: Tue, 28 Jun 2011 15:06:22 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D7938F3@dbde02.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-6-git-send-email-ohad@wizery.com>
	<4E035B78.3080200@mvista.com>
	<FFF198FBBF957F4393BA834040FEFFA202D66E@DFLE35.ent.ti.com>
	<4E04A9AE.3030801@mvista.com>
	<FFF198FBBF957F4393BA834040FEFFA202EC68@DFLE35.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <FFF198FBBF957F4393BA834040FEFFA202EC68-Jq/I0xf/SMGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Grosen, Mark" <mgrosen-l0cyMroinI0@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, davinci-linux-open-source <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Brian Swetland <swetland-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Mon, Jun 27, 2011 at 23:50:25, Grosen, Mark wrote:
 
> > >>> +static inline int davinci_rproc_start(struct rproc *rproc, u64
> > >> bootaddr)
> > >>> +{
> > >>> +	struct device *dev = rproc->dev;
> > >>> +	struct davinci_rproc_pdata *pdata = dev->platform_data;
> > >>> +	struct davinci_soc_info *soc_info = &davinci_soc_info;
> > >>> +	void __iomem *psc_base;
> > >>> +	struct clk *dsp_clk;
> > >>> +
> > >>> +	/* hw requires the start (boot) address be on 1KB boundary */
> > >>> +	if (bootaddr & 0x3ff) {
> > >>> +		dev_err(dev, "invalid boot address: must be aligned to
> > >> 1KB\n");
> > >>> +		return -EINVAL;
> > >>> +	}
> > >>> +
> > >>> +	dsp_clk = clk_get(dev, pdata->clk_name);
> > 
> > >>     We could match using clkdev functionality, but the clock entry
> > >> would need to be changed then...
> > 
> > > I followed the existing pattern I saw in other drivers.
> > 
> > Probably MUSB? We're trying to move away from passing the clock name to thge
> > drivers, using match by device instead.
> > 
> > > If there is a new, better way, please point me to an example.
> > 
> >     Look at the da850_clks[] in mach-davinci/da850.c: if the device name is
> > specified as a first argument to CLK() macro (instead of clock name the second
> > argument), the matching is done by device, so you don't need to specify the
> > clock name to clk_get(), passing NULL instead.
> 
> Thanks, I'll look at this and ask for Sekhar and Kevin's preferences.

The second argument is not a (SoC specific)
clock name, it is the "connection id" which
is specific to the IP (not to the SoC).

For example, the EMAC IP may want to deal
with interface clock, functional clock and
mii clock. So, it passes a connection identifier
to tell the clock framework which particular
clock it is interested in. The names of these
connection identifiers will not change with SoC
as they are IP property. So, it will not be
right to get this through platform data.

If there is no connection identifier in
your case, you can just pass the second
argument as NULL. The clock matching will
happen using device name (which should
remain same across SoCs too).

Of course, this means that any incorrectly defined
clock lookup structures for dsp clock in platform
code needs to be corrected.

Thanks,
Sekhar
