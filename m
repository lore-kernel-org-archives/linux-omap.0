From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2PLUS: Remove references to AM3517-EVM
 since it's in DT
Date: Mon, 24 Sep 2018 15:06:30 -0700
Message-ID: <20180924220630.GI5662@atomide.com>
References: <20180923153718.15095-1-aford173@gmail.com>
 <20180923153718.15095-3-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180923153718.15095-3-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [180923 08:41]:
> Since the audio codecs used on the AM3517-EVM are now available
> in device tree, and the audio driver wasn't really being used
> anyway, this patch removes the remaining AM3517 legacy board
> options and sound soc drivers.

Mark do you want to pick this one? If so:

Acked-by: Tony Lindgren <tony@atomide.com>

Maybe update the subject line according too.

Regards,

Tony
