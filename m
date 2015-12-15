From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular
 host/pci*
Date: Tue, 15 Dec 2015 10:16:24 -0500
Message-ID: <20151215151624.GB2772@windriver.com>
References: <1449970917-12633-1-git-send-email-paul.gortmaker@windriver.com>
 <CAFiDJ5-Y8afg5kDRQLK1pain-k1kPQAn3vhWrVkB1ADPRHvx+A@mail.gmail.com>
 <20151214091940.GA15126@ulmo.nvidia.com>
 <3302340.SIljl1qYTl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3302340.SIljl1qYTl@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Rocketboard Maillist <rfi@lists.rocketboards.org>, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Kishon Vijay Abraham I <kishon@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jason Cooper <jason@lakedaemon.net>, Stephen Warren <swarren@wwwdotorg.org>, Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Richard Zhu <Richard.Zhu@>
List-Id: linux-omap@vger.kernel.org

[Re: [PATCH 00/10] drivers/pci: avoid module_init in non-modular host/pci*] On 14/12/2015 (Mon 11:27) Arnd Bergmann wrote:

> On Monday 14 December 2015 10:19:40 Thierry Reding wrote:
> > > PCIe host driver that use fixup (DECLARE_PCI_FIXUP_*) can't use tristate.
> > > Fixup region is in kernel region and this region if not updated when
> > > loading a module.
> > 
> > Interesting, I hadn't thought about that. I suppose this means that the
> > module will end up containing an unused section with the fixup code. It
> > might be useful to add a way for that to trigger a warning at build
> > time.
> > 
> > Perhaps to fix this a mechanism could be introduced to add a table of
> > fixups to a host controller driver and that will get applied to all
> > children of the bridge. It could be problematic to cover all of the
> > different fixup stages, though.
> > 
> 
> 
> I think a lot of the fixups shouldn't really be there in the first place,
> they are about stuff that we can fix up in the probe function, or that should
> be fixed up in the probe function with some appropriate core support added.

So, the feedback on this is a bit all over the map, leaving me unsure
what to do next.  And is the choice we make on a per board/bsp basis or
ideally across all platforms?  I see the choices as:

1) do nothing; which IMHO is least desirable as it leaves the code
misrepresenting itself as modular; one of the key issues I wanted to fix

2) use the patches I've sent ; then as they are genuinely made modular,
the person doing so essentially "patch -R" or reverts the change as
step one.  This has the advantage of solving the "we'll get to it
someday" issue if someday never comes.

3) make them all tristate;  beat it with a stick until it compiles [M]
and modposts -- leaving the fixups and functional testing to people with
the boards and low level knowledge to make it _work_ as a module.  The
downside here is the code is still kind of misrepresenting itself as
modularly functional -- a ban of unloading might mitigate that some.

Paul.
--

> 
> 	Arnd
