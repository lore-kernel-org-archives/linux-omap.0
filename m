From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Sat, 20 Jul 2013 15:00:06 -0700
Message-ID: <20130720220006.GA7977@kroah.com>
References: <20130718072004.GA16720@kroah.com> <51E7AE88.3050007@ti.com>
 <20130718154954.GA31961@kroah.com> <51E8D086.809@ti.com>
 <20130719054311.GA14638@kroah.com> <51E8D4E0.8060200@ti.com>
 <20130719062941.GA23611@kroah.com> <51E8DE51.1060404@ti.com>
 <20130719235055.GB11498@kroah.com> <51EA01C4.2010006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51EA01C4.2010006-l0cyMroinI0@public.gmane.org>
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
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jul 20, 2013 at 08:49:32AM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Saturday 20 July 2013 05:20 AM, Greg KH wrote:
> >On Fri, Jul 19, 2013 at 12:06:01PM +0530, Kishon Vijay Abraham I wrote:
> >>Hi,
> >>
> >>On Friday 19 July 2013 11:59 AM, Greg KH wrote:
> >>>On Fri, Jul 19, 2013 at 11:25:44AM +0530, Kishon Vijay Abraham I wrote:
> >>>>Hi,
> >>>>
> >>>>On Friday 19 July 2013 11:13 AM, Greg KH wrote:
> >>>>>On Fri, Jul 19, 2013 at 11:07:10AM +0530, Kishon Vijay Abraham I wrote:
> >>>>>>>>>>+	ret = dev_set_name(&phy->dev, "%s.%d", dev_name(dev), id);
> >>>>>>>>>
> >>>>>>>>>Your naming is odd, no "phy" anywhere in it?  You rely on the sender to
> >>>>>>>>>never send a duplicate name.id pair?  Why not create your own ids based
> >>>>>>>>>on the number of phys in the system, like almost all other classes and
> >>>>>>>>>subsystems do?
> >>>>>>>>
> >>>>>>>>hmm.. some PHY drivers use the id they provide to perform some of their
> >>>>>>>>internal operation as in [1] (This is used only if a single PHY provider
> >>>>>>>>implements multiple PHYS). Probably I'll add an option like PLATFORM_DEVID_AUTO
> >>>>>>>>to give the PHY drivers an option to use auto id.
> >>>>>>>>
> >>>>>>>>[1] ->
> >>>>>>>>http://archive.arm.linux.org.uk/lurker/message/20130628.134308.4a8f7668.ca.html
> >>>>>>>
> >>>>>>>No, who cares about the id?  No one outside of the phy core ever should,
> >>>>>>>because you pass back the only pointer that they really do care about,
> >>>>>>>if they need to do anything with the device.  Use that, and then you can
> >>>>>>
> >>>>>>hmm.. ok.
> >>>>>>
> >>>>>>>rip out all of the "search for a phy by a string" logic, as that's not
> >>>>>>
> >>>>>>Actually this is needed for non-dt boot case. In the case of dt boot, we use a
> >>>>>>phandle by which the controller can get a reference to the phy. But in the case
> >>>>>>of non-dt boot, the controller can get a reference to the phy only by label.
> >>>>>
> >>>>>I don't understand.  They registered the phy, and got back a pointer to
> >>>>>it.  Why can't they save it in their local structure to use it again
> >>>>>later if needed?  They should never have to "ask" for the device, as the
> >>>>
> >>>>One is a *PHY provider* driver which is a driver for some PHY device. This will
> >>>>use phy_create to create the phy.
> >>>>The other is a *PHY consumer* driver which might be any controller driver (can
> >>>>be USB/SATA/PCIE). The PHY consumer will use phy_get to get a reference to the
> >>>>phy (by *phandle* in the case of dt boot and *label* in the case of non-dt boot).
> >>>>>device id might be unknown if there are multiple devices in the system.
> >>>>
> >>>>I agree with you on the device id part. That need not be known to the PHY driver.
> >>>
> >>>How does a consumer know which "label" to use in a non-dt system if
> >>>there are multiple PHYs in the system?
> >>
> >>That should be passed using platform data.
> >
> >Ick, don't pass strings around, pass pointers.  If you have platform
> >data you can get to, then put the pointer there, don't use a "name".
> 
> I don't think I understood you here :-s We wont have phy pointer
> when we create the device for the controller no?(it'll be done in
> board file). Probably I'm missing something.

Why will you not have that pointer?  You can't rely on the "name" as the
device id will not match up, so you should be able to rely on the
pointer being in the structure that the board sets up, right?

Don't use names, especially as ids can, and will, change, that is going
to cause big problems.  Use pointers, this is C, we are supposed to be
doing that :)

thanks,

greg k-h
