From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] ARM part of USB patches
Date: Tue, 5 Feb 2013 09:27:24 -0800
Message-ID: <20130205172724.GA1601@kroah.com>
References: <51112418.5020000@ti.com>
 <51112495.4060908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51112495.4060908@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: kishon <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 05, 2013 at 08:56:13PM +0530, kishon wrote:
> Hi Tony, Greg,
> 
> On Tuesday 05 February 2013 08:54 PM, kishon wrote:
> >Hi Tony,
> >
> >As discussed, I'm sending a pull request for the arch/arm part of my USB
> >patches. These patches are necessary to get MUSB functional in both dt
> >and non-dt boot. Also added dt data for dwc3 present in OMAP. This patch
> >series *depends* on some of the patches which are merged in usb-next.
> 
> This patch series should go in only after USB. Or else it will break
> compilation.

Then it probably should go through the USB tree, right?  We don't want
to break bisectability.

thanks,

greg k-h
