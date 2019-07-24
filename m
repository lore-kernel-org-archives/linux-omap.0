From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblue: Use of
 am335x-osd335x-common.dtsi
Date: Wed, 24 Jul 2019 16:41:20 -0500
Message-ID: <978ea35c-793a-fd7b-ecd3-93534fdf4812@lechnology.com>
References: <20190724212616.17945-1-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724212616.17945-1-david@lechnology.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 7/24/19 4:26 PM, David Lechner wrote:
> This makes use of the am335x-osd335x-common.dtsi file that contains the
> common device tree components for Octavo Systems AM335x System-in-
> Package that is used on the BeagleBone Blue.
> 
> This has two minor side-effects:
> 1. pinmux_i2c0_pins is renamed to pinmux-i2c0-pins
> 2. the 1MHz cpufreq operating point is enabled

Oops. should be 1000MHz
