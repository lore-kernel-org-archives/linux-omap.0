From: Paul Walmsley <paul@pwsan.com>
Subject: Removing platform_get_resource_byname() (was Re: How to handle named
	resources with DT?)
Date: Fri, 26 Aug 2011 05:01:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108260342560.9743@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<201108251705.43168.arnd@arndb.de> <877h6173wm.fsf@ti.com>
	<32081673.hbCQs4qpyo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <32081673.hbCQs4qpyo@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Cousson,
	Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kumar Gala <galak@kernel.crashing.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: linux-omap@vger.kernel.org

On Thu, 25 Aug 2011, Arnd Bergmann wrote:

> It's not at all about whether the Linux codein drivers/of supports this
> or not, adding it would be trivial. The point is that it would be
> *wrong* to add it because there already exists a way to identify every
> resource in the device tree and we should not extend that interface
> to have multiple ways to do the same thing just for convenience of
> a few device drivers!

The point is that:

- there was a reason why platform_get_resource_byname() was added to the 
  Linux kernel, that at least some people find useful and relevant

- some folks are effectively proposing to remove
  platform_get_resource_byname() not because it's a bad interface, but 
  because it would result in changes to the way that DT files are 
  generated and used

Just as you consider the preservation of platform_get_resource_byname() to 
be wrong (because it conflicts with DT), some people consider the above 
rationale to be faulty, because it removes a useful way to abstract 
drivers from SoC data.

For example, consider that the ordering of device resources, such as IRQ 
lines or memory regions, in the hardware IP block is arbitrary.  Whomever 
generates a DT file for that hardware will need to hardcode the driver's 
assumptions for resource order into the DT generator.  And then hope that 
the binding assumptions made by that driver are coordinated between all of 
the other potential DT users out there: other OSes (proprietary or not), 
bootloaders, etc.

Contrast this with the situation when named resources are used.  The 
resources are named with a string that represents their use by the 
hardware IP block.  In this situation, the order in which they appear in 
the DT file is unimportant.  There need be no extra hacks added to the DT 
generation code or to the drivers to ensure that they find the correct 
resource.

Please don't misunderstand: I personally don't consider this specific 
problem to be a showstopper.  It makes sense to me to improve the DT 
format to use named resources.  But if the consensus is that the problem 
is just going to be knowingly pushed on to the poor folks who have to 
generate DT files, who will have to maintain a bunch of hacks to do so, 
then, so be it.  But the issue highlights a much larger problem: the 
apparent level of resistance to improving the DT data format in ways that 
may affect backwards compatibility.

There are several aspects of DT, and the way that it's used in the kernel, 
that could be improved -- like, for example, the fact that computer 
systems for the past several years are not well-represented by a tree of 
devices.  And if we don't have a strategy for versioning the content and 
the layout of the device data, as opposed to simply its binary format, 
then it's unwise to consider it for broader adoption until this exists, 
IMHO.

> One of the important advantages of using the IEEE device tree bindings 
> is that we can define device trees that are to a large degree compatible 
> with how AIX, Solaris, MacOS, FreeBSD and probably many more (lesser 
> known) operating systems probe their systems.

By that rationale, we should just use ACPI.  It's far more widely deployed 
than all of those other OSes combined.  (No, I don't think we should use 
ACPI.)

By the way, MacOS stopped using Device Tree several years ago.

> Changing the resource interface in Linux to have two 'name' fields
> would also be terribly confusing and is not a good interface

There are other ways of solving that particular problem, other than having 
two 'name' fields.

> it would just solve another problem (silly entries in /proc/iomem) that 
> we don't need to have in the first place when we do the obvious 
> conversion of the drivers to the IEEE standard way of doing this.

Just like MacOS, the IEEE gave up on Device Tree -- in fact, over a decade 
ago -- so it doesn't make sense to cite them as an authority any more.

My point is not to disrespect DT, which seems like a useful way of moving 
device data out of the kernel tree; but rather, to try to ensure that 
we're not locked into a rigid and outdated way of doing things: either 
technically, or by people's attitudes.


- Paul
