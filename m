From: "Lohithakshan, Ranjith" <ranjithl@ti.com>
Subject: RE: drivers that require headers in mach-omap
Date: Mon, 3 Aug 2009 16:19:20 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF2954@dbde02.ent.ti.com>
References: <8bb80c380907281849i1cd271f3n64a391327cd8bb5e@mail.gmail.com>
  <FCCFB4CDC6E5564B9182F639FC35608702F58506D2@dbde02.ent.ti.com>
 <8bb80c380907301620g5761ae36j55bec6747e32657a@mail.gmail.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F58507F8@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0908021733120.19529@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52068 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbZHCKtc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 06:49:32 -0400
In-Reply-To: <alpine.DEB.2.00.0908021733120.19529@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Mike Chan <mike@android.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Monday, August 03, 2009 5:04 AM
> To: Pandita, Vikram
> Cc: Mike Chan; Kevin Hilman; linux-omap@vger.kernel.org
> Subject: RE: drivers that require headers in mach-omap
> 
> On Fri, 31 Jul 2009, Pandita, Vikram wrote:
> 
> > >-----Original Message-----
> > >From: Mike Chan [mailto:mike@android.com]
> > >Sent: Thursday, July 30, 2009 6:20 PM
> > >To: Pandita, Vikram
> > >Cc: Kevin Hilman; linux-omap@vger.kernel.org
> > >Subject: Re: drivers that require headers in mach-omap
> > >
> > >On Thu, Jul 30, 2009 at 8:44 AM, Pandita, 
> Vikram<vikram.pandita@ti.com> wrote:
> > >>
> > >>>-----Original Message-----
> > >>>From: linux-omap-owner@vger.kernel.org 
> > >>>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Mike Chan
> > >>>Sent: Tuesday, July 28, 2009 8:49 PM
> > >>>To: Kevin Hilman; linux-omap@vger.kernel.org
> > >>>Subject: drivers that require headers in mach-omap
> > >>>
> > >>>Omap folks, how are drivers that require access to prm and cm 
> > >>>registers via cm_read_mod_reg() etc... suppose to access these?
> > >>>
> > >>>For example if drivers/usb/host/ohci-omap.c wanted to call:
> > >>>cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_IDLEST);
> > >>
> > >> The design was supposed to encapsulate the PRCM API's 
> from drivers.
> > >> Driver has control over the iclk and fclk and the clock 
> framework 
> > >> would take care of any CM/PRM
> > >register settings.
> > >>
> > >> Accessing these registers in drivers would make the 
> driver non-compatible for non-omap platforms.
> > >>
> > >
> > >Are drivers such as
> > >
> > >drivers/usb/host/ohci-omap.c
> > >drivers/usb/musb/omap2430.c
> > >
> > >suppose to be compatible for non-omap platforms?
> > 
> > As you put it, no they are not.
> > All PRM/CM register accesses have been restricted to 
> mach-omap2/plat-omap parts till now.
> > The question to ask is, what functionality is missing on 
> enabling say the usbhost clock that clock framework is not 
> doing, that driver has a need to do.
> 
> Just to follow up on this: the plan should be to remove all 
> PRM and CM references from those drivers.  Some of those can 
> be replaced with clock framework calls, others may need 
> platform_data function pointers.

To add to the list, drivers/usb/host/ehci-omap.c need a similar re-work. At the moment,
it does some amount of DPLL5 programming in itself before enabling the iclk and fclk.

> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 