From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: am335x-boneblue: Use of
 am335x-osd335x-common.dtsi
Date: Tue, 13 Aug 2019 04:50:32 -0700
Message-ID: <20190813115032.GU52127@atomide.com>
References: <20190807200934.25173-1-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190807200934.25173-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>
List-Id: linux-omap@vger.kernel.org

* David Lechner <david@lechnology.com> [190807 13:10]:
> This makes use of the am335x-osd335x-common.dtsi file that contains the
> common device tree components for Octavo Systems AM335x System-in-
> Package that is used on the BeagleBone Blue.
> 
> This has two minor side-effects:
> 1. pinmux_i2c0_pins is renamed to pinmux-i2c0-pins
> 2. the 1000MHz cpufreq operating point is enabled

Applying into omap-for-v5.4/dt thanks.

Tony
