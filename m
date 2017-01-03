From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] USB: ohci-omap: defer probe if PHY is missing
Date: Tue, 3 Jan 2017 20:50:31 +0200
Message-ID: <20170103185031.viic6w5tzshb7mt5@raspberrypi-2.musicnaut.iki.fi>
References: <20170102205355.18920-1-aaro.koskinen@iki.fi>
 <20170103165143.GA25272@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170103165143.GA25272@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jan 03, 2017 at 05:51:43PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 02, 2017 at 10:53:55PM +0200, Aaro Koskinen wrote:
> > Defer probe if PHY is missing. E.g. on Nokia 770 several modules needs
> > to be loaded to get the PHY going and ohci-omap should wait for those.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> Is this a new bug?  The 770 has been around for forever, why has this
> not been a problem before now?

PHY/OTG support for 770 has been around only since v3.14. I was previously
compiling phy-tahvo as built-in, and bumped into this issue when compiling
it as a module.

A.
