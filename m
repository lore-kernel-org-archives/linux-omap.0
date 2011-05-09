From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH 4/4] USB: TWL6025 allow different regulator name
Date: Mon, 09 May 2011 12:43:49 +0100
Message-ID: <1304941430.3192.4.camel@odin>
References: <1303897191-14792-1-git-send-email-gg@slimlogic.co.uk>
	 <1303897191-14792-5-git-send-email-gg@slimlogic.co.uk>
	 <20110427104542.GZ13227@legolas.emea.dhcp.ti.com>
	 <1304867317.3246.10.camel@odin>
	 <20110509090335.GC1254@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110509090335.GC1254@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Graeme Gregory <gg@slimlogic.co.uk>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

On Mon, 2011-05-09 at 12:03 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Sun, May 08, 2011 at 04:08:37PM +0100, Liam Girdwood wrote:
> > On Wed, 2011-04-27 at 13:45 +0300, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Wed, Apr 27, 2011 at 10:39:51AM +0100, Graeme Gregory wrote:
> > > > The twl6025 uses a different regulator for USB than the 6030 so select
> > > > the correct regulator name depending on the subclass of device.
> > > > 
> > > > Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> > > 
> > > I don't see the point of this patch. It's just a string. Use the same
> > > name and add a comment saying that on datasheet/TRM/documentation the
> > > name LDO is actually referred to as LDOUSB. It's the same functionality
> > > anyway.
> > > 
> > 
> > I think for the avoidance of any doubt, it's probably best to use the
> > TWL6025 string name here as it will importantly match the TWL6025 TRM
> > and any schematics using the TWL6025. Getting this wrong during TWL6025
> > board integration has the potential for hardware damage.
> 
> I would rather have something that doesn't depend on a correct string
> and matches based on the device pointer instead. I agree that having the
> correct string makes it easier to reference schematics/trm and the like,
> but making the SW depend on the correct spelling of a simple string, is
> too much for me :-(
> 
> Specially when getting it wrong "has the potential for hardware damage"
> :-)
> 

I think it's the lesser evil though, especially for device integrators.
They will just match the regulator name from the schematics together
with the TRM name when creating their regulator constraints and having
different names here will definitely cause confusion.

Liam
