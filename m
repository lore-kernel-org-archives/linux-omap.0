From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 18:19:15 -0600
Message-ID: <1361492355.1574.7@snotra>
References: <20130221231106.GA24426@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <u-boot-bounces@lists.denx.de>
In-Reply-To: <20130221231106.GA24426@obsidianresearch.com> (from
	jgunthorpe@obsidianresearch.com on Thu Feb 21 17:11:06 2013)
Content-Disposition: inline
List-Unsubscribe: <http://lists.denx.de/mailman/options/u-boot>,
	<mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <http://lists.denx.de/pipermail/u-boot>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <http://lists.denx.de/mailman/listinfo/u-boot>,
	<mailto:u-boot-request@lists.denx.de?subject=subscribe>
Sender: u-boot-bounces@lists.denx.de
Errors-To: u-boot-bounces@lists.denx.de
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 02/21/2013 05:11:06 PM, Jason Gunthorpe wrote:
> On Thu, Feb 21, 2013 at 05:05:54PM -0500, Nicolas Pitre wrote:
> > No it is not.  FIT is about bundling a multi-platform kernel with a
> > bunch of DTBs together in a single file.  I don't think you need  
> that
> > for your embedded system.  The "wrong message" here is to distribute
> > multiple DTBs around, whether it is with FIT or on a distro install
> > media.
> 
> Actually we do this on PPC, the boot kernel image runs on three
> similar hardware platforms, the image has three DTBs built into it and
> the right one is selected at runtime. The kernel boot image does this
> (call it a second stage boot loader), not the primary boot
> loader.
> 
> I strongly disagree with the idea that keeping the DTB seperated from
> the kernel is appropriate for all users, or even most users. To me
> that only seems appropriate for certain kinds of hardware, eg general
> purpose computing devices that are designed to primarily run a Linux
> distro.
> 
> An embedded SOC eval board, a development platform, an embedded
> appliance - these are cases where the kernel and DTB should generally
> be more tightly coupled.
> 
> This is more or less how PPC has evolved, big commerical PPC systems
> like Apple's and IBM's stuff all provide a DTB to the kernel - and
> this is actually a bit different then the DT's people are writing for
> SOCs, it is firmware generated and includes a full description of all
> the probed hardware - including pluggable PCI cards and other
> stuff. The hardware is also left configured so there is less for Linux
> to do and less that needs to be described in DT.
> 
> While embedded focused PPC stuff seems to tend to keep the kernel and
> DT together.

At least on the Freescale side of "embedded focused PPC stuff", we have  
not kept the kernel and DT together.  It's actually U-Boot that the dts  
files in the kernel tree are tied to, since they contain assumptions  
about how U-Boot lays out the memory map (there are some inherent  
limits to "the device tree just describes the hardware", barring some  
radical changes in the form device trees take), which things U-Boot  
will fill in/modify, and what U-Boot looks for to find out where to  
make the modification.  Usually U-Boot is the only relevant loader for  
a particular board, but not always -- hence "adder875-redboot.dts" and  
"adder875-uboot.dts".  Even when U-Boot is the only relevant loader,  
there are sometimes changes from one version or configuration of U-Boot  
to another that cause problems (e.g. the device trees that come in  
"32b" and "36b" variants).

-Scott
