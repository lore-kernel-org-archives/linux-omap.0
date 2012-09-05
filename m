From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 20/23] serial: omap: fix software flow control
Date: Wed, 5 Sep 2012 13:27:49 -0700
Message-ID: <20120905202749.GA2451@kroah.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-21-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1345717983-18179-21-git-send-email-balbi@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: alan@linux.intel.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Vikram Pandita <vikram.pandita@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 23, 2012 at 01:33:00PM +0300, Felipe Balbi wrote:
> From: Vikram Pandita <vikram.pandita@ti.com>
> 
> Software flow control register bits were not defined correctly.
> 
> Also clarify the IXON and IXOFF logic to reflect what userspace wants.
> 
> Cc: stable@vger.kernel.org
> Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---

If this is a stable patch, should it be pulled out and put also in for
3.6?

thanks,

greg k-h
