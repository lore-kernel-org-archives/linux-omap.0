From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] usb: musb: fix USB enumeration issue in OMAP3
 platform
Date: Tue, 16 Jul 2013 05:47:22 -0700
Message-ID: <20130716124721.GB7656@atomide.com>
References: <1373282057-20181-1-git-send-email-kishon@ti.com>
 <51E4DFA6.2010501@ti.com>
 <20130716124227.GC15036@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130716124227.GC15036@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, gregkh@linuxfoundation.org, linux@arm.linux.org.uk, eballetbo@gmail.com, javier@dowhile0.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [130716 05:49]:
> Hi,
> 
> On Tue, Jul 16, 2013 at 11:22:38AM +0530, Kishon Vijay Abraham I wrote:
> > Tony,
> > 
> > On Monday 08 July 2013 04:44 PM, Kishon Vijay Abraham I wrote:
> > > This series fixes the USB enumeration issue caused because of the controller
> > > not able to get a reference to the PHY because of incorrect binding in the
> > > board file.
> > > 
> > > In the case of non-dt boot, the platform specific initialization file
> > > (board file) will do usb_bind_phy that binds the usb controller with the
> > > PHY using device names. After the device names are created using 
> > > PLATFORM_DEVID_AUTO, our original method of binding by device names doesn't
> > > work reliably (since the device name changes). Hence the usb controller
> > > is made to use labels for getting the PHY.
> > > 
> > > Here the PHY name is added in the plat data of USB controller device which
> > > should be used by the controller driver to get the PHY.
> > > Two new APIs usb_get_phy_by_name and devm_usb_get_phy_by_name are added to
> > > be used by the controller to get the PHY by name.
> > 
> > You haven't picked this patch series?
> 
> yeah and now it's too much to send during the -rc series. Here's what we
> can do, we can to minimum fix for -rc series (patching the names again)
> and I'll queue everything else for mailine if tony gives me his Ack for
> all arch/arm/*omap* parts.
> 
> Sounds good ?

Sounds good to me, except let's queue the last patch separately as cleanup
after the others are merged. I've acked the first patch, that should not
cause merge conflicts.

Regards,

Tony
