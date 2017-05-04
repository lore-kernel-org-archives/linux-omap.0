From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/2] Input: pwm-vibra: new driver
Date: Wed, 3 May 2017 17:39:52 -0700
Message-ID: <20170504003952.GN3780@atomide.com>
References: <20170503111128.15385-1-sebastian.reichel@collabora.co.uk>
 <20170503111128.15385-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170503111128.15385-2-sebastian.reichel@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170503 04:14]:
> Provide a simple driver for PWM controllable vibrators. It
> will be used by Motorola Droid 4.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
> Changes since PATCHv1:
>  - move driver removal code to input->close function
>  - mark PM functions __maybe_unused and drop #ifdef CONFIG_PM_SLEEP
>  - remove duplicate NULL check for vibrator in probe function
>  - cancel work in suspend function

I'm getting this if CONFIG_INPUT_FF_MEMLESS is not selected:

ERROR: "input_ff_create_memless" [drivers/input/misc/pwm-vibra.ko] undefined!

Other than that works for me with your test app after
modprobe of pwm-omap-dmtimer and ff_memless:

Tested-by: Tony Lindgren <tony@atomide.com>
