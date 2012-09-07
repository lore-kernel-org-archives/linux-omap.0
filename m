From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/3] arm: omap: hwmod: add a new addr space in otg for
 writing to control module
Date: Fri, 7 Sep 2012 04:57:12 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAAC815@DBDE01.ent.ti.com>
References: <1346943331-18120-1-git-send-email-kishon@ti.com>
 <1346943331-18120-2-git-send-email-kishon@ti.com> <5048C2A2.2020104@ti.com>
 <20120906171301.GC17754@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120906171301.GC17754-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "ABRAHAM,
 KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 06, 2012 at 22:43:03, Balbi, Felipe wrote:
> Hi,
> 
> On Thu, Sep 06, 2012 at 09:04:58PM +0530, Vaibhav Hiremath wrote:
> > 
> > 
> > On 9/6/2012 8:25 PM, Kishon Vijay Abraham I wrote:
> > > The mailbox register for usb otg in omap is present in control module.
> > > On detection of any events VBUS or ID, this register should be written
> > > to send the notification to musb core.
> > > 
> > > Till we have a separate control module driver to write to control module,
> > > omap2430 will handle the register writes to control module by itself. So
> > > a new address space to represent this control module register is added
> > > to usb_otg_hs.
> > > 
> > > Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> > > Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> > > ---
> > >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > > index 242aee4..02341bc 100644
> > > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > > @@ -5890,6 +5890,11 @@ static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
> > >  		.pa_end		= 0x4a0ab003,
> > >  		.flags		= ADDR_TYPE_RT
> > >  	},
> > > +	{
> > > +		.pa_start	= 0x4a00233c,
> > > +		.pa_end		= 0x4a00233f,
> > > +		.flags		= ADDR_TYPE_RT
> > > +	},
> > 
> > I do not have any objection/comment here, but I believe this is control
> > module address space required for USB module, right?
> > I am not sure this is right way of accessing control module space.
> > Actually Control Module Access required for drivers is one of the
> > blocking issue we have currently.
> > 
> > Also there was some effort put up by 'Konstantine' to convert Control
> > module to MFD driver, I haven't seen any further update on it. But it
> > would be good to check with him.
> 
> this was an agreement with Benoit since we already lost a couple merge
> windows for this patchset. We agreed to wait until -rc4 for SCM driver
> and if it wasn't ready, we'd go ahead with this and SCM author would fix
> it up on a patch converting users to new SCM driver.
> 

Understood and thanks for confirming.

Thanks,
Vaibhav

> -- 
> balbi
> 
