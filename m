From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 04/10] usb: dwc3: use quirks to know if a particualr
 platform doesn't have PHY
Date: Wed, 4 Dec 2013 16:40:27 +0200
Message-ID: <20131204144027.GB21055@xps8300>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
 <1385373690-12170-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385373690-12170-5-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, balbi@ti.com
Cc: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, tony@atomide.com, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, grant.likely@linaro.org, s.nawrocki@samsung.com, galak@codeaurora.org
List-Id: linux-omap@vger.kernel.org

Hi guys,

Kishon, sorry I did not see this v3 set.

On Mon, Nov 25, 2013 at 03:31:24PM +0530, Kishon Vijay Abraham I wrote:
> There can be systems which does not have an external phy, so get
> phy only if no quirks are added that indicates the PHY is not present.
> Introduced two quirk flags to indicate the *absence* of usb2 phy and
> usb3 phy. Also remove checking if return value is -ENXIO since it's now
> changed to always enable usb_phy layer.

Can you guys explain why is something like this needed? Like with
clocks and gpios, the device drivers shouldn't need to care any more
if the platform has the phys or not. -ENODEV tells you your platform
does not have them, so go ahead and continue when getting the phy.

I just tested removing the phy registering from dwc3-pci.c and all I
had to do was to add IS_ERR(<phy>) checks where the old usb phys were
used and everything worked fine?

What am I missing?

Br,

-- 
heikki
