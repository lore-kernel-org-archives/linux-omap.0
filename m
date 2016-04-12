From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] ARM: dts: Enable N950 keyboard sleep leds by default
Date: Tue, 12 Apr 2016 14:02:27 -0700
Message-ID: <20160412210227.GZ5995@atomide.com>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
 <1457827580-16919-5-git-send-email-sre@kernel.org>
 <20160329105128.GA30184@amd>
 <20160329145209.GB31858@earth>
 <20160330193520.GY9329@atomide.com>
 <20160401124523.GB10776@amd>
 <20160401183221.GN9329@atomide.com>
 <20160402064757.GA13872@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160402064757.GA13872@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [160401 23:48]:
> > Sounds like the thing to do is to just configure the I2C LED
> > controller in the dts file if we don't already have that. And
> > assuming it has a Linux driver.
> 
> I don't see what you mean here. If you want to always keep the debug
> leds on... that may be a bit confusing for the users (and Pali wants
> to keep kernel usable for mere mortals it seems).

I think to make the LEDs ignore the hardware idle lines requires
reconfiguring the I2C LED controller.

> Anyway, current solution is not too horrible (its wrong but it does
> not hurt that much), so...

Yeah further changes can be done later.

Applying the whole series to omap-for-v4.7/dt with
your ack on patches 5 - 7.

Regards,

Tony
