From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/4] ARM: OMAP: devices: create device for usb part
 of control module
Date: Fri, 1 Feb 2013 11:16:24 -0800
Message-ID: <20130201191624.GR22517@atomide.com>
References: <1358777308-2409-1-git-send-email-kishon@ti.com>
 <1358777308-2409-3-git-send-email-kishon@ti.com>
 <20130123112422.GF29258@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54863 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754766Ab3BATQ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 14:16:28 -0500
Content-Disposition: inline
In-Reply-To: <20130123112422.GF29258@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux@arm.linux.org.uk, gregkh@linuxfoundation.org

* Felipe Balbi <balbi@ti.com> [130123 03:27]:
> Hi,
> 
> On Mon, Jan 21, 2013 at 07:38:26PM +0530, Kishon Vijay Abraham I wrote:
> > A seperate driver has been added to handle the usb part of control
> > module. A device for the above driver is created here, using the register
> > address information to be used by the driver for powering on the PHY and
> > for writing to the mailbox.
> > 
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Tony ? Without this we won't have the control module driver.

Looks OK to me, but please see my other reply regarding on
you setting up some immutable branches to avoid pointless
merge conflicts.

Regards,

Tony
