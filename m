From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: RE: [RESEND PATCH 05/11] ARM: OMAP: USB: Host: usb host Device tree
 node Adaptation
Date: Thu, 1 Nov 2012 15:12:16 +0000
Message-ID: <A5063B091B3D3440AC5162AF1265EB00F72600@DBDE01.ent.ti.com>
References: <1351693612-23314-1-git-send-email-keshava_mgowda@ti.com>
 <1351693612-23314-6-git-send-email-keshava_mgowda@ti.com>
 <20121031182903.GN12739@atomide.com>
 <A5063B091B3D3440AC5162AF1265EB00F724DD@DBDE01.ent.ti.com>,<20121101102104.GB410@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121101102104.GB410@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "Cousson, Benoit" <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org


________________________________________
From: Balbi, Felipe
Sent: Thursday, November 01, 2012 3:51 PM
To: Munegowda, Keshava
Cc: Tony Lindgren; linux-omap@vger.kernel.org; devicetree-discuss@lists.ozlabs.org; linux-doc@vger.kernel.org; linux-usb@vger.kernel.org; Balbi, Felipe; sameo@linux.intel.com; Cousson, Benoit
Subject: Re: [RESEND PATCH 05/11] ARM: OMAP: USB: Host: usb host Device tree node Adaptation

On Thu, Nov 01, 2012 at 09:19:48AM +0100, Munegowda, Keshava wrote:
>
> ________________________________________
> From: Tony Lindgren [tony@atomide.com]
> Sent: Wednesday, October 31, 2012 11:59 PM
> To: Munegowda, Keshava
> Cc: linux-omap@vger.kernel.org; devicetree-discuss@lists.ozlabs.org; linux-doc@vger.kernel.org; linux-usb@vger.kernel.org; Balbi, Felipe; sameo@linux.intel.com; Cousson, Benoit
> Subject: Re: [RESEND PATCH 05/11] ARM: OMAP: USB: Host: usb host Device tree node Adaptation
>
> * Keshava Munegowda <keshava_mgowda@ti.com> [121031 07:29]:
> > The USB2 Host device node is extracted and used in the probe
> > of the driver to initialize the usb ports and controller. The
> > platform specific initialization is also performed.
> >
> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> > ---
> >  arch/arm/mach-omap2/usb-host.c         |    2 -
> >  drivers/mfd/omap-usb-host.c            |  163 +++++++++++++++++++++++---------
> >  include/linux/platform_data/usb-omap.h |   19 +++-
> >  3 files changed, 133 insertions(+), 51 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> > index d1dbe12..239c175 100644
> > --- a/arch/arm/mach-omap2/usb-host.c
> > +++ b/arch/arm/mach-omap2/usb-host.c
> > @@ -502,8 +502,6 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
> >       }
> >       ehci_data.phy_reset = pdata->phy_reset;
> >       ohci_data.es2_compatibility = pdata->es2_compatibility;
> > -     usbhs_data.ehci_data = &ehci_data;
> > -     usbhs_data.ohci_data = &ohci_data;
> >
> >       if (cpu_is_omap34xx()) {
> >               setup_ehci_io_mux(pdata->port_mode);
>
> Just checking.. Have you tested that these patches also
> still work without device tree?
>
> Regards,
>
> Tony
>
>
> No ! with out device tree enabled , these patches does not work.
> do I need to make a code such way that it works with and without
> device tree..?

yes. OMAP3/4 still have lots of legacy platform_data-only board support
;-)


Thanks Felipe.
   I will do this.

regards
keshava

