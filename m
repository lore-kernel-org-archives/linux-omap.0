Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394653DD520;
	Mon, 27 Jul 2026 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192945; cv=none; b=AEWr7TVvbi+dbPTCStMBZszkJh+LP/h5royuwPHLCsIEbU4yZxvXO04nml4JeC0FfH4Bbp+XeEJm7prC8F1GGuKNiz/qWhyGG5KLQAUJs1Th6eUuVmv914YxrYmymUwmpFY41eQZhMj4Ewdm86Ye5/eSCSUvlwfv67P9p/2DVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192945; c=relaxed/simple;
	bh=mEBfzjO+6yUBNYtZLAV862tOCMn8M1zcqCXfXePcipQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AzREIPMpkn8hPsskhTUy/QC3TWTylQGyQxSoPHEiItX/BpR/VIdWflBQ7SdIC8K+HozCVCpYdj/kSXvg4GLZM7zY8tqzbCUuHp7lYMx5WQ3KWRYDXd2KeWINjb4SGUFu0Oq8HlRZUxmraUEZ4Rv4DNEfpdJZ+xLOt/DCySexga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDJ2me6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDJ2me6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E141F000E9;
	Mon, 27 Jul 2026 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192944;
	bh=LkHsc9u3dSjgnXAXJktKKwHUceZdTR7+WwUbiIyWSGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gDJ2me6HhmWOkWN4rtVJWqeQY9l9Rp8sTe6a3KoMDF3K7QMQCrnbdu058XGlirvBv
	 3lsJ6YulHJDdKJGdXqv4tk21UzXKquVZwsx4TQ/5QA2OP/pOsFLd654ISAV2cJcTmM
	 fnnidgICSXKOTjbSxEhlfGRQf8X5MbtWQ4g/tsD3p5mY7ZD18ESVpxj+n1Zi/M6B84
	 KT29SgdPDfnxO1eoRfMTziA3rIbYTQSNZrm/ciVbPqumyXJHD45MdcugapH1LZLSOe
	 UZv/ueECU8v2tswJgb6FxVlCu+inHTTxX1rlflkeAm8Yrkpf2Wc1mZI70yg/+pMTws
	 p+YI4cOg/HG0A==
From: Mark Brown <broonie@kernel.org>
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
References: <20260724233432.31325-1-dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: ti: omap-twl4030: drop support for platform
 data
Message-Id: <178517465866.50339.8625271301809233192.b4-ty@b4>
Date: Mon, 27 Jul 2026 18:50:58 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mEBfzjO+6yUBNYtZLAV862tOCMn8M1zcqCXfXePcipQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqZ+HtUwHFfbDqCXiRmIV2XY8lXLjofx8ZlNsSe
 dcK4xdBGreJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamfh7QAKCRAk1otyXVSH
 0IB2B/9pv6LG1H+N0oT97FYHBlIU+c2LfFwqEvLAPJtBIX8sPhr/6IrQu0wXqf4qXIxJBNEs+Q/
 Aqk1kFZN8gGdSPU+NNta/mzHiCdNIew3Ksz9dzcrQnIY4cCR9HACdFj9/v06HuUZY9sIYUsQuj8
 XEWeGwM6cdp57iShZj1yHdAjqJyvo4xP7Lrt2Yqy8I8WFhbpLOjsaygs3PndV8QrG4zwu8osQ7E
 gTMKXfZ9kAbKgqVfAhDKnIMFKizn2cfp4UrwxqWdKpvhBf5ZFMRRM4wl9ha2/E1HTUtfKD4+g7e
 YsjkcC9/4v/rjSN3R8W5LD0s6kufNUUGBqdm02DeWlPdKXON
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 24 Jul 2026 16:34:29 -0700, Dmitry Torokhov wrote:
> ASoC: ti: omap-twl4030: drop support for platform data

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/2] ASoC: ti: omap-twl4030: drop support for platform data
      https://git.kernel.org/broonie/sound/c/0f97c75d15c3
[2/2] ASoC: ti: omap-twl4030: use per-device instance of headset jack gpio
      https://git.kernel.org/broonie/sound/c/a9b7250a2f8b

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

