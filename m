From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC PATCH 3/6] usb: otg: utils: change the phy lib to support
 multiple PHYs of same type
Date: Thu, 17 Jan 2013 09:31:50 +0900
Message-ID: <20130117003150.GF19552@verge.net.au>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-4-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358348462-27693-4-git-send-email-kishon@ti.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, balbi@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, magnus.damm@gmail.com, cbou@mail.ru, dwmw2@infradead.org, alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org, leoli@freescale.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, stern@rowland.harvard.edu
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 16, 2013 at 08:30:59PM +0530, Kishon Vijay Abraham I wrote:
> In order to add support for multipe PHY's of the same type, the API's
> for adding PHY and getting PHY has been changed. Now the binding
> information of the PHY and controller should be done in platform file
> using usb_bind_phy API. And for getting a PHY, the device pointer of the
> USB controller and an index should be passed. Based on the binding
> information that is added in the platform file, get_phy will return the
> approappropriate PHY.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-shmobile/board-marzen.c |    2 +-

Modification to the above file:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
