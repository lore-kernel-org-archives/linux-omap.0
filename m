From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH RFC] ehci-omap: simple suspend implementation
Date: Fri, 16 Feb 2018 14:31:11 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1802161426560.1402-100000@iolanthe.rowland.org>
References: <20180216193557.2a7dbda4@aktux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180216193557.2a7dbda4@aktux>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 16 Feb 2018, Andreas Kemnade wrote:

> On Fri, 16 Feb 2018 13:13:11 -0500 (EST)
> Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> 
> > On Fri, 16 Feb 2018, Andreas Kemnade wrote:
> > 
> > > This powers down the phy and on a gta04 it reduces
> > > suspend current by 13 mA.
> > > For unknown reasons usb does not power on properly.
> > > Also calling usb_phy_shutdown() here feels wrong
> > > apparently the reset line has to be activated.
> > > usb_phy_set_suspend is not enough here. The power
> > > consumption still stays approximately the same as
> > > without any patch.
> > > 
> > > With a device connected the device does not enumerate
> > > after resume. A rmmod ehci-omap ; modprobe ehci-omap
> > > does not make it reenumerade.
> > > So there is still something wrong here.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
> > > ---
> > >  drivers/usb/host/ehci-omap.c | 59 ++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 57 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> > > index 8d8bafc70c1f..0be2ccf8182a 100644
> > > --- a/drivers/usb/host/ehci-omap.c
> > > +++ b/drivers/usb/host/ehci-omap.c
> > > @@ -266,6 +266,58 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
> > >  	return 0;
> > >  }
> > >  
> > > +
> > > +static int __maybe_unused ehci_omap_suspend(struct device *dev)
> > > +{
> > > +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> > > +	struct omap_hcd *omap = (struct omap_hcd *)hcd_to_ehci(hcd)->priv;
> > > +	int ret;
> > > +	int i;
> > > +
> > > +	ret = ehci_suspend(hcd, false);
> > > +	if (ret) {
> > > +		dev_err(dev, "ehci suspend failed: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +	for (i = 0; i < omap->nports; i++) {
> > > +		if (omap->phy[i])
> > > +			usb_phy_shutdown(omap->phy[i]);
> > > +	}
> > > +	pm_runtime_put_sync(dev);  
> > 
> > Why do you include a runtime PM call here, given that the driver
> > doesn't support runtime suspend or resume?
> > 
> Well, the parent (drivers/mfd/omap-usb-host.c) has, and there are runtime PM
> calls here in the _probe/_remove functions, so it seems to be sane to do it
> here, too.

Not really -- when the whole system is going into suspend anyway, 
there's no point in trying to do a runtime suspend of the EHCI 
controller.  (In fact, the PM subsystem doesn't even allow it.)

> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __maybe_unused ehci_omap_resume(struct device *dev)
> > > +{
> > > +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> > > +	struct omap_hcd *omap = (struct omap_hcd *)hcd_to_ehci(hcd)->priv;
> > > +	int i;
> > > +
> > > +	pm_runtime_get_sync(dev);
> > > +	/*
> > > +	 * An undocumented "feature" in the OMAP3 EHCI controller,
> > > +	 * causes suspended ports to be taken out of suspend when
> > > +	 * the USBCMD.Run/Stop bit is cleared (for example when
> > > +	 * we do ehci_bus_suspend).
> > > +	 * This breaks suspend-resume if the root-hub is allowed
> > > +	 * to suspend. Writing 1 to this undocumented register bit
> > > +	 * disables this feature and restores normal behavior.
> > > +	 */
> > > +	ehci_write(hcd->regs, EHCI_INSNREG04,
> > > +		   EHCI_INSNREG04_DISABLE_UNSUSPEND);  
> > 
> > Doesn't this code belong in ehci_hcd_omap_probe()?  I assume you only
> > need to set this undocumented bit once, not every time the controller
> > is suspended.  And in any case, according to the comment, you would
> > need to take care of this before the root hub is suspended -- by the
> > time the controller is suspended, it is already too late.
> >
>  
> I am not really sure about this one. It is set in ehci_hcd_omap_probe()
> so it is set before suspend. I set it here to ensure it is re-set when
> the controller is powered down too much to keep register contents. I
> do not know if that is the case. But I thought it would not harm.

Ah, okay.  That's reasonable.  But you should change the comment: Refer
the reader to the existing comment in ehci_hcd_omap_probe() instead of
duplicating it, and then explain that the undocumented bit might not
survive a loss of power.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
