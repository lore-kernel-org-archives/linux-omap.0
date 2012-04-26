From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v3 0/9] Convert OMAP GPMC to driver
Date: Thu, 26 Apr 2012 05:18:15 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9700FE@DBDE01.ent.ti.com>
References: <cover.1333638917.git.afzal@ti.com>
 <20120425164424.GT3739@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120425164424.GT3739@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "grinberg@compulab.co.il" <grinberg@compulab.co.il>, "mike@compulab.co.il" <mike@compulab.co.il>, "Menon, Nishanth" <nm@ti.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "vimal.newwork@gmail.com" <vimal.newwork@gmail.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wed, Apr 25, 2012 at 22:14:25, Tony Lindgren wrote:
> > Once driver is acceptable, platform code for other peripherals
> > connected via GPMC would be adapted to make use of GPMC driver. And
> > then the board modifications. But before that HWMOD entry has to be
> > populated for respective SoC(s ?).
>  
> No, we can't do it this way, it breaks things. We need to first
> convert everything to use the new GPMC driver, then move it. 

Sorry, my statements were not clear, I meant once driver is
acceptable & still living in mach-omap2, platform code dealing
with peripherals on gpmc would be adapted to make use of gpmc
driver. Moving driver to new location is only planned as a
separate commit after, before mentioned changes. Hope with this
clarification we are on same track. 

>  
> > Now DESTINATION FOR THIS DRIVER has to be decided. Original plan was
> > to consider GPMC as MFD. The peripheral(s) connected to GPMC being
> > considered childs of MFD.
> 
> Let's not put it into MFD. This is a bus driver. But that
> decision can wait as we cleary have quite a few things to convert
> first under arch/arm/mach-omap2.
>  
> > Various options that could be seen so far on where this driver can go,
> > 1. mfd
> > 2. misc
> > 3. drivers/platform/arm/ (create an new one?)
> > 4. memory (create a new one ?)
> 
> It's a parallel bus driver, not memory not misc, not MFD.

Greg suggested to send gpmc driver to new memory folder.

In the next version, gpmc driver would still be in mach-omap2,
moving to new location can be done later.

Regards
Afzal
