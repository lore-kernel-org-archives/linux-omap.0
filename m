From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Fri, 22 Feb 2013 00:29:52 +0000
Message-ID: <20130222002952.GH17852@n2100.arm.linux.org.uk>
References: <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <20130221182724.GA14329@obsidianresearch.com> <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg> <20130221211444.GB20114@obsidianresearch.com> <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg> <5126B1A1.2070703@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5126B1A1.2070703@wwwdotorg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, "Fernandes, Joel A" <joelagnel@ti.com>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 21, 2013 at 04:45:37PM -0700, Stephen Warren wrote:
> Well they ship x86 CPU firmware updates according to the boot log on one
> of my systems at least...

Correction: CPU microcode updates.  That's updating the microcode in the
CPU which runs the x86 instruction set.  It's done to fix problems
discovered with execution of the CPU instruction set.

That's entirely separate from ACPI or DT blobs provided by the OEM.
