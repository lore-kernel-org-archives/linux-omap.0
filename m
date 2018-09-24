From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: DTS: AM3517-EVM: Add support for UI board and
 Audio
Date: Mon, 24 Sep 2018 15:04:52 -0700
Message-ID: <20180924220452.GH5662@atomide.com>
References: <20180923153718.15095-1-aford173@gmail.com>
 <20180923153718.15095-2-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180923153718.15095-2-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [180923 15:41]:
> The full AM3517-EVM shipped with an add-on board which contained
> two Audio codecs, a GPIO expander with a variety of buttons, and
> some other features.  This patch enables these portions of the UI
> board because they don't directly conflict with existing features.

Applying this one into omap-for-v4.20/dt thanks.

Tony
