Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.120
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795534092;
	b=IydP0PlU91y2zxssr2Mj+8eHghLDahp7Jrvpb/kL1VDPeNwW7kybs/3/V9sLZ7pL4mnB
	 bKdB1fWvN0n7W2y0SMAAc330P9053GJtf39lS8pSO8DgYRrBxVALjcKZAFXR4krMVsrJ5
	 ueO5S6I28tbbOmWZy7rKX/wh6sRpEDmHmWJfEXJu04Y7SeYDaBETHqQQG4h8GdCajHpu1
	 RjBj22Vzx66i3jdiBnQJZm+ge8Gv1Hj1p5ly6tlwbwJt0X7UBZ9N1D+Cxfo7MAzXEU7Zk
	 R1HY7LYq9+9uWUJHSa4h9tJtHnlNWQS1eLPH0RmBqtzJKWu6koDiSjMXApY5qucoUgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534092;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=Do5FkKgMlCI/D8/8uPVacdPZ+m4QTTZgla0npUPWih8=;
	b=vp929ZQ9AJPcCZjMx1LtkTH4vgOnvvtT4CahG3rLMmJlmTCT5ZCX7UBDPMcV6gw9vioW
	 Wz8hOOH8Z/gK/gyie7xPwoHwNPNhXjrxAyyh1JxKhLeIx6FkZU4WO8fEgECWA/WT6Ck3n
	 2YXWobhqrdd/FSa/iWYvRrJkweKUr9UFi/+XiyBgJwf3vWe7nuq+H1Z+wSRvBlQTnE+0S
	 9WR06Ezg5yhWBAvJHKOB4y1SuxdnAVMmmmbpKXqBLFlzHt1SvsY541cKyTCHUqq13wJcY
	 VNoQp6C2sM1ueOQoePMv0RyUthkU47aiLdy8ZbeXl5ifPO6R36Xb//dwOE4TKmvrRkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=WHotxxso;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=PpFLp6ZM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.120
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB0606A334;
	Tue, 24 Nov 2026 15:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DBB0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=WHotxxso;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=PpFLp6ZM
ARC-Seal: i=1; a=rsa-sha256; t=1795534069; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZOdacTezD0/O1W8pWgGGy3eS+6bUkGPBr3WXwIkf/Uo3ue55cxbtyUnn0eAB5jFYW8
    4m7kfhwGw/tPfp6BTHByjdH4SzMgyMXJ4QP/eLhBM8g1mSQLOVBwEeOoWWiTZWcd6XPj
    qm9qD9E56JyE5v4mUHvuTqh6hONosle/8fRe8YrIxADLZhaB/i3ouJjAN5dQ6K+y+93u
    NiOeIRpLldwX5q0Nql4uhWNeOX9nnZMTp3b0Rb+sMuprOD2ic9HjmtSPqWbrHO0Wi55d
    ioPA+P0KDLg/EAQME5rNFLtRiVyVNsaAv32eq9x4PeMajpbUPhT9FEaa7zP4rlfUHdmo
    kn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795534069;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Do5FkKgMlCI/D8/8uPVacdPZ+m4QTTZgla0npUPWih8=;
    b=DzOJdFExQ63HcAPaB5bp+F6rlFv20cAjKPGXiTfD3ARPuLTFO8jxpFwlSJZaWJIVS6
    m3/aVAzoMGk+cb/s4DRe2uQXAHAi7sV81QuhX5dsk82IWIxkiD8ntWoAHWdOfJmLX99I
    vO3aF0X8VF5A5zzs/MwPSIM9ZfYiiInqOyvh8+TZAuEz9vZbLnoPQ3niI0lkhQ10ZYG3
    9aTKQ0xZzJIL1LNVwg5LQa8dZHQjXHqCzeW1DA0BthvG+Q7XqOVTVUgofJjE/GJuVUIv
    nvhWN931wYMWxqUA8dqBMPOpBMaFwUe1zbDOs9oV0ybZsfXQ71Vz0oaZCrP2qvzi7MPT
    KtDA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795534069;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Do5FkKgMlCI/D8/8uPVacdPZ+m4QTTZgla0npUPWih8=;
    b=WHotxxso2lz+TYmIbQErxcF/C0jaH5fk+rAzl09i1EJ6wcRKkm6Rp70aAoaN6b6nji
    UdyCX+9DHv4snG435rBPWmHUTzNVtgQB3lLKwO7AezmXNY0Jv7KQlDh6+m4Xo3du70js
    20jBe/Q2Ry0MDGVPYiOwowvnxZnxSxlbf9Mqohd3eWcb4SXJQH9qAWcKzU2jT7fZE9F3
    qrHZtuWxBLw4/CTqb2mfzlQNR6HktXKQW8oFO4XEldybnDjjsiJMMRWuXaqm7KwftVKf
    IRzlHlSoj2LbePLwzmHToIsZj3yGACdQ/Fd/dJXa8kf9J1hM2nB5RJpIU90YoD0YxRcu
    lOHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795534069;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Do5FkKgMlCI/D8/8uPVacdPZ+m4QTTZgla0npUPWih8=;
    b=PpFLp6ZMiP3xDVaWjY4phl3aiPj4zX8gQ/xc9v/XvwYLJ173GZ65l0e91P3FhNaxTc
    sdF6rCGB33CQHIoNxyCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVWUgMvoVkTTR2P7jtjQyY2AeEP/F"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22AOFRl3rJ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 16:27:47 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.11\))
Subject: Re: [PATCH v2 00/20] ARM: omap3: pandora: Modernize audio and
 backlight to use Device Tree to finally remove pdata-quirks
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261124151318.GA536798-robh@kernel.org>
Date: Tue, 24 Nov 2026 16:27:16 +0100
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
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
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
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
 kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DCFB59E-E5EA-4470-997E-EAA4ED35D906@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
 <20261124151318.GA536798-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.11)



> Am 24.11.2026 um 16:13 schrieb Rob Herring <robh@kernel.org>:
>=20
> On Tue, Nov 24, 2026 at 08:25:40AM +0100, H. Nikolaus Schaller wrote:
>> PATCH V2 2026-11-24 08:26:00:
>> Changes in V2:
>> The series has been reworked and expanded from 16 to 20 patches,
>> addressing review feedback and issues identified during hardware =
testing.
>>=20
>> Audio and power management:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>> * Replace the TWL4030 REGEN regulator implementation with an optional
>>  GPIO and a fixed regulator described in Device Tree.
>> * Extend the existing PCM1754 codec driver to support the PCM1773
>>  instead of introducing a separate codec driver.
>> * Add power supply and power-down GPIO support to the codec driver.
>> * Improve error handling, resource management and power sequencing
>>  in the codec and sound card drivers.
>> * Update the sound card and codec bindings and Device Tree nodes.
>>=20
>> PWM and backlight:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> * Add optional 64-cycle frame support to the TWL4030 PWM driver.
>> * Add an optional enable guard period to the generic pwm-backlight
>>  driver to prevent the TPS61161 from inadvertently entering
>>  EasyScale mode.
>> * Adjust the Pandora PWM backlight configuration accordingly.
>> * Remove the obsolete CONFIG_BACKLIGHT_PANDORA option from
>>  omap2plus_defconfig.
>>=20
>> Device Tree and general cleanup:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> * Correct and validate the affected Device Tree bindings.
>> * Reorder the series so that bindings and supporting drivers
>>  precede their Device Tree users.
>> * Improve commit messages and fix coding style issues.
>> * Clarify the original authorship and take responsibility for
>>  contributions previously signed off under a pseudonym.
>>=20
>> Review feedback addressed:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> * Mark Brown suggested representing TWL4030 REGEN as a GPIO rather
>>  than a regulator and reviewed the original standalone PCM1773
>>  driver, which has been replaced by extending the PCM1754 driver.
>> * Krzysztof Kozlowski requested corrections to the Device Tree
>>  bindings, proper schema validation, improved commit messages and
>>  clarification of the original contributor's authorship.
>> * Andreas Kemnade suggested handling the TPS61161 initialization
>>  in the backlight layer. V2 implements this through a generic
>>  pwm-backlight enable guard period. His comments on clock modeling
>>  and patch bisectability were also considered.
>> * Daniel Thompson provided Reviewed-by for the original removal
>>  of the Pandora backlight driver.
>> * Issues identified by Sashiko and Rob Herring's automated DT
>> validation were reviewed and addressed as applicable.
>>=20
>> Many thanks to everyone who reviewed V1.
>>=20
>> Validation and testing:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> * Based on Linux v7.4-rc4.
>> * All 20 patches checked with checkpatch.pl.
>> * Remaining checkpatch warnings and intentional deviations have
>>  been reviewed. In particular, ENOTSUPP must be retained in the
>>  GPIO set_config callback because gpiolib handles it differently
>>  from EOPNOTSUPP.
>> * dt_binding_check and dtbs_check passed for all five affected
>>  Device Tree bindings.
>> * The complete series has been successfully built and tested on
>>  real OpenPandora hardware.
>> * LCD operation, PWM backlight brightness control including
>>  brightness zero and power-down, and audio playback through the
>>  internal speakers and headset have been verified.
>> * Audio capture was not tested.
>>=20
>> PATCH V1 2026-07-11 08:02:02:
>> This series modernizes the OpenPandora handheld support by converting =
the=20
>> sound subsystem and backlight control to proper platform drivers and =
Device=20
>> Tree definitions.
>>=20
>> The primary goal is the complete removal of =
omap3_pandora_legacy_init()=20
>> and the elimination of the last remaining user of =
machine_is_omap3_pandora().
>>=20
>> History and Context
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> The necessity of this cleanup was highlighted in several recent =
discussions:
>>=20
>> 1. Tony Lindgren noted that machine_is_omap3_pandora() checks never =
succeed=20
>>   on Device Tree-booted machines, leaving the audio subsystem =
functionally=20
>>   broken since the DT conversion years ago:
>>   https://marc.info/?l=3Dalsa-devel&m=3D165632351319716&w=3D2
>>=20
>> 2. Ethan Nelson-Moore submitted a patch to replace the macro with DT=20=

>>   compatibility checks (accepted as commit 45efb8fbdae3 in v7.2-rc1):
>>   https://marc.info/?l=3Dlinux-omap&m=3D177841578110704&w=3D2
>>=20
>> 3. Sascha Hauer pointed out that the entire omap3pandora driver =
fundamentally=20
>>   depended on this broken machine ID check:
>>   https://marc.info/?l=3Dlinux-omap&m=3D178048982272252&w=3D2
>>=20
>> Design Choices and Implementation
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Based on these discussions and a long-standing and working =
out-of-tree solution,
>> we initially attempted a migration to generic frameworks like =
simple-audio-card=20
>> or audio-graph-card. However, the hardware routing peculiarities of =
the=20
>> OpenPandora introduced too many functional gaps. Replacing =
omap3pandora.c=20
>> entirely with pure DT definitions proved unfeasible.=20
>>=20
>> Therefore, we opted to base a new proposal on the out-of-tree rewrite =
of
>> the old-style sound board file kernel driver =
(sound/soc/ti/omap3pandora.c)
>> into a proper platform driver that cleanly fetches its resources from =
the
>> Device Tree, while adding specific handling for the twl4030-regen =
output
>> and adapting the pandora device tree files.
>>=20
>> Series Structure
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> * Patches 01=E2=80=9306 (Preparation): Move highly specific legacy =
code to its proper=20
>>  infrastructure (TWL4030 regulator regeneration and codec handling).
>> * Patch 07-08 (New Driver): Introduce a dedicated platform driver for =
the=20
>>  PCM1773 audio DAC.
>> * Patches 09-14 (Audio Core): Rewrite the omap3pandora ASoC fabric =
driver=20
>>  and update the respective Device Tree nodes.
>> * Patches 14=E2=80=9315 (Backlight): Remove the custom, legacy =
Pandora backlight driver,
>>  convert it to generic Device Tree nodes
>> * Patch 16: (Cleanup) safely delete the obsolete =
omap3_pandora_legacy_init().
>>=20
>> Notes & Testing
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> * Testing: This series has been tested on real OpenPandora hardware.
>>=20
>> Credits
>> =3D=3D=3D=3D=3D=3D=3D
>> This work is a collaborative effort by multiple authors over several =
years:
>> * Grond <grond66@riseup.net>
>> * Stefan Leichter <sle85276@gmx.de>
>> * H. Nikolaus Schaller <hns@goldelico.com>
>>=20
>>=20
>> H. Nikolaus Schaller (17):
>>  dt-bindings: gpio: twl4030: Document REGEN GPIO
>>  gpio: twl4030: Support REGEN GPIO
>>  ASoC: twl4030: Allow APLL rate selection through set_sysclk()
>>  dt-bindings: sound: pcm1754: Describe PCM1773
>>  ASoC: codecs: pcm1754: Add PCM1773 support
>>  dt-bindings: sound: Document OpenPandora sound card
>>  dt-bindings: mfd: twl4030: Document 64-cycle PWM
>>  pwm: twl: Support 64-cycle PWM frame
>>  dt-bindings: backlight: pwm: Document enable guard
>>  backlight: pwm: Support enable guard period
>>  drm/panel: td043mtea1: Attach DT backlight
>>  ARM: dts: omap3pandora: Disable unused DMA channels
>>  ARM: dts: omap3-pandora: Model LCD power enable dependencies
>>  ARM: dts: omap3pandora: Describe PCM1773
>>  ARM: dts: omap3pandora: Switch backlight to PWM
>>  backlight: Remove legacy Pandora driver
>>  ARM: OMAP2+: Remove Pandora platform-data quirks
>>=20
>> Stefan Leichter (3):
>>  ASoC: ti: omap3pandora: Convert sound card to DT
>>  ARM: dts: omap3pandora: Enable audio interfaces
>>  ARM: dts: omap3pandora: Describe sound card
>=20
> Which of the 7 maintainers do you expect to take this series?

Well, as a contributor for a specific device one is not regularily =
thinking
in maintainers work split but about a series to get a device fixed. =
Which is
obviously orthogonal.

I didn't even recognize that this involves 7 maintainers.

Maybe an extension of checkpatch (which already looks into the =
MAINTAINER
list) could help here?

> Surely=20
> this can be broken up into smaller series?

Yes it (we?) can. It is just a question how to do it and properly =
describe
the dependencies to avoid bisectability problems and avoid that the =
final
goal is lost.

I'll wait a little if there are other comments on individual patches and
then start working on the split.

BR and thanks,
Nikolaus

