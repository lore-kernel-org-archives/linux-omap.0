From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: cpcap: Add minimal support
Date: Thu, 24 Nov 2016 06:43:13 -0800
Message-ID: <20161124144313.GN4082@atomide.com>
References: <20161119012748.17224-1-tony@atomide.com>
 <20161121114558.GJ32509@dell>
 <20161123152652.GB4082@atomide.com>
 <20161124085926.GV10134@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161124085926.GV10134@dell.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Mark Rutland <mark.rutland@arm.com>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [161124 00:56]:
> On Wed, 23 Nov 2016, Tony Lindgren wrote:
> 
> > * Lee Jones <lee.jones@linaro.org> [161121 03:43]:
> > > On Fri, 18 Nov 2016, Tony Lindgren wrote:
> > > > --- a/drivers/mfd/Makefile
> > > > +++ b/drivers/mfd/Makefile
> > > > @@ -97,6 +97,7 @@ obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
> > > >  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
> > > >  
> > > >  obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
> > > > +obj-$(CONFIG_MFD_CPCAP)		+= cpcap.o
> > > 
> > > Who is the manufacturer?
> > 
> > Hmm that I don't know. There seems to be both ST and TI versions
> > of this chip manufactured for Motorola. So my guess is that it
> > should be Motorola unless there's some similar catalog part
> > available from ST used by others. If anybody has more info
> > on this please let me know :)
> 
> If this IP is shared amongst vendors, it usually means it was designed
> by someone else?  Synopsis perhaps?

After searching around, many specs say "ST Ericsson CPCAP". So let's
assume the manufacturer should be ste.

> > > > +	cpcap->vendor = (val >> 6) & 0x0007;
> > > > +	cpcap->revision = ((val >> 3) & 0x0007) | ((val << 3) & 0x0038);
> > > 
> > > Lots of magic numbers here.  I suggest you define them.
> > 
> > I'll check if some earlier code has these defined. Otherwise I'll
> > just add a comment on the lack of available documentation.
> 
> *sad face*
> 
> Does that mean you don't even know what they're for?

Luckily the Motorola driver folks documented all the registers.
Unfortunately the register bits just have names. I need to
check if we have names for these bits.

> > > > +	error = cpcap_init_irq_bank(cpcap, 0, 0, 16);
> > > 
> > > 'ret' is more traditional.
> > 
> > FYI error seems to be preferred over ret as it's meaning is
> > clear, git grep "error =" drivers/input for example.
> > I can of course change it if you prefer ret over error.
> 
> I'd prefer to stick to the conventions of *this* subsystem.
> 
> ... and the most common convention used kernel wide:
> 
> $ git grep "ret =" | wc -l
> 117976
> $ git grep "err =" | wc -l
> 56708
> $ git grep "error =" | wc -l
> 14427

OK sure will rename.

> > > > +#define CPCAP_REG_LDEB		0x1270	/* LMR Debounce Settings */
> > > > +#define CPCAP_REG_LGDET		0x1274	/* LMR GCAI Detach Detect */
> > > > +#define CPCAP_REG_LMISC		0x1278	/* LMR Misc Bits */
> > > > +#define CPCAP_REG_LMACE		0x127c	/* LMR Mace IC Support */
> > > > +
> > > > +#define CPCAP_REG_TEST		0x7c00	/* Test */
> > > > +
> > > > +#define CPCAP_REG_ST_TEST1	0x7d08	/* ST Test1 */
> > > > +
> > > > +#define CPCAP_REG_ST_TEST2	0x7d18	/* ST Test2 */
> > > 
> > > It would be nice to line up the entire file. #OCD
> > 
> > Hmm care to clarify what you mean here? I think it's lined up with
> 
> I'm missing context now you've <snip>ed.
> 
> These look straight, however is the whole file lined up (as much as
> *practically* possible)?

Yeah it should be, I'll check.

> > tabs to line up. I left empty lines where the registers are not
> > contiguous. What does #OCD mean, Obsessive Compulsive Disorder over
> > header files maybe? :)
> 
> Yes, that's what it means.
> 
> /me likes straight lines. :)

Sure nothing wrong with that ;)

Regards,

Tony
