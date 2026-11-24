Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505234;
	b=I188pXppVxRko1l69/2ajfnl/8ZF9h+7UAqGXxdt4DbJfUxDZJ5wwivTlzBmCU+mTp63
	 Lgrwha3y9LWr2vewPtMf40rfU0OUb4k+qoqp99829zTnHYfTAgR5V6LYKeKyMSbImkg3s
	 3I8CmW+gCmZOYKuFjTl37g3XJAGStJcxtHl3Dv6IuG43z0VfzjLlzgiMm+0aDxPUuQfPe
	 trxQlwSaUbvM5/fGnKIRGvlmaL0Ojk+vamX7khIkFLZXn7xmbrGCDsK6MM+81sixwtzAh
	 BAW8ha3uMKTmzv9FLMU3cvxKRssDjAf8I2ujcjexixJdVDYy7++ypfGa2AS8oYcoi+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505234;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=eDYozsj598odlb+SnLLqcXlLRBVSMhy9K+sq48gd9yg=;
	b=Vy7XOUUn+41IgZfBE6XFXYsoD/4209EW4gljWOufphgQRW2PsyGd3BxBYkmMB/nJNZ8q
	 xDi6NebSBQ2w2GfcjqEGqLEc3dFnmAIgxQPlevdobOLEiF0H+MYSYuPqrIxy7amG27qyL
	 i+kItvTn5qwP4DlNi7VNG9X6dyoE/xIGsRjAe+ZojiFzelhZ0hiTJiIAyKxBLxNhrYPKP
	 i2hnddOF9u+hWp+p/4B864slUPsae7fXa1LKtOBaJVmi+M5zYRIVYGIt/4zQ64+1//6Ec
	 KCaTq0Vq3KaS3kmcm/US3Be41WJ/f1f+hAZMAoZ2DR29KZHcm5pNzb7yu0ZPQk8SaRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BiyIEwwm;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=bDIxgNNy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96766606A68D;
	Tue, 24 Nov 2026 07:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96766606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=BiyIEwwm;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=bDIxgNNy
ARC-Seal: i=1; a=rsa-sha256; t=1795505165; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JCrSOqrsuSptb+/+qpGWUNszDfdPJ/Ps2oXdMuG1kQiQhcCtIwhpCPMIfPBfStCIXG
    LhVnOpmnHK9xiHgwU6pFGeEDWY1lXMBe7LcnrER/EYSWJYWICguZTOF+VZ3nJYffPnfa
    rhUm8Ix8hslGzuqOKpzMpVC8LBRcBqBmarhv7jkCdlXYKfq8cACocpgdZ6A9G40EqiJh
    Bz/t/4hjZuT7SPbMApR/gcDNY1wwmw3xN1560zqjfw/tPstv/Xf6BdOBfBuAVDV3I6D+
    IRJLBr16TWBquSCtsvceQvhXGKrG5qItdGR2rDfIPZkMJ7NU3P/7Wl0OzVO2hrLh5I44
    DftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505165;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=eDYozsj598odlb+SnLLqcXlLRBVSMhy9K+sq48gd9yg=;
    b=FizpaxOiefFt1EJljtrP6En7X37gquF5MShVlUffmKySPBVKsgEeUnbBX/4p5PA+6o
    iOiiQmAmQxJIvc4BrdvMkfxF2wFD5qR4qzLwkVgYYCupJyCjfZaMAFsb9qY0wawoHCvy
    bQRxd2c5p65YM9s+LCHa/j1B8nwKS6YUgNZr1rqbNAtwRAYIfGzyXiSFgwcH+jWGvvd/
    0B/uWd1qLs1hW4Rc+vpF5KxUety52LiDJsauFzdVUBAM/9H1Udw6AqGnUizePxUfi+ri
    RcJUmojvdQ5JN8TYx7ndIhxgVa+Xx3KIlJ4oYi+z7GduuTIB2clsY03U1DDLbUOTxvLP
    E5yw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505165;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=eDYozsj598odlb+SnLLqcXlLRBVSMhy9K+sq48gd9yg=;
    b=BiyIEwwm80E+QUs299KnikuDQJkZlEcrrD+tf4Py37bkjRHS2UPEtsjjkkTCazVc6j
    mfcJygM0u2z6wXI90LgZudBa3otI8H7zKQlxGvFD+ouLc2z5Y62f9JLM1hophQdkpGi6
    zK5gIuD3GmZNijlwlGAy0YOwpLREHr1Q4//ocbgBIlylXX89kr4SNgwEGx5yU51uYxG5
    Ff91IQlZmcf0q6mNUHkW7VZQ8OkOSAzoSGvo+wTu6tYT9Q+G55pMXq2JracMtwIrmeJS
    upx0I3hYy31eNXSz4tx3eX4QXAR6sTKZyCTnk5N5SJUG0ZGWbN/wyoP6nK4F/9m0J93L
    Kngw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505165;
    s=strato-dkim-0003; d=goldelico.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=eDYozsj598odlb+SnLLqcXlLRBVSMhy9K+sq48gd9yg=;
    b=bDIxgNNyd4V2WrofW6RajrHk2rawssJNbFEV2aKK4p8jHo7uE9s3cff4ns4NUNB94V
    CpEeitEpcinmcp9KNDBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AO7Q21H9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 08:26:02 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	letux-kernel@openphoenux.org,
	kernel@pyra-handheld.com,
	"H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 00/20] ARM: omap3: pandora: Modernize audio and backlight to use Device Tree to finally remove pdata-quirks
Date: Tue, 24 Nov 2026 08:25:40 +0100
Message-ID: <cover.1795505160.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit

PATCH V2 2026-11-24 08:26:00:
Changes in V2:
The series has been reworked and expanded from 16 to 20 patches,
addressing review feedback and issues identified during hardware testing.

Audio and power management:
===========================
* Replace the TWL4030 REGEN regulator implementation with an optional
  GPIO and a fixed regulator described in Device Tree.
* Extend the existing PCM1754 codec driver to support the PCM1773
  instead of introducing a separate codec driver.
* Add power supply and power-down GPIO support to the codec driver.
* Improve error handling, resource management and power sequencing
  in the codec and sound card drivers.
* Update the sound card and codec bindings and Device Tree nodes.

PWM and backlight:
==================
* Add optional 64-cycle frame support to the TWL4030 PWM driver.
* Add an optional enable guard period to the generic pwm-backlight
  driver to prevent the TPS61161 from inadvertently entering
  EasyScale mode.
* Adjust the Pandora PWM backlight configuration accordingly.
* Remove the obsolete CONFIG_BACKLIGHT_PANDORA option from
  omap2plus_defconfig.

Device Tree and general cleanup:
================================
* Correct and validate the affected Device Tree bindings.
* Reorder the series so that bindings and supporting drivers
  precede their Device Tree users.
* Improve commit messages and fix coding style issues.
* Clarify the original authorship and take responsibility for
  contributions previously signed off under a pseudonym.

Review feedback addressed:
==========================
* Mark Brown suggested representing TWL4030 REGEN as a GPIO rather
  than a regulator and reviewed the original standalone PCM1773
  driver, which has been replaced by extending the PCM1754 driver.
* Krzysztof Kozlowski requested corrections to the Device Tree
  bindings, proper schema validation, improved commit messages and
  clarification of the original contributor's authorship.
* Andreas Kemnade suggested handling the TPS61161 initialization
  in the backlight layer. V2 implements this through a generic
  pwm-backlight enable guard period. His comments on clock modeling
  and patch bisectability were also considered.
* Daniel Thompson provided Reviewed-by for the original removal
  of the Pandora backlight driver.
* Issues identified by Sashiko and Rob Herring's automated DT
 validation were reviewed and addressed as applicable.

Many thanks to everyone who reviewed V1.

Validation and testing:
=======================
* Based on Linux v7.4-rc4.
* All 20 patches checked with checkpatch.pl.
* Remaining checkpatch warnings and intentional deviations have
  been reviewed. In particular, ENOTSUPP must be retained in the
  GPIO set_config callback because gpiolib handles it differently
  from EOPNOTSUPP.
* dt_binding_check and dtbs_check passed for all five affected
  Device Tree bindings.
* The complete series has been successfully built and tested on
  real OpenPandora hardware.
* LCD operation, PWM backlight brightness control including
  brightness zero and power-down, and audio playback through the
  internal speakers and headset have been verified.
* Audio capture was not tested.

PATCH V1 2026-07-11 08:02:02:
This series modernizes the OpenPandora handheld support by converting the 
sound subsystem and backlight control to proper platform drivers and Device 
Tree definitions.

The primary goal is the complete removal of omap3_pandora_legacy_init() 
and the elimination of the last remaining user of machine_is_omap3_pandora().

History and Context
===================
The necessity of this cleanup was highlighted in several recent discussions:

1. Tony Lindgren noted that machine_is_omap3_pandora() checks never succeed 
   on Device Tree-booted machines, leaving the audio subsystem functionally 
   broken since the DT conversion years ago:
   https://marc.info/?l=alsa-devel&m=165632351319716&w=2

2. Ethan Nelson-Moore submitted a patch to replace the macro with DT 
   compatibility checks (accepted as commit 45efb8fbdae3 in v7.2-rc1):
   https://marc.info/?l=linux-omap&m=177841578110704&w=2

3. Sascha Hauer pointed out that the entire omap3pandora driver fundamentally 
   depended on this broken machine ID check:
   https://marc.info/?l=linux-omap&m=178048982272252&w=2

Design Choices and Implementation
=================================
Based on these discussions and a long-standing and working out-of-tree solution,
we initially attempted a migration to generic frameworks like simple-audio-card 
or audio-graph-card. However, the hardware routing peculiarities of the 
OpenPandora introduced too many functional gaps. Replacing omap3pandora.c 
entirely with pure DT definitions proved unfeasible. 

Therefore, we opted to base a new proposal on the out-of-tree rewrite of
the old-style sound board file kernel driver (sound/soc/ti/omap3pandora.c)
into a proper platform driver that cleanly fetches its resources from the
Device Tree, while adding specific handling for the twl4030-regen output
and adapting the pandora device tree files.

Series Structure
================
* Patches 01–06 (Preparation): Move highly specific legacy code to its proper 
  infrastructure (TWL4030 regulator regeneration and codec handling).
* Patch 07-08 (New Driver): Introduce a dedicated platform driver for the 
  PCM1773 audio DAC.
* Patches 09-14 (Audio Core): Rewrite the omap3pandora ASoC fabric driver 
  and update the respective Device Tree nodes.
* Patches 14–15 (Backlight): Remove the custom, legacy Pandora backlight driver,
  convert it to generic Device Tree nodes
* Patch 16: (Cleanup) safely delete the obsolete omap3_pandora_legacy_init().

Notes & Testing
===============
* Testing: This series has been tested on real OpenPandora hardware.

Credits
=======
This work is a collaborative effort by multiple authors over several years:
* Grond <grond66@riseup.net>
* Stefan Leichter <sle85276@gmx.de>
* H. Nikolaus Schaller <hns@goldelico.com>


H. Nikolaus Schaller (17):
  dt-bindings: gpio: twl4030: Document REGEN GPIO
  gpio: twl4030: Support REGEN GPIO
  ASoC: twl4030: Allow APLL rate selection through set_sysclk()
  dt-bindings: sound: pcm1754: Describe PCM1773
  ASoC: codecs: pcm1754: Add PCM1773 support
  dt-bindings: sound: Document OpenPandora sound card
  dt-bindings: mfd: twl4030: Document 64-cycle PWM
  pwm: twl: Support 64-cycle PWM frame
  dt-bindings: backlight: pwm: Document enable guard
  backlight: pwm: Support enable guard period
  drm/panel: td043mtea1: Attach DT backlight
  ARM: dts: omap3pandora: Disable unused DMA channels
  ARM: dts: omap3-pandora: Model LCD power enable dependencies
  ARM: dts: omap3pandora: Describe PCM1773
  ARM: dts: omap3pandora: Switch backlight to PWM
  backlight: Remove legacy Pandora driver
  ARM: OMAP2+: Remove Pandora platform-data quirks

Stefan Leichter (3):
  ASoC: ti: omap3pandora: Convert sound card to DT
  ARM: dts: omap3pandora: Enable audio interfaces
  ARM: dts: omap3pandora: Describe sound card

 .../bindings/gpio/ti,twl4030-gpio.yaml        |   4 +
 .../leds/backlight/pwm-backlight.yaml         |  20 +
 .../devicetree/bindings/mfd/ti,twl.yaml       |   9 +
 .../sound/openpandora,omap3pandora-sound.yaml |  95 ++++
 .../devicetree/bindings/sound/ti,pcm1754.yaml |  10 +-
 .../dts/ti/omap/omap3-pandora-common.dtsi     | 123 ++++-
 arch/arm/configs/omap2plus_defconfig          |   1 -
 arch/arm/mach-omap2/pdata-quirks.c            |  23 -
 drivers/gpio/gpio-twl4030.c                   | 185 ++++++-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c  |   4 +
 drivers/pwm/pwm-twl.c                         |  37 ++
 drivers/video/backlight/Kconfig               |   7 -
 drivers/video/backlight/Makefile              |   1 -
 drivers/video/backlight/pandora_bl.c          | 159 ------
 drivers/video/backlight/pwm_bl.c              |  37 +-
 include/linux/mfd/twl.h                       |   3 +
 include/linux/mfd/twl4030-audio.h             |   3 +
 include/linux/pwm_backlight.h                 |   1 +
 sound/soc/codecs/pcm1754.c                    | 122 ++++-
 sound/soc/codecs/twl4030.c                    | 142 ++++--
 sound/soc/ti/omap3pandora.c                   | 452 ++++++++++++------
 21 files changed, 1016 insertions(+), 422 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/openpandora,omap3pandora-sound.yaml
 delete mode 100644 drivers/video/backlight/pandora_bl.c

-- 
2.56.0

