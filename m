From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG/PATCH 1/4] DTS: GTA04: SPI / gpiolib: work around a
 regression that unhides a broken legacy handler, which makes the gta04
 display inoperable
Date: Mon, 1 Apr 2019 09:58:02 -0700
Message-ID: <20190401165802.GI49658@atomide.com>
References: <cover.1554026842.git.hns@goldelico.com>
 <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com>
 <20190401164617.GH49658@atomide.com>
 <06C7464E-FAF2-4AA6-9FF4-629E9C97F86A@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <06C7464E-FAF2-4AA6-9FF4-629E9C97F86A@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190401 16:57]:
> > Am 01.04.2019 um 18:46 schrieb Tony Lindgren <tony@atomide.com>:
> > So what's the plan with this fix? Add this for v5.2-rc cycle,
> > then revert it later? I'd probably go directly for the proper
> > fix if possible.
> 
> Well, I learned just some minutes ago that a new patch for gpiolib
> came through 5.1-rc3 which does fix this.
> 
> It seems to check for "cs-gpios" and then disable the legacy handling.
> 
> This means that we do not need to patch the DTS at all.

OK good to hear, thanks for the update.

Regards,

Tony
