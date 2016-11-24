From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: cpcap: Add minimal support
Date: Thu, 24 Nov 2016 08:59:26 +0000
Message-ID: <20161124085926.GV10134@dell.home>
References: <20161119012748.17224-1-tony@atomide.com>
 <20161121114558.GJ32509@dell>
 <20161123152652.GB4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161123152652.GB4082@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Mark Rutland <mark.rutland@arm.com>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 23 Nov 2016, Tony Lindgren wrote:

> * Lee Jones <lee.jones@linaro.org> [161121 03:43]:
> > On Fri, 18 Nov 2016, Tony Lindgren wrote:
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -97,6 +97,7 @@ obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
> > >  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
> > >  
> > >  obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
> > > +obj-$(CONFIG_MFD_CPCAP)		+= cpcap.o
> > 
> > Who is the manufacturer?
> 
> Hmm that I don't know. There seems to be both ST and TI versions
> of this chip manufactured for Motorola. So my guess is that it
> should be Motorola unless there's some similar catalog part
> available from ST used by others. If anybody has more info
> on this please let me know :)

If this IP is shared amongst vendors, it usually means it was designed
by someone else?  Synopsis perhaps?

> > > +	cpcap->vendor = (val >> 6) & 0x0007;
> > > +	cpcap->revision = ((val >> 3) & 0x0007) | ((val << 3) & 0x0038);
> > 
> > Lots of magic numbers here.  I suggest you define them.
> 
> I'll check if some earlier code has these defined. Otherwise I'll
> just add a comment on the lack of available documentation.

*sad face*

Does that mean you don't even know what they're for?

> > > +	error = cpcap_init_irq_bank(cpcap, 0, 0, 16);
> > 
> > 'ret' is more traditional.
> 
> FYI error seems to be preferred over ret as it's meaning is
> clear, git grep "error =" drivers/input for example.
> I can of course change it if you prefer ret over error.

I'd prefer to stick to the conventions of *this* subsystem.

... and the most common convention used kernel wide:

$ git grep "ret =" | wc -l
117976
$ git grep "err =" | wc -l
56708
$ git grep "error =" | wc -l
14427


> > > +	error = cpcap_init_irq_bank(cpcap, 2, 32, 64);
> > > +	if (error)
> > > +		return error;
> > 
> > I don't think I've seen this method of adding bulk IRQ chips before.
> > Isn't there a cleaner or generic way to do this?
> 
> I'll check.
> 
> ...
> > > +#define CPCAP_REG_LDEB		0x1270	/* LMR Debounce Settings */
> > > +#define CPCAP_REG_LGDET		0x1274	/* LMR GCAI Detach Detect */
> > > +#define CPCAP_REG_LMISC		0x1278	/* LMR Misc Bits */
> > > +#define CPCAP_REG_LMACE		0x127c	/* LMR Mace IC Support */
> > > +
> > > +#define CPCAP_REG_TEST		0x7c00	/* Test */
> > > +
> > > +#define CPCAP_REG_ST_TEST1	0x7d08	/* ST Test1 */
> > > +
> > > +#define CPCAP_REG_ST_TEST2	0x7d18	/* ST Test2 */
> > 
> > It would be nice to line up the entire file. #OCD
> 
> Hmm care to clarify what you mean here? I think it's lined up with

I'm missing context now you've <snip>ed.

These look straight, however is the whole file lined up (as much as
*practically* possible)?

> tabs to line up. I left empty lines where the registers are not
> contiguous. What does #OCD mean, Obsessive Compulsive Disorder over
> header files maybe? :)

Yes, that's what it means.

/me likes straight lines. :)

> Anywys thanks for the review, the rest of the comments I will just
> fix and repost.

Welcome.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
