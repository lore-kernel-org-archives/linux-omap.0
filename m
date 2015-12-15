From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/9] phy: use syscon framework APIs to set ctrl mod reg
Date: Tue, 15 Dec 2015 11:56:34 +0100
Message-ID: <725110094.6UkMkcy8u7@wuerfel>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450170968-11282-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rogerq@ti.com, nsekhar@ti.com, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, tony@atomide.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 15 December 2015 14:45:59 Kishon Vijay Abraham I wrote:
> This series is basically to deprecate using phy-omap-control and use
> syscon APIs to program the control module registers.
> 
> Changes from v2:
> No changes.
> 
> Changes from v1:
> *) cleanup ti_pipe3_probe in multiple steps
> *) other minor cleanups
> 
> Changes from [1] in PHY patches include
> *) cleanup ti_pipe3_probe
> *) have mask, power_on and power_off values in usb_phy_data for
>    omap-usb2 phy
> 
> The patches have been pushed to
>         git://git.ti.com/linux-phy/linux-phy.git syscon
> 
> [1] -> https://lkml.org/lkml/2015/6/23/189
> 
> All the testing was done both before applying the dt patches and after
> applying the dt patches (dt patches will be posted shortly).
> 

Can you explain here what the conversion is good for? Why do you
prefer the syscon mapping over a high-level driver in this case?

	Arnd
