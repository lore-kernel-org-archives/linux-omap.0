From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers: phy: add generic PHY framework
Date: Wed, 26 Sep 2012 10:04:59 -0700
Message-ID: <20120926170459.GA30454@kroah.com>
References: <1348671675-20830-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348671675-20830-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: akpm@linux-foundation.org, joe@perches.com, davem@davemloft.net, santosh.shilimkar@ti.com, grant.likely@secretlab.ca, balbi@ti.com, arnd@arndb.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, robherring2@gmail.com, richard.zhao@freescale.com, B29397@freescale.com, alexander.shishkin@linux.intel.com, mkl@pengutronix.de, marex@denx.de, p.paneri@samsung.com, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 26, 2012 at 08:31:15PM +0530, Kishon Vijay Abraham I wrote:
> The PHY framework provides a set of API's for the PHY drivers to
> create/destroy a PHY and API's for the PHY users to obtain a reference to the
> PHY with or without using phandle. To obtain a reference to the PHY without
> using phandle, the platform specfic intialization code (say from board file)
> should have already called phy_bind with the binding information. The binding
> information consists of phy's device name, phy user device name and an index.
> The index is used when the same phy user binds to mulitple phys.
> 
> PHY drivers should create the PHY by passing phy_descriptor that has
> describes the PHY (label, type etc..) and ops like init, exit, suspend, resume,
> poweron, shutdown.

Do you have an example driver that uses this new framework?

How does it look in sysfs?  You need to add Documentation/ABI/ entries
for the sysfs files you created as well.

greg k-h
