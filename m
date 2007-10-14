From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.23-omap] misc musb tweaks
Date: Sun, 14 Oct 2007 10:16:42 -0700
Message-ID: <20071014171642.GF22833@atomide.com>
References: <200710121426.00525.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200710121426.00525.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [071012 14:29]:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> The patch below fixes a few minor infelicities.

Pushed, glad to see _the_ USB experts working on this thing :)

I guess we should still at least clean up the CONFIG_USB_INVENTRA_DMA
sections in the common DMA code before submitting to linux-usb-devel.

What else should we still fix before submitting to linux-usb-devel?

Regards,

Tony
