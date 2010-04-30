From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/14] omap: Make uncompress code and DEBUG_LL code generic
Date: Fri, 30 Apr 2010 11:47:12 -0700
Message-ID: <20100430184712.GF29604@atomide.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
	<20100126201239.15382.34792.stgit@baageli.muru.com>
	<1272640022.3051.1534.camel@localhost> <4BDB0353.5090800@ti.com>
	<20100430171802.GB1639@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100430171802.GB1639@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, DaVinci list <Davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cyril Chemparathy <cyril@ti.com>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100430 10:13]:
> On Fri, Apr 30, 2010 at 12:20:35PM -0400, Cyril Chemparathy wrote:
> > Hi,
> > 
> > [...]
> > > To fix both problems, maybe we should just use a fixed memory location
> > > to pass this temporary data from uncompress to the kernel.  We've had a
> > > similar problem on DaVinci recently and a proposal has been made (and
> > > tested) to use memory just below the page tables[3].)
> > 
> > Essentially both of these approaches (internal scratch register and
> > fixed address) implement a weird back-channel communication scheme
> > between the decompresser and the debug macros.
> > 
> > A more elegant solution may be as follows:
> >     - pass machine_arch_type as an argument into addruart.
> 
> Unfortunately, that breaks addruart.  Firstly, addruart is used from
> assembly code where very limited registers are available (the fewer
> registers it clobbers the less likely debug is going to cause stuff
> to break.)

Right, this would be tricky.
 
> Secondly, the places that addruart may be called from, the location
> of the machine type number is indeterminent.  Remember that this
> macro can be called when the MMU is on or off, and can be called
> before the machine_arch_type has been initialized.

Another good point here.
 
> >     - move the uart base lookup logic to addruart using macros similar
> >       to DEBUG_LL_*, except that these expand to assembly code this
> >       time.
> >     - reuse these debug-macros in uncompress.h and implement putc() and
> >       flush() using addruart(), senduart(), etc.
> 
> Given what I've said above about the debug macros, this is definitely the
> wrong solution.
> 
> Having the decompressor macros work whatever the machine type is
> reasonable, and the machine_is_xxx() macros already work at that point,
> so there shouldn't be much of an issue there.

Just to bring it up, there's one issue to consider here though.
When the bootloader passes a wrong machine id, chances are things
break with no debug output.
 
> As far as the debug macros go, I think we're at the point where it's
> basically just far easier to leave these macros as a developer debugging
> tool and we'll just have to put up with it being something that an OMAP
> developer has to edit according to his platform to make work.
> 
> After all, _NO_ production kernel what so ever should be using this
> debug support.

Things work now for mach-omap2, but we assume the first uart is always 
in the same location. If this changes, then using some fixed memory
location for storing the debug configuration is probably the best way
to go considering the issues Russell mentioned.

Regards,

Tony
