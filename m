From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
Date: Thu, 10 Oct 2013 11:17:42 +0300
Message-ID: <525662A6.4080504@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com> <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com> <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com> <20131007190322.GY8949@atomide.com> <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44959 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab3JJISS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Oct 2013 04:18:18 -0400
In-Reply-To: <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, mturquette@linaro.org
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@linaro.org, pdeschrijver@nvidia.com, rnayak@ti.com, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, swarren@nvidia.com, mark.rutland@arm.com

Hey Paul,

My dibs on this below.

On 10/09/2013 09:55 PM, Paul Walmsley wrote:
> On Mon, 7 Oct 2013, Tony Lindgren wrote:
>
>> And assuming Paul is OK with these patches in general.
>
> Actually, I have several concerns with this series, as you and I
> discussed.  Some of us have been talking them over with other folks for
> the past few months to try to figure out what to do.  Most of the concerns
> have fairly easy technical solutions, but we shouldn't merge these patches
> until they're resolved.
>
> The issues are:
>
> 1. whether the clock data should go into DT
> 2. what the right place for DT clock data is in the DT
> 3. whether it makes sense to merge "experimental" DT bindings in this case
> 4. where clockdomain data belongs
>
> The first issue - and the one I'm least concerned about - is that, in my
> view, it still does not make technical sense to move this data into DT.
> This is chip-level hardware data that never needs to be changed by board
> designers or end users.  Adding it to DT is going to result in a boot-time
> cost (due to DT parse overhead) and additional memory consumption for very
> little benefit, compared to an implementation that places this data into a
> dynamically loadable module.  For some users, the boot-time bloat is a big
> deal: the example that's been mentioned to me recently is an automotive
> back-up camera that needs to cold-boot to complete functionality in a few
> hundred microseconds.

Personally I share the concern, I don't see much point in using the DT 
for any kind of purpose... it is just another binary compatibility 
breaker in the picture in addition to boot-loader, and it basically does 
not solve any _real_ problems either.

Boot time issues can be solved by adding alternative clock data sources 
like Tony pointed out, granted, we don't have support for those yet, but 
we need to start somewhere.

> However, according to some other upstream maintainers, Linus's goal is to
> move most of the device-specific static data out of the kernel tree, into
> DT files (in the ARM case).  If that non-technical constraint is indeed
> the dominant consideration, then I agree that moving this data to DT is
> the only viable course of action.

Yeah... Personally I can't see any other way forward right now either as 
I was basically given the option to use DT for this work or not do it at 
all...

>
> ...
>
> The second issue concerns where the SoC clock nodes should go in the DT.
> In these patches, the clock data has been encoded in a large "clocks" node
> off the top level.  This is almost certainly not the right thing to do
> from a device hardware point of view.  These clocks don't exist as
> standalone devices with their own address spaces decoded on the
> interconnect.  In all of the SoC cases that I'm aware of, clock control
> registers are part of larger IP blocks.
>
> For example, in the OMAP case, most of the system integration clock
> control registers are part of the OMAP-specific PRCM block, PRM block, or
> CM block.  Then there are other device-specific clocks, like DSS PLLs or
> UART dividers.  The control registers for these are generally located in
> the subsystem or device IP block itself, and are inaccessible when the
> subsystem or IP block is disabled.  These device-specific clocks belong to
> the IP block, not the SoC integration.  So, for example, if two SoCs use
> the same IP block, then the clock registers, and their offsets from the IP
> block address space base, are likely to be identical.

None of the clock registers defined in this set reside outside PRCM / 
control module, so they are always accessible. IP block internal 
dividers for UART and like, are defined and used only internally by the 
device drivers.

>
> So in my view, the right things to do here are to:
>
> 1. associate SoC DT clock data with the device node that contains the
>     clock control registers

So, either "cm", "prcm", and maybe "control_module" instead of current 
"clocks". How much do we benefit from this? This would get rid of need 
to call of_iomap() for each register basically.

>
> 2. specify relative offsets for clock registers from the start of
>     the IP block address range, rather than absolute addresses for clock
>     registers
>
> 3. place the responsibility for registering clocks into the IP block
>     drivers themselves
>
> This naturally separates clocks into per-IP block DT files.  It also
> provides the CCF with an easy way to ensure that the device that
> encloses the clock is enabled and accessible by the CPU core, before
> trying to access registers inside.
>
> Similarly, non-SoC off-chip clock data (such as for dedicated I2C PLLs)
> should also be associated with their I2C device node.
>
> Making these changes to Tero's existing patches should be relatively
> straightforward, based on what I've seen.


For the set, it doesn't matter where the clock nodes reside, if someone 
can point me out where to put them, they can be easily moved around. 
Separating the individual clocks based on their IP mapping can probably 
just be done by checking their register address.

Anyway, I would like to have a concensus if something like this should 
be done or not before starting to do the changes, as this is going to 
change the layout of the clock data completely, and will require a 
complete new testing + debugging round to be done, in addition to script 
changes.


> ...
>
> Regarding the third issue: let's postulate for the moment that the clock
> binding issues that I mention in #2 above are ignored (ha!), and that the
> existing DT clock data is merged.  These bindings are currently marked as
> "Unstable - ABI compatibility may be broken in the future".  What happens
> if, when we meet to discuss clock bindings at the kernel summit, we decide
> that significant changes are needed?  We could easily wind up with kernels
> that won't boot at all when used with newer DT data.
>
> Not to mention, merging such a large amount of code and data before the
> bindings are stable will increase the risk of massive churn as the
> bindings evolve towards stability.
>
> So IMHO, the way to fix this is to consider the clock data to be IP-block
> specific, as mentioned in #2.  Then there's no need for global clock
> bindings for the SoC clock cases.
>
> Otherwise, it seems prudent to at least wait until the global clock
> bindings are no longer marked as unstable.  The whole DT migration was
> predicated on the ideas of reducing churn in the Linux codebase, and
> preserving forward compatibility for DT data.  We shouldn't discard these
> goals just to merge something a little sooner.

Well, we can keep support for the vendor specific clock bindings in the 
kernel and if generic bindings will eventually go forward, we can evolve 
towards that. A pressing problem for this work to proceed is that we 
need to get boot support for some new SoCs in rather sooner than again 
wait two years and work with TI internal trees. And getting the boot 
support quickly in, it seems the only way to get it done is via vendor 
specific bindings, which are unstable in a sense that _if_ the generic 
bindings go forward, we should start using those instead.

> ...
>
> The fourth issue is where the clockdomain data should go.  The basic issue
> here is that the notion of "clockdomains" here is completely
> OMAP-specific.  OMAP clockdomains demarcate a group of clocks or IP blocks
> that share the same automatic idle behavior, controlled by their enclosing
> IP block (e.g., PRCM, PRM, CM, etc.).  Clockdomains are also used in the
> OMAP kernel code to link the clocks to their enclosing power domains,
> voltage rail control, etc.
>
> So since these are OMAP PRCM/CM/PRM-specific constructs, the right place
> for OMAP clockdomain data is underneath the OMAP-specific CM/PRCM DT
> nodes.  Again this should be an easy change to Tero's existing patches.

Yea, does not matter where in the dts files these reside. Clockdomain 
bindings / code implementation can be moved to wherever the CM code is 
going to move, and this should not cause any changes to the clockdomain 
binding definitions. Anyway, again I would like to have a clear 
concensus if the bindings should move someplace else before doing the 
changes.

-Tero

>
> ...
>
> So hey, if you've made it this far, thanks for reading.  My sense is that
> implementing #2 and #4 are relatively straightforward.
>
> Also, since this seems to have been a problem for some folks in the past,
> I want to make clear that I think both Mike and Tero have been doing good
> jobs on the CCF and OMAP clock patches so far.
>
> regards
>
> - Paul
>

