From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 7/8] usb: ohci: sort out dependencies for lpc32xx and
 omap
Date: Thu, 8 May 2014 11:51:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405081151000.1087-100000@iolanthe.rowland.org>
References: <1399557141-1346645-8-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399557141-1346645-8-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 8 May 2014, Arnd Bergmann wrote:

> The dependency on the isp1301 driver is not something that
> should be in the main OHCI driver but rather the SoC specific
> part of it.
> 
> This moves the dependency for LPC32xx into USB_OHCI_HCD_LPC32XX,
> and changes the 'select ISP1301_OMAP' to a similar 'depends on'.
> Since the same dependency exists for the client driver, do the
> same change there.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-omap@vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>

For the host side changes:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
