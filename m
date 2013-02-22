From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Fri, 22 Feb 2013 00:39:26 +0000
Message-ID: <20130222003926.GI17852@n2100.arm.linux.org.uk>
References: <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <51265BF1.5000302@ti.com> <alpine.LFD.2.03.1302211358070.6419@syhkavp.arg> <5126778A.4040705@wwwdotorg.org> <alpine.LFD.2.03.1302211505560.6419@syhkavp.arg> <5126B77C.9060302@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5126B77C.9060302@wwwdotorg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Tom Rini <trini@ti.com>, "Fernandes, Joel A" <joelagnel@ti.com>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 21, 2013 at 05:10:36PM -0700, Stephen Warren wrote:
> On 02/21/2013 02:18 PM, Nicolas Pitre wrote:
> > Where were such guidance given?
> 
> IIRC, it's been discussed a number of times on the Linux ARM kernel
> mailing list and at the various ARM workshops at kernel summit and/or
> Linaro Connect. It has been a while, so maybe the advice was simply
> supposed to age out, but I certainly haven't seen any explicit
> indication that the advice was temporary or rescinded.

And this is why Linaro Connects are a bad idea.  They give the illusion
of decisions being taken and finalize, taking the decision process out
of the open source community.

It can be viewed as corporate takeover of open source.  (I realise that
comment is going to get peoples backs up - but unfortunately you can't
call an apple a pear.)

What is the really sad thing is that at no point do the Linaro Connects
really come back to the community (such as this mailing list) and say
"this is what was discussed, and this is what we think, can we get
agreement".  Instead what happens is that stuff gets discussed behind
closed doors, work starts, patches come out, and then it gets discussed
openly.

And... as for the meeting notes system... I looked at the ARM booting
stuff on Linaro's website - it contains no real useful information, it
looks like it's fallen by the way side.  So what's the point of having
a page or two on it?

> Someone will want to use a previously unsupported feature of some HW and
> then write the DT bindings for that feature for the first time. E.g.
> Tegra's one-wire controller isn't that commonly used, so we have no
> binding for it yet despite it being maybe a couple years after starting
> DT work for Tegra. The AC'97 was only recently supported.
> 
> Now I agree that this probably will settle down eventually. However, HW
> will have been widely distributed well before the DT bindings are
> feature-complete and bug-free. Any solution needs to take that into
> account, rather than only attempting to solve the situation after the
> hardware is obsolete and hence the bindings are stable.

Tell me then - how is it possible for my laptop to boot correctly with
its ACPI data which describes its hardware, and that ACPI data hardly
ever has to be updated.  Many PC systems have been doing this for
years, with various degrees of success - but generally once you have
a working system it stays working and never needs to have its ACPI data
updated.
