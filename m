From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 16:50:12 -0700
Message-ID: <5126B2B4.3060403@wwwdotorg.org>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <20130221182724.GA14329@obsidianresearch.com> <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg> <20130221211444.GB20114@obsidianresearch.com> <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg> <20130221231106.GA24426@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48980 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab3BUXuR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Feb 2013 18:50:17 -0500
In-Reply-To: <20130221231106.GA24426@obsidianresearch.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Linux@theia.denx.de, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 02/21/2013 04:11 PM, Jason Gunthorpe wrote:
> On Thu, Feb 21, 2013 at 05:05:54PM -0500, Nicolas Pitre wrote:
...
>> The DT is meant to describe hardware.  As far as I know, the hardware I 
>> own seems to be rather static and stable, and unlike software there is 
>> no way I can change it (soldering irons don't count).
> 
> .. and the patching I mention above are largely driven by either a
> change in understanding of how OF should describe the hardware, or a
> change in understanding of how the driver should treat the
> hardware.
> 
> The recent patching for the tegra PCI-E bridge is instructive in this
> regard, Theirry learned how to drive the chip in a way that creates a
> single PCI domain - this necessitates a change in how the DT models
> that hardware block.

While I certainly don't disagree with the sentiment of your email, Tegra
PCIe is a bad example. There is no finalized DT binding yet for the
Tegra PCIe HW. Thierry is in the process of defining it for the first time.
