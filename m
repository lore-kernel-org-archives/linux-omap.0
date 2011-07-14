From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v4 13/20] gpio/omap: cleanup omap_gpio_mod_init function
Date: Thu, 14 Jul 2011 11:27:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BFD2AE1@dbde02.ent.ti.com>
References: <1310565259-31267-1-git-send-email-tarun.kanti@ti.com>
	<1310565259-31267-14-git-send-email-tarun.kanti@ti.com>
	<20110714055608.GA22467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110714055608.GA22467@google.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan,
	Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Todd Poynor [mailto:toddpoynor@google.com]
> Sent: Thursday, July 14, 2011 11:26 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Hilman, Kevin; Shilimkar, Santosh;
> tony@atomide.com; linux-arm-kernel@lists.infradead.org; Varadarajan,
> Charulatha
> Subject: Re: [PATCH v4 13/20] gpio/omap: cleanup omap_gpio_mod_init
> function
> 
> On Wed, Jul 13, 2011 at 07:24:12PM +0530, Tarun Kanti DebBarma wrote:
> > With register offsets now defined for respective OMAP versions we can
> get rid
> > of cpu_class_* checks. This function now has common initialization code
> for
> > all OMAP versions. Initialization specific to OMAP16xx has been moved
> within
> > omap16xx_gpio_init().
> >
> ...
> > -	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
> > +	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> > +		pdev = omap16xx_gpio_dev[i];
> > +		pdata = pdev->dev.platform_data;
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +		base = ioremap(res->start, resource_size(res));
> 
> 
> Should check platform_get_resource and ioremap error returns.
Ok, thanks.
--
Tarun
> 
> > +
> > +		__raw_writel(0x0014, base + OMAP1610_GPIO_SYSCONFIG);
> 
> 
> Todd
