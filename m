From: Greg KH <greg@kroah.com>
Subject: Re: [BACKPORT 4.14.y 04/18] usb: dwc3: Allow disabling of
 metastability workaround
Date: Mon, 11 Nov 2019 10:16:24 +0100
Message-ID: <20191111091624.GA4139389@kroah.com>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
 <20190905161759.28036-5-mathieu.poirier@linaro.org>
 <20190910143601.GD3362@kroah.com>
 <CANLsYkwkq2fLWsGXHxr2tSBLHdfe4JXgu8ehuD1FOEQeDAPNnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANLsYkwkq2fLWsGXHxr2tSBLHdfe4JXgu8ehuD1FOEQeDAPNnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: "# 4 . 7" <stable@vger.kernel.org>, linux-usb@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 11, 2019 at 08:01:40AM -0600, Mathieu Poirier wrote:
> On Tue, 10 Sep 2019 at 08:36, Greg KH <greg@kroah.com> wrote:
> >
> > On Thu, Sep 05, 2019 at 10:17:45AM -0600, Mathieu Poirier wrote:
> > > From: Roger Quadros <rogerq@ti.com>
> > >
> > > commit 42bf02ec6e420e541af9a47437d0bdf961ca2972 upstream
> > >
> > > Some platforms (e.g. TI's DRA7 USB2 instance) have more trouble
> > > with the metastability workaround as it supports only
> > > a High-Speed PHY and the PHY can enter into an Erratic state [1]
> > > when the controller is set in SuperSpeed mode as part of
> > > the metastability workaround.
> > >
> > > This causes upto 2 seconds delay in enumeration on DRA7's USB2
> > > instance in gadget mode.
> > >
> > > If these platforms can be better off without the workaround,
> > > provide a device tree property to suggest that so the workaround
> > > is avoided.
> > >
> > > [1] Device mode enumeration trace showing PHY Erratic Error.
> > >      irq/90-dwc3-969   [000] d...    52.323145: dwc3_event: event (00000901): Erratic Error [U0]
> > >      irq/90-dwc3-969   [000] d...    52.560646: dwc3_event: event (00000901): Erratic Error [U0]
> > >      irq/90-dwc3-969   [000] d...    52.798144: dwc3_event: event (00000901): Erratic Error [U0]
> >
> > Does the DT also need to get updated with this new id for this?  Is that
> > a separate patch somewhere?
> 
> The upstream commit is:
> 
> b8c9c6fa2002 ARM: dts: dra7: Disable USB metastability workaround for USB2
> 
> Should I just send the latter or you prefer a resend with both patches?

I've queued this up now, along with the rest of this series, thanks.

greg k-h
