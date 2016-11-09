From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/3] ARM: dts: omap5 uevm: add LEDs, USR1 button and
 EEPROM
Date: Wed, 9 Nov 2016 15:03:26 -0700
Message-ID: <20161109220325.GG2428@atomide.com>
References: <cover.1475126737.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1475126737.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [160928 22:26]:
> Changes V3:
> * remove unit addresses from LEDs [Rob Herring]
> 
> 2016-09-28 20:08:23: Changes V2:
> * fixed subject of patches to correctly tell that it is for omap5 evm
> * changed default triggers a little to create a nicer default pattern
> 
> 2016-09-27 07:26:14: These patches configure
> * the EEPROM
> * the LEDs (with some default triggers)
> * the USR1 gpio button
> for the OMAP5 UEVM board.
> 
> H. Nikolaus Schaller (3):
>   ARM: dts: omap5 uevm: add EEPROM
>   ARM: dts: omap5 uevm: add LEDs
>   ARM: dts: omap5 uevm: add USR1 button

Applying all into omap-for-v4.10/dt thanks.

Tony
