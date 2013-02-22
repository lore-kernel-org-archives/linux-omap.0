From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Fri, 22 Feb 2013 13:48:59 -0700
Message-ID: <5127D9BB.8060706@wwwdotorg.org>
References: <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <51265BF1.5000302@ti.com> <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg> <5126778A.4040705@wwwdotorg.org> <alpine.LFD.2.03.1302211505560.6419@syhkavp.arg> <5126B77C.9060302@wwwdotorg.org> <20130222003926.GI17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:40307 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757218Ab3BVUtF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Feb 2013 15:49:05 -0500
In-Reply-To: <20130222003926.GI17852@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 02/21/2013 05:39 PM, Russell King - ARM Linux wrote:
> On Thu, Feb 21, 2013 at 05:10:36PM -0700, Stephen Warren wrote:
>> On 02/21/2013 02:18 PM, Nicolas Pitre wrote:
...
>> Someone will want to use a previously unsupported feature of some HW and
>> then write the DT bindings for that feature for the first time. E.g.
>> Tegra's one-wire controller isn't that commonly used, so we have no
>> binding for it yet despite it being maybe a couple years after starting
>> DT work for Tegra. The AC'97 was only recently supported.
>>
>> Now I agree that this probably will settle down eventually. However, HW
>> will have been widely distributed well before the DT bindings are
>> feature-complete and bug-free. Any solution needs to take that into
>> account, rather than only attempting to solve the situation after the
>> hardware is obsolete and hence the bindings are stable.
> 
> Tell me then - how is it possible for my laptop to boot correctly with
> its ACPI data which describes its hardware, and that ACPI data hardly
> ever has to be updated.  Many PC systems have been doing this for
> years, with various degrees of success - but generally once you have
> a working system it stays working and never needs to have its ACPI data
> updated.

I'm not too familiar with ACPI or even low-level x86/PC architecture, so
forgive me if I'm talking crap, but I suspect there are quite a few
reasons for the differences here:

* PC systems in general are rather simpler and more standardized. Even
where "differentiation" can exist, it's encapsulated behind simple
self-contained interfaces.

* As an example, most random "expansion" devices on a PC are PCIe or USB
based, even built-in stuff such as WiFi cards etc. On ARM, there are no
standards, so anything goes. Hence, PC expansion cards are much more
self-contained and interact with other devices less, whereas on ARM you
have a whole spaghetti slew of chips, GPIOs, regulators, interrupts, ...

* I think ARM designs are exposed to a wider audience earlier on in
their maturity cycle. On x86, there are a number of standards for ACPI
etc., and the first people to interact with boards and implement these
standards are BIOS and board vendors, and then the boards get out to the
general public, and they at least basically all confirm to those
standards and work. However, on ARM, we're developing those standards
well after the fact; after the HW has shipped and been in use,
retro-fitting the standards etc. So, we're being exposed to a much
earlier point in the whole cycle than we can even see on x86. I bet x86
CPU, chipset, BIOS, and board vendors see the kind of change in ACPI
tables that we're seeing in DT right now.

* I imagine there are fewer different sets of people (CPU vendors, BIOS
vendors) having to work on defining ACPI standards than there are ARM
SoC vendors and Linux developer who're working on DT standards.

* x86 is very mature, so there's a lot more incremental development and
compatibility. ARM and DT-on-ARM are very new, so it's still the wild west.
