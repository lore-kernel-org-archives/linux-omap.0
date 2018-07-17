From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Date: Tue, 17 Jul 2018 01:06:00 -0700
Message-ID: <20180717080600.GF99251@atomide.com>
References: <1531810311-29915-1-git-send-email-koen@dominion.thruhere.net>
 <1531810311-29915-3-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531810311-29915-3-git-send-email-koen@dominion.thruhere.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Koen Kooi <koen@dominion.thruhere.net> [180717 06:55]:
> The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone Black,
> but with the following differences:
> 
>  * Gigabit capable PHY
>  * Extra USB hub, optional i2c control
>  * lps3331ap barometer connected over i2c
>  * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
>  * 1GiB DDR3 RAM
>  * RTL8723 Wifi/Bluetooth connected over USB

Applying into omap-for-v4.19/dt thanks

Tony
