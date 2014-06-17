From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
Date: Tue, 17 Jun 2014 16:32:11 +0300
Message-ID: <C3DA6AFC-2784-4A41-BC72-EF25B2B03B41@antoniou-consulting.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QPmCk9GzHPHqCKG4vHDvUGirgGaizH-V9bsHT4V=8=gCaA@mail.gmail.com>
 <20140617090931.GB3705@n2100.arm.linux.org.uk> <20140617125831.GI4173@beef>
 <20140617131522.GD3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140617131522.GD3705@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, beagleboard@googlegroups.com, Matt Porter <mporter@linaro.org>, Jason Kridner <jkridner@gmail.com>, OMAP List <linux-omap@vger.kernel.org>, Robert Nelson <robertcnelson@gmail.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Russell,

CCing gcl.

On Jun 17, 2014, at 4:15 PM, Russell King - ARM Linux wrote:

> On Tue, Jun 17, 2014 at 08:58:31AM -0400, Matt Porter wrote:
>> On Tue, Jun 17, 2014 at 10:09:31AM +0100, Russell King wrote:
>>> Why should kernel developers go to the extent of adding support for DT
>>> modification at runtime when the platform you want this for doesn't even
>>> support hotplugging of these capes?
>> 
>> It's important to note that Jason's use case is not the real one driving
>> runtime DT modification. You'll have to go back to threads like
>> https://lkml.org/lkml/2013/2/22/255 over a year ago where this was all
>> hashed out. The clearest use cases are the FPGA folks that are loading
>> their bitstream from userspace and due to DT-everywhere also need to
>> initiate runtime modification of the live DT tree from userspace.
>> There's a lot of discussion over many threads where this has been
>> debated.
> 
> Okay, so it was debated, and the outcome of that debate has been... no
> change.  That's probably because it is an incredible amount of work to
> achieve it, and none of the overloaded DT maintainers (who don't have
> enough time to review new bindings) have any intention of putting their
> precious resources towards it.
> 

Wait, wait wait. Who said there's no progress there. We're already proceeding
in that direction.

Apparently you are not aware that runtime modification of DT is part of the
DT capabilities since a few years back, as normally used on pSeries class
of machines.

The overlays are a method of having a sane, easy to use method for reconfigurable
hardware.

> From my rudimentary understanding of the OF code, it seems to mean that
> the way devices are created from the parsed OF tree structures (the
> device_node structures) needs to change such that when an OF tree node
> is removed, its corresponding device is also removed.  This probably
> needs a struct device pointer in the device_node struct.
> 
> Then there needs to be support to modify the parsed OF tree (not only
> to add nodes but also to remove nodes) and do the right thing when a
> node is added and/or removed.
> 

Already done.

> However, there's harder cases to solve.  There's several instances where
> device nodes do not correspond with a struct device, and these nodes are
> parsed by the driver.  Such things as the of_graph stuff, which describes
> the inter-connectivity of a display subsystem or v4l2 subsystem.  The
> nodes may be specified, but the target device for one of the links may
> be disabled at original probe time, but later becomes enabled via
> modification - this is one of the difficult cases since it needs the
> driver to cooperate with the change, and there's no existing way to
> notify it of that change.
> 

Actually there is, and we're working on making a generic method of handling
all these cases.

Hint, take a look at of_reconfig_notifier_register please.

> As with any kernel change, it needs people to write code.  If no one writes
> code, no change happens.  Endlessly discussing it on mailing lists does not
> result in code being written.
> 

The code is already written. If you have any specific objections to the patchset
I've already posted, comments are welcome.

> However, going back to the original stated platform - none of this
> complexity is required there.  Once power is applied, the platform
> hardware configuration is fixed (unless you want to yank a board off
> and risk destroying the hardware in doing so.)  So, if Jason's interest
> is in the capes, then the simplest and easiest approach is to have the
> boot loader deal with it.  If it's about FPGAs and dynamically loading
> bitstreams into them, then maybe a dynamic device tree is the answer -
> but /someone/ then has to create patches to achieve that.  If no one is
> willing to create those patches, then forget the idea of a dynamic
> device tree, because it won't happen on its own.
> 

The complexity is absolutely required, and it has nothing to do with beaglebone
capes.

The fact of the matter is that reconfigurable hardware is here, on shipping system, 
and we, as the linux kernel community have to make sure it works, and that it works in
a sane way.


> -- 
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.

Regards

-- Pantelis
