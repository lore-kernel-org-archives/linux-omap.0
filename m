From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] USB: ohci-omap: defer probe if PHY is missing
Date: Wed, 4 Jan 2017 09:41:49 -0800
Message-ID: <20170104174149.GG25222@atomide.com>
References: <20170102205355.18920-1-aaro.koskinen@iki.fi>
 <20170103165143.GA25272@kroah.com>
 <20170103185031.viic6w5tzshb7mt5@raspberrypi-2.musicnaut.iki.fi>
 <20170103190504.GA10352@kroah.com>
 <20170103201217.cxzx5yjthyki6q4w@raspberrypi-2.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170103201217.cxzx5yjthyki6q4w@raspberrypi-2.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [170103 12:13]:
> On Tue, Jan 03, 2017 at 08:05:04PM +0100, Greg Kroah-Hartman wrote:
> > I'm not objecting to this patch, just really curious why no one else has
> > ever hit it.
> 
> Maybe I'm the only user...

I still have 770 in my test rack :) I don't boot it much though as
it needs a smaller kernel than what I typically build..

Tony
