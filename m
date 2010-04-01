From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] OMAP3:GPIO:Add support for early platform gpio
 device
Date: Thu, 1 Apr 2010 02:12:00 -0700
Message-ID: <20100401091200.GD31200@atomide.com>
References: <20100401072324.GD16297@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C4B8F29C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55045 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab0DAJKM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:10:12 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C4B8F29C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

* Varadarajan, Charulatha <charu@ti.com> [100401 01:54]:
> 
> 
> > -----Original Message-----
> > From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> > Sent: Thursday, April 01, 2010 12:53 PM
> > To: Varadarajan, Charulatha
> > Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com; tony@atomide.com
> > Subject: Re: [PATCH 2/8] OMAP3:GPIO:Add support for early platform gpio device
> > 
> > On Wed, Mar 31, 2010 at 02:23:53PM +0200, ext Charulatha V wrote:
> > >This patch adds support for implementing OMAP3 GPIO as an
> > >early platform device and adds gpio_init specific to OMAP3
> > >
> > >This patch adds device structures for each GPIO device in
> > >OMAP3 architecture. These strutures are not created in a
> > >separate *_data.c file because these structures would be
> > >removed once the driver gets adapted to HWMOD way.
> > >
> > >Signed-off-by: Charulatha V <charu@ti.com>
> > >---
> > > arch/arm/mach-omap2/gpio3xxx.c          |  351 +++++++++++++++++++++++++++++++
> > > arch/arm/mach-omap2/include/mach/gpio.h |   13 +-
> > > 2 files changed, 363 insertions(+), 1 deletions(-)
> > > create mode 100644 arch/arm/mach-omap2/gpio3xxx.c
> > >
> > >--- /dev/null
> > >+++ b/arch/arm/mach-omap2/gpio3xxx.c
> > >+
> > >+static struct __initdata omap_gpio_platform_data omap3_gpio1_config = {
> > >+	.ick_name = "gpio1_ick",
> > >+	.dbck_name = "gpio1_dbck",
> > 
> > do not pass clock names. Update the clkdev entries clk*_data.c
> 
> Agreed. These patches are in preparation for HWMOD. Once GPIO driver gets
> adapted to HWMOD, this would be removed.

Still need to change it before hwmod. No passing of clock names has been
needed for quite a while now.

Tony
