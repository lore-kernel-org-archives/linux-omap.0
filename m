From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH] usb: host: xhci-plat: release mem region while removing
 module
Date: Tue, 25 Jun 2013 11:23:56 -0700
Message-ID: <20130625182356.GB28833@xanatos>
References: <1371803348-9807-1-git-send-email-george.cherian@ti.com>
 <20130624142224.GI21889@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130624142224.GI21889@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 24, 2013 at 05:22:24PM +0300, Felipe Balbi wrote:
> On Fri, Jun 21, 2013 at 01:59:08PM +0530, George Cherian wrote:
> > Do a release_mem_region of the hcd resource. Without this the
> > subsequent insertion of module fails in request_mem_region.
> > 
> > Signed-off-by: George Cherian <george.cherian@ti.com>
> 
> very nice catch.
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> You need to resend with:
> 
> 	Cc: <stable@vger.kernel.org> # v3.4+
> 
> Not sure if Sarah wants to take care of the stable tagging, though.

I'll take care of the stable tagging.

Sarah Sharp
