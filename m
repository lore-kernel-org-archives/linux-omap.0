From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 16:45:37 -0700
Message-ID: <5126B1A1.2070703@wwwdotorg.org>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <20130221182724.GA14329@obsidianresearch.com> <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg> <20130221211444.GB20114@obsidianresearch.com> <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 02/21/2013 03:05 PM, Nicolas Pitre wrote:
> On Thu, 21 Feb 2013, Jason Gunthorpe wrote:
...
>> Distros already ship huge kernels with modules for every hardware out
>> there. Shipping all the DTs as well doesn't seem like a problem.
> 
> But it is!  Even shipping multiple kernels _is_ a problem for them.  
> Hence this multi-platform kernel effort.  Otherwise why would we bother?
> 
> According to your logic, distros could package and distribute BIOS 
> updates for all the X86 systems out there.  After all, if they did, they 
> would guarantee even better support on the hardware they target and not 
> have to carry those ACPI quirks in the kernel, no?
> 
> Ask them if they find this idea rejoicing.  You might be surprised.

Well they ship x86 CPU firmware updates according to the boot log on one
of my systems at least...
