Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533201;
	b=X3Lvcfh+UbCrJhWN77857zXfqqMjrUHc1PH1IWirQSChnMjMnC8SgYp5ng/H3a5+27iW
	 egFlcl2eeiDhDlITTHXbZIJG5XICgjewIa2uwAdvTgxNvNXRSRoJelonLYEY/7ouU9n/y
	 88gfUPahrYWsvf3vv0/RIqGY9CU2V5Or3dnL8+zVNIC7lyozqet0ae+YYXDUFDpcFy2Ff
	 IKrNdia+l55I9FTswTkE4JLbnS34amQbeLIsRSJ94J/Ec7BBI2G3VbPxaMmsTPHY2ucaP
	 782BrPl3mYyR5f+wnymxaYNtxxqYnAoRbg5ihBtIRQbo0bcogpZ87IaXFrgwzYZpYzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533201;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=1RAyfKzTUoNGYA0NO90ipE3cGbzZg8HPabSURud3e60=;
	b=06NjzKBmi3cyythXzrrObnp4vU4H5fidCHH+Dry1MKHBJv24FMjQIDfQpQ/sXFjhX9DL
	 WjcLRYmKxLswZ3rAzeB1P7W1iwRbsj2GODm+wWpQjv0PxwcJjrRiCRzrVVocTO2H2fn85
	 4rjVEQSaqM9Vl4Syl2OZ8hRKq7wyUr/zI9Gw/578LEYu1l6kZ2d+I7caha0GOtTPPrnMj
	 W3fQwowpbYaVbluoCBNcU7NcxZRc9vkxAtPVa856KuN5YKrsRKPXf7pSsOYppctY1V9BU
	 vHwJGirzEQmcXTMp0GdWjUWMAC6CH5XTS19fB2Ao2eG3EYeoB3GCWZp9tGV6tz1fovQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XX1V7NUD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3D606A32E;
	Tue, 24 Nov 2026 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XX1V7NUD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396E81F0089E;
	Tue, 24 Nov 2026 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795533200;
	bh=1RAyfKzTUoNGYA0NO90ipE3cGbzZg8HPabSURud3e60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XX1V7NUD8JeYCW7LQvOcfIluFiPHGc8HY1ikXgQzknHbPRB2wT4j8g6d0h1xeYuRb
	 056kxfrXi3LapGzGowR3eOlcjMmyibd2Bk6EmvwmsXvLHf2QsTSI3Hf32UPcG1+Jt9
	 kWftxGudK+EigdNC+HdJEIGeBJx0crQO63rSGr+ENHSMWoAh0SjXc+7ktHqrtbPk46
	 Rorbt7jht0kTwBiLc6rMoNIEdk1EOvHEK/J5DNKePLWftjxHwzuuNAy7E5rnVWiYN3
	 V2jS+rNRQ+MElmhywWl+4vbMNLJZy2KgJfSDoeqoscdJ8aB4+JYEqIUyfeR1VvS29v
	 7lLMQW9Md+8Sw==
Date: Tue, 24 Nov 2026 09:13:18 -0600
From: Rob Herring <robh@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Helge Deller <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
	letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v2 00/20] ARM: omap3: pandora: Modernize audio and
 backlight to use Device Tree to finally remove pdata-quirks
Message-ID: <20261124151318.GA536798-robh@kernel.org>
References: <cover.1795505160.git.hns@goldelico.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1795505160.git.hns@goldelico.com>

On Tue, Nov 24, 2026 at 08:25:40AM +0100, H. Nikolaus Schaller wrote:
> PATCH V2 2026-11-24 08:26:00:
> Changes in V2:
> The series has been reworked and expanded from 16 to 20 patches,
> addressing review feedback and issues identified during hardware testing.
> 
> Audio and power management:
> ===========================
> * Replace the TWL4030 REGEN regulator implementation with an optional
>   GPIO and a fixed regulator described in Device Tree.
> * Extend the existing PCM1754 codec driver to support the PCM1773
>   instead of introducing a separate codec driver.
> * Add power supply and power-down GPIO support to the codec driver.
> * Improve error handling, resource management and power sequencing
>   in the codec and sound card drivers.
> * Update the sound card and codec bindings and Device Tree nodes.
> 
> PWM and backlight:
> ==================
> * Add optional 64-cycle frame support to the TWL4030 PWM driver.
> * Add an optional enable guard period to the generic pwm-backlight
>   driver to prevent the TPS61161 from inadvertently entering
>   EasyScale mode.
> * Adjust the Pandora PWM backlight configuration accordingly.
> * Remove the obsolete CONFIG_BACKLIGHT_PANDORA option from
>   omap2plus_defconfig.
> 
> Device Tree and general cleanup:
> ================================
> * Correct and validate the affected Device Tree bindings.
> * Reorder the series so that bindings and supporting drivers
>   precede their Device Tree users.
> * Improve commit messages and fix coding style issues.
> * Clarify the original authorship and take responsibility for
>   contributions previously signed off under a pseudonym.
> 
> Review feedback addressed:
> ==========================
> * Mark Brown suggested representing TWL4030 REGEN as a GPIO rather
>   than a regulator and reviewed the original standalone PCM1773
>   driver, which has been replaced by extending the PCM1754 driver.
> * Krzysztof Kozlowski requested corrections to the Device Tree
>   bindings, proper schema validation, improved commit messages and
>   clarification of the original contributor's authorship.
> * Andreas Kemnade suggested handling the TPS61161 initialization
>   in the backlight layer. V2 implements this through a generic
>   pwm-backlight enable guard period. His comments on clock modeling
>   and patch bisectability were also considered.
> * Daniel Thompson provided Reviewed-by for the original removal
>   of the Pandora backlight driver.
> * Issues identified by Sashiko and Rob Herring's automated DT
>  validation were reviewed and addressed as applicable.
> 
> Many thanks to everyone who reviewed V1.
> 
> Validation and testing:
> =======================
> * Based on Linux v7.4-rc4.
> * All 20 patches checked with checkpatch.pl.
> * Remaining checkpatch warnings and intentional deviations have
>   been reviewed. In particular, ENOTSUPP must be retained in the
>   GPIO set_config callback because gpiolib handles it differently
>   from EOPNOTSUPP.
> * dt_binding_check and dtbs_check passed for all five affected
>   Device Tree bindings.
> * The complete series has been successfully built and tested on
>   real OpenPandora hardware.
> * LCD operation, PWM backlight brightness control including
>   brightness zero and power-down, and audio playback through the
>   internal speakers and headset have been verified.
> * Audio capture was not tested.
> 
> PATCH V1 2026-07-11 08:02:02:
> This series modernizes the OpenPandora handheld support by converting the 
> sound subsystem and backlight control to proper platform drivers and Device 
> Tree definitions.
> 
> The primary goal is the complete removal of omap3_pandora_legacy_init() 
> and the elimination of the last remaining user of machine_is_omap3_pandora().
> 
> History and Context
> ===================
> The necessity of this cleanup was highlighted in several recent discussions:
> 
> 1. Tony Lindgren noted that machine_is_omap3_pandora() checks never succeed 
>    on Device Tree-booted machines, leaving the audio subsystem functionally 
>    broken since the DT conversion years ago:
>    https://marc.info/?l=alsa-devel&m=165632351319716&w=2
> 
> 2. Ethan Nelson-Moore submitted a patch to replace the macro with DT 
>    compatibility checks (accepted as commit 45efb8fbdae3 in v7.2-rc1):
>    https://marc.info/?l=linux-omap&m=177841578110704&w=2
> 
> 3. Sascha Hauer pointed out that the entire omap3pandora driver fundamentally 
>    depended on this broken machine ID check:
>    https://marc.info/?l=linux-omap&m=178048982272252&w=2
> 
> Design Choices and Implementation
> =================================
> Based on these discussions and a long-standing and working out-of-tree solution,
> we initially attempted a migration to generic frameworks like simple-audio-card 
> or audio-graph-card. However, the hardware routing peculiarities of the 
> OpenPandora introduced too many functional gaps. Replacing omap3pandora.c 
> entirely with pure DT definitions proved unfeasible. 
> 
> Therefore, we opted to base a new proposal on the out-of-tree rewrite of
> the old-style sound board file kernel driver (sound/soc/ti/omap3pandora.c)
> into a proper platform driver that cleanly fetches its resources from the
> Device Tree, while adding specific handling for the twl4030-regen output
> and adapting the pandora device tree files.
> 
> Series Structure
> ================
> * Patches 01–06 (Preparation): Move highly specific legacy code to its proper 
>   infrastructure (TWL4030 regulator regeneration and codec handling).
> * Patch 07-08 (New Driver): Introduce a dedicated platform driver for the 
>   PCM1773 audio DAC.
> * Patches 09-14 (Audio Core): Rewrite the omap3pandora ASoC fabric driver 
>   and update the respective Device Tree nodes.
> * Patches 14–15 (Backlight): Remove the custom, legacy Pandora backlight driver,
>   convert it to generic Device Tree nodes
> * Patch 16: (Cleanup) safely delete the obsolete omap3_pandora_legacy_init().
> 
> Notes & Testing
> ===============
> * Testing: This series has been tested on real OpenPandora hardware.
> 
> Credits
> =======
> This work is a collaborative effort by multiple authors over several years:
> * Grond <grond66@riseup.net>
> * Stefan Leichter <sle85276@gmx.de>
> * H. Nikolaus Schaller <hns@goldelico.com>
> 
> 
> H. Nikolaus Schaller (17):
>   dt-bindings: gpio: twl4030: Document REGEN GPIO
>   gpio: twl4030: Support REGEN GPIO
>   ASoC: twl4030: Allow APLL rate selection through set_sysclk()
>   dt-bindings: sound: pcm1754: Describe PCM1773
>   ASoC: codecs: pcm1754: Add PCM1773 support
>   dt-bindings: sound: Document OpenPandora sound card
>   dt-bindings: mfd: twl4030: Document 64-cycle PWM
>   pwm: twl: Support 64-cycle PWM frame
>   dt-bindings: backlight: pwm: Document enable guard
>   backlight: pwm: Support enable guard period
>   drm/panel: td043mtea1: Attach DT backlight
>   ARM: dts: omap3pandora: Disable unused DMA channels
>   ARM: dts: omap3-pandora: Model LCD power enable dependencies
>   ARM: dts: omap3pandora: Describe PCM1773
>   ARM: dts: omap3pandora: Switch backlight to PWM
>   backlight: Remove legacy Pandora driver
>   ARM: OMAP2+: Remove Pandora platform-data quirks
> 
> Stefan Leichter (3):
>   ASoC: ti: omap3pandora: Convert sound card to DT
>   ARM: dts: omap3pandora: Enable audio interfaces
>   ARM: dts: omap3pandora: Describe sound card

Which of the 7 maintainers do you expect to take this series? Surely 
this can be broken up into smaller series?

Rob
