From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v12 0/7] PHY framework
Date: Fri, 27 Sep 2013 17:37:42 -0700
Message-ID: <20130928003742.GA3659@kroah.com>
References: <1380263012-9687-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1380263012-9687-1-git-send-email-kishon@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: swarren@wwwdotorg.org, bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, s.nawrocki@samsung.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, rob@landley.net, linux@arm.linux.org.uk, jkosina@suse.cz, m.chehab@samsung.com, cesarb@cesarb.net, joe@perches.com, davem@davemloft.net, davidb@codeaurora.org, sameo@linux.intel.com, peter.ujfalusi@ti.com, t-kristo@ti.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, akpm@linux-foundation.org, balajitk@ti.com, george.cherian@ti.com, nsekhar@ti.com, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 27, 2013 at 11:53:24AM +0530, Kishon Vijay Abraham I wrote:
> Added a generic PHY framework that provides a set of APIs for the PHY drivers
> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
> the PHY with or without using phandle.
> 
> This framework will be of use only to devices that uses external PHY (PHY
> functionality is not embedded within the controller).
> 
> The intention of creating this framework is to bring the phy drivers spread
> all over the Linux kernel to drivers/phy to increase code re-use and to
> increase code maintainability.
> 
> Comments to make PHY as bus wasn't done because PHY devices can be part of
> other bus and making a same device attached to multiple bus leads to bad
> design.
> 
> If the PHY driver has to send notification on connect/disconnect, the PHY
> driver should make use of the extcon framework. Using this susbsystem
> to use extcon framwork will have to be analysed.
> 
> You can find this patch series @
> git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git testing
> 
> I'll create a new branch *next* once this patch series is finalized. All the
> PHY driver development that depends on PHY framework can be based on this
> branch.
> 
> Did USB enumeration testing in panda and beagle after applying [1] (needed for
> non-dt)

All now applied to my usb-next branch.  Thanks for redoing this many
times and sticking with it.

greg k-h
