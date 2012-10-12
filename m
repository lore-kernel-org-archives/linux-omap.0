From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFT/PATCH] serial: omap: prevent resume if device is not
	suspended.
Date: Fri, 12 Oct 2012 17:42:02 +0100
Message-ID: <20121012164202.GQ28061@n2100.arm.linux.org.uk>
References: <20120925083029.GG31374@n2100.arm.linux.org.uk> <20120925083118.GI9137@arwen.pp.htv.fi> <20120925091228.GI31374@n2100.arm.linux.org.uk> <20120925091112.GK9137@arwen.pp.htv.fi> <20120925092118.GJ31374@n2100.arm.linux.org.uk> <CAKdam57bpTJ94Gn=mKVw1Fm-76fVPp3DGjFuNu_HfesybM1hPg@mail.gmail.com> <87ipas2y4h.fsf@deeprootsystems.com> <alpine.DEB.2.00.1210111748010.5736@utopia.booyaka.com> <50784458.9080806@ti.com> <877gqv7imt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877gqv7imt.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Sourav <sourav.poddar@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, gregkh@linuxfoundation.org, tony@atomide.com, linux-kernel@vger.kernel.org, santosh.shilimkar@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 12, 2012 at 09:35:54AM -0700, Kevin Hilman wrote:
> Sourav <sourav.poddar@ti.com> writes:
> > diff --git a/drivers/tty/serial/omap-serial.c
> > b/drivers/tty/serial/omap-serial.c
> > index 6ede6fd..3fbc7f7 100644
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -1414,6 +1414,7 @@ static int __devinit serial_omap_probe(struct
> > platform_device *pdev)
> >         INIT_WORK(&up->qos_work, serial_omap_uart_qos_work);
> >
> >         platform_set_drvdata(pdev, up);
> > +       pm_runtime_set_active(&pdev->dev);
> 
> NAK.
> 
> This will obviously break platforms where the UARTs are not active
> before driver loads.

I thought I had proposed a solution for this issue, which was this
sequence:

        omap_device_enable(dev);                                                
        pm_runtime_set_active(dev);                                             
        pm_runtime_enable(dev);                                                 

Yes, I can understand people not liking the omap_device_enable()
there, but I also notice that the email suggesting that never got a
reply either - not even a "I tried this and it doesn't work" or "it
does work".

As such, it seems this issue isn't making any progress as we had
already established that merely doing a "pm_runtime_set_active()"
before "pm_runtime_enable()" was going to break other platforms.
