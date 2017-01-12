From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: OMAP5 / DRA7: indicate that SATA port 0 is
 available.
Date: Thu, 12 Jan 2017 14:30:08 -0800
Message-ID: <20170112223007.GP2630@atomide.com>
References: <1483964535-4298-1-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483964535-4298-1-git-send-email-jjhiblot@ti.com>
Sender: stable-owner@vger.kernel.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Jean-Jacques Hiblot <jjhiblot@ti.com> [170109 04:23]:
> AHCI provides the register PORTS_IMPL to let the software know which port
> is supported. The register must be initialized by the bootloader. However
> in some cases u-boot doesn't properly initialize this value (if it is not
> compiled with SATA support for example or if the SATA initialization fails).
> The DTS entry "ports-implemented" can be used to override the value in
> PORTS_IMPL.
> Adding this entry in the dts allows us no to worry about what is done by
> the bootloader.

Adding into omap-for-v4.11/dt thanks.

Tony
