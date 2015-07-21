From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: Add support for phyCORE-AM335x SoM
Date: Tue, 21 Jul 2015 03:59:31 -0700
Message-ID: <20150721105930.GB17550@atomide.com>
References: <1437035449-26956-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437035449-26956-1-git-send-email-t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org> [150716 01:36]:
> phyCORE-AM335x is a SoM (System on Module) containing
> a AM335x SOC. The module can be connected to different
> carrier boards.
> 
> Some hardware parts are configurable on the phyCORE-AM335x.
> So they are disabled on default in this som dtsi file.
> They will be enabled in the board dts files, when populated.
> 
> * RAM up to 1GiB
> * PMIC
> * NAND flash up to 1GiB
> * Eth PHY on SOM: 1x RMII
> * SPI NOR flash 8MiB (optional)
> * i2c RTC (optional)
> * i2c EEPROM 4kiB (optional)

Applying both into omap-for-v4.3/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
