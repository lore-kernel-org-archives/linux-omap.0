From: Rob Herring <robherring2@gmail.com>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 21:32:39 -0600
Message-ID: <5126E6D7.4020004@gmail.com>
References: <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <20130221182724.GA14329@obsidianresearch.com> <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg> <20130221211444.GB20114@obsidianresearch.com> <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg> <20130221231848.880DE200552@gemini.denx.de> <20130221232821.GA2823@obsidianresearch.com> <5126B979.5000205@gmail.com> <20130222022212.GB11169@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20130222022212.GB11169@obsidianresearch.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Wolfgang Denk <wd@denx.de>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Nicolas Pitre <nico@fluxnic.net>, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 02/21/2013 08:22 PM, Jason Gunthorpe wrote:
> On Thu, Feb 21, 2013 at 06:19:05PM -0600, Rob Herring wrote:
> 
>> The desired FPGA use case is DT updates after booting the kernel. This
>> has nothing to do with FIT images. And if the FPGA tools generate the
>> DTB, then it is certainly not tied to the kernel.
> 
> Completely unrelated, but do you have any pointer for how to do this?
> Hot plugging a 'dtb fragment' into the kernel would be really handy..
> 

Look at "Introducing Device Tree Overlays" on devicetree-discuss and lkml.

> I'm thinking something like adding a tree below a PCI controller
> describing a PCI device and sub nodes, similar to what Thierry was
> doing for his Avionics. How would interrupt maps and phandles be
> managed across the main dtb and the 'hot plugged' dtb?

Generally you don't describe the devices on PCI unless there are
non-discoverable aspects like a sideband gpio.

Rob

