From: Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Fri, 22 Feb 2013 02:56:33 -0500
Message-ID: <CA+T6QP=gHtOuZbjsbv5_GswZu7FUXW+9KVw6K06+5X_PNzqODw@mail.gmail.com>
References: <20130221134656.GC17852@n2100.arm.linux.org.uk>
	<51262A7A.8040103@ti.com>
	<alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
	<20130221182724.GA14329@obsidianresearch.com>
	<alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
	<20130221211444.GB20114@obsidianresearch.com>
	<alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
	<20130221231848.880DE200552@gemini.denx.de>
	<20130221232821.GA2823@obsidianresearch.com>
	<5126B979.5000205@gmail.com>
	<20130222022212.GB11169@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20130222022212.GB11169@obsidianresearch.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Rob Herring <robherring2@gmail.com>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kbuild@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 21, 2013 at 9:22 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Feb 21, 2013 at 06:19:05PM -0600, Rob Herring wrote:
>
>> The desired FPGA use case is DT updates after booting the kernel. This
>> has nothing to do with FIT images. And if the FPGA tools generate the
>> DTB, then it is certainly not tied to the kernel.
>
> Completely unrelated, but do you have any pointer for how to do this?
> Hot plugging a 'dtb fragment' into the kernel would be really handy..

This doesn't answer the full question on how FPGA tools generate DTB,
but it is a huge problem for BeagleBone add-on hardware that we have
some mechanism to dynamically load DT fragments. Pantelis posted some
work in that direction[1] and has continued development of his patches
and we've been using those extensively with BeagleBone kernel
development[2].

It would be great if the FPGA folks would get on-board in supporting
the dynamically loadable DT overlay fragments by reviewing and
supporting upstream acceptance of the code.

[1] http://lwn.net/Articles/531569/
[2] http://github.com/beagleboard/kernel/tree/3.8

>
> I'm thinking something like adding a tree below a PCI controller
> describing a PCI device and sub nodes, similar to what Thierry was
> doing for his Avionics. How would interrupt maps and phandles be
> managed across the main dtb and the 'hot plugged' dtb?
>
> Regards,
> Jason
> _______________________________________________
> U-Boot mailing list
> U-Boot@lists.denx.de
> http://lists.denx.de/mailman/listinfo/u-boot
