From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am57xx: Disable voltage switching for SD card
Date: Thu, 27 Jun 2019 04:39:04 -0700
Message-ID: <20190627113904.GI5447@atomide.com>
References: <20190619102454.5097-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190619102454.5097-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, robertcnelson@gmail.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190619 03:25]:
> If UHS speed modes are enabled, a compatible SD card switches down to
> 1.8V during enumeration. If after this a software reboot/crash takes
> place and on-chip ROM tries to enumerate the SD card, the difference in
> IO voltages (host @ 3.3V and card @ 1.8V) may end up damaging the card.
> 
> The fix for this is to have support for power cycling the card in
> hardware (with a PORz/soft-reset line causing a power cycle of the
> card). Because the beaglebone X15 (rev A,B and C), am57xx-idks and
> am57xx-evms don't have this capability, disable voltage switching for
> these boards.
> 
> The major effect of this is that the maximum supported speed
> mode is now high speed(50 MHz) down from SDR104(200 MHz).
> 
> commit 88a748419b84 ("ARM: dts: am57xx-idk: Remove support for voltage
> switching for SD card") did this only for idk boards. Do it for all
> affected boards.

Thanks applying into fixes.

Regards,

Tony
