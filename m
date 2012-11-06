From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/6] arch: Change defconfigs to point to
 g_mass_storage.
Date: Tue, 6 Nov 2012 12:40:12 -0800
Message-ID: <20121106204012.GP6801@atomide.com>
References: <cover.1351715302.v2.git.mina86@mina86.com>
 <46dde680f525562e9fd19567deb5247f0bf26842.1351715302.v2.git.mina86@mina86.com>
 <20121106113157.GE11931@arwen.pp.htv.fi>
 <20121106184117.GJ6801@atomide.com>
 <20121106184227.GK6801@atomide.com>
 <20121106203226.GB6291@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121106203226.GB6291@arwen.pp.htv.fi>
Sender: linux-sh-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Michal Nazarewicz <mpn@google.com>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Michal Nazarewicz <mina86@mina86.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel@blackfin.uclinux.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [121106 12:40]:
> Hi,
> 
> On Tue, Nov 06, 2012 at 10:42:27AM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [121106 10:41]:
> > > * Felipe Balbi <balbi@ti.com> [121106 03:40]:
> > > > Hi,
> > > > 
> > > > On Fri, Nov 02, 2012 at 02:31:50PM +0100, Michal Nazarewicz wrote:
> > > > > From: Michal Nazarewicz <mina86@mina86.com>
> > > > > 
> > > > > The File-backed Storage Gadget (g_file_storage) is being removed, since
> > > > > it has been replaced by Mass Storage Gadget (g_mass_storage).  This commit
> > > > > changes defconfigs point to the new gadget.
> > > > > 
> > > > > Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> > > > 
> > > > I need more Acks here. Only got one from Nicolas. Anyone else ?
> > > 
> > > For omaps:
> > > 
> > > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > Heh I guess no omap changes there, so probably not
> > worth adding then.
> 
> omap1 is old, but it's still omap :-)
> 
>  arch/arm/configs/omap1_defconfig                   |    3 +--

Oh OK so it was not a spurious ack after all :)

Tony
