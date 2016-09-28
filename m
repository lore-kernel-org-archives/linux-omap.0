From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] DT: EVM: add LEDs
Date: Tue, 27 Sep 2016 20:37:04 -0700
Message-ID: <20160928033703.erwozguik4rie3cn@atomide.com>
References: <cover.1474953969.git.hns@goldelico.com>
 <d68619a23d642eacf12fd0a3c51f19d006436cbe.1474953969.git.hns@goldelico.com>
 <20160927194904.4im7ukktg5afjmki@atomide.com>
 <21B97601-328A-41DC-84EE-AA15A6977E98@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <21B97601-328A-41DC-84EE-AA15A6977E98@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [160927 13:11]:
> > Am 27.09.2016 um 21:49 schrieb Tony Lindgren <tony@atomide.com>:
> > How about this for defaults:
> > 
> > - heartbeat for led3
> > - cpu0 for led4
> > - cpu1 for led5
> 
> Good idea. Will try.
> 
> What I don't exactly know is if these gpios based on an I2C-expander
> can handle cpu activity triggers or if they are locked up if this i2c
> processing triggers another cpu activity...

Oh right, if the GPIOs are on the i2c bus it's probably not a good
idea :) Or at least will be inaccurate if the bus can sleep.

Regards,

Tony
