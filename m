From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N800 - USB Host mode issues
Date: Tue, 3 Jul 2007 02:26:41 -0700
Message-ID: <20070703092628.GA7062@atomide.com>
References: <468535CE.5070401@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <468535CE.5070401@gmx.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Robert Schuster <theBohemian@gmx.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Robert Schuster <theBohemian@gmx.net> [070629 09:41]:
> Hi,
> I am using the patches available from
> http://www.muru.com/linux/n800-usb-host/
> 
> to enable the USB Host mode capability of the N800 device
> 
> .. and have some questions:
> 
> I connected an external powered USB Hub to it and tried a few devices.
> 
> a)
> First of all: It works fine and I can for instance transmit big amount
> of data through a USB ethernet device (using the pegasus.ko driver).
> However it does not seem to like plugging devices of. Because after
> doing so (in case of the ethernet device I did ifconfig eth0 down first)
> the host will not accept the device anymore. It also seems to have
> trouble communicating to the hub at all.

Thanks for the info. Sounds like some of the issues have been
fixed already.

> b)
> The host did not accept an USB keyboard of mine which has two built-in
> USB 1.1 ports (the real HUB is an USB 2.0 one).

Turns out it's because the babble interrupts are fatal for HS
devices, but must be ignored for LS/FS devices... This is already fixed
in the linux-omap git tree.

> Has any development happened on the USB Hostdriver for the N800 after
> the release of the above mentioned patches?

Yes, but the changes have been only in the linux-omap git tree. I've
just refreshed the N800 usb host patches [1] to be in sync with linux-omap
tree. Can you please see if these work better for you?

> Is there any interest to debug the problems a) and b) further? If so,
> what info should I provide?

Yes, musb chips are integrated in 2430 and 3430, and tusb uses this chip
too. So development is going on, please post any patches you may have
to this mailing list :)

For the information to provide, knowing what kind of devices don't
work after updating to the latest series of patches would be nice.

Regards,

Tony

[1] http://www.muru.com/linux/n800-usb-host/
