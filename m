From: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Fri, 22 Feb 2013 07:55:46 +0100
Message-ID: <20130222065546.F1609200550@gemini.denx.de>
References: <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk> <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg> <20130221182724.GA14329@obsidianresearch.com> <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg> <20130221211444.GB20114@obsidianresearch.com> <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg> <20130221231848.880DE200552@gemini.denx.de> <20130221232821.GA2823@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-reply-to: <20130221232821.GA2823@obsidianresearch.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Tom Rini <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Dear Jason,

In message <20130221232821.GA2823@obsidianresearch.com> you wrote:
> 
> > > own seems to be rather static and stable, and unlike software there is 
> > > no way I can change it (soldering irons don't count).
> > 
> > There is other hardware available (for example FPGA based) where this
> > does not apply.
> 
> Agreed.. We do that here as well, the DT is also used to describe the
> functionality inside FPGA(s). We do things like declare a GPIO
> controller inside the FPGA, then stack the bitbang MDIO/I2C on top of
> that, then declare a bunch of devices on those busses. DT makes this
> extremely straightforward.
> 
> However, it is critical that the DT, kernel and FPGA are matched
> together - we always arrange things so that the DTB, kernel and FPGA
> config are bundled together and update atomically during firmware
> upgrade.

Agreed.

> Xilinx's Zynq is a great example of this kind of stuff, FWIW. IIRC

Indeed - Xilinx's Zynq, Altera's SoC FPGA, and others.

Such highly flexible hardware configurations require a new level of
software support that by far exceeds the classic static setups of more
"PC-like" systems where the only change you would expect is adding or
removing some PCI cards or the like.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Don't tell me how hard you work.  Tell me how much you get done.
                                                     -- James J. Ling
