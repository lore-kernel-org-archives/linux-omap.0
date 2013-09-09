From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv4] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
Date: Mon, 9 Sep 2013 07:18:48 -0700
Message-ID: <20130909141848.GA24187@kroah.com>
References: <1378734350-30479-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1378734350-30479-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, olof@lixom.net, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 09, 2013 at 03:45:50PM +0200, Koen Kooi wrote:
> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
> so create a common dtsi both can use.
> 
> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver 
> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
> of 1.8. 
> 
> MMC support for AM335x still isn't in, so only the LDO change has been added.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> Tested-by: Tom Rini <trini@ti.com>
> Tested-by: Matt Porter <matt.porter@linaro.org>
> ---

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
