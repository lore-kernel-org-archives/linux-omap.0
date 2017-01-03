From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] USB: ohci-omap: defer probe if PHY is missing
Date: Tue, 3 Jan 2017 20:05:04 +0100
Message-ID: <20170103190504.GA10352@kroah.com>
References: <20170102205355.18920-1-aaro.koskinen@iki.fi>
 <20170103165143.GA25272@kroah.com>
 <20170103185031.viic6w5tzshb7mt5@raspberrypi-2.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170103185031.viic6w5tzshb7mt5@raspberrypi-2.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 03, 2017 at 08:50:31PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Jan 03, 2017 at 05:51:43PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Jan 02, 2017 at 10:53:55PM +0200, Aaro Koskinen wrote:
> > > Defer probe if PHY is missing. E.g. on Nokia 770 several modules needs
> > > to be loaded to get the PHY going and ohci-omap should wait for those.
> > > 
> > > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > 
> > Is this a new bug?  The 770 has been around for forever, why has this
> > not been a problem before now?
> 
> PHY/OTG support for 770 has been around only since v3.14.

3.14 was released March, 2014.  A long time ago in kernel development :)

> I was previously compiling phy-tahvo as built-in, and bumped into this
> issue when compiling it as a module.

Why not just make the defconfig as built-in?

I'm not objecting to this patch, just really curious why no one else has
ever hit it.

thanks,

greg k-h
