Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6A48EBFE;
	Wed, 29 Jul 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331940; cv=none; b=GaXmNy94+Eco8Id7PCmKlju7L5Xj6JVGyr8k+Sj/xwm1ChHrJVvAcHo+deFmg5zZq4SyVBc1Gyz+HllmjRnApwo9GPARGEqR+6B/TZ/9KNWtNrsorBL5f8Y5LX5YhOUAYXj1agLQQLAqqTiXTN2pvH9bUCqaon+91Mncj3KkvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331940; c=relaxed/simple;
	bh=YKrR83CFG6tpDZzJZX//aN/Zfs0MXfWJ4eOlHzUUvns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ljEYbMa/UwJXlNwpi9wUGM41Otox3Jcn4Qe0vf5SxoinggjuYhrbwmk/Qj1lTVhqA+k5UbPq4SPY8Jy7F/+w8qOUwxd7tTvVfAEZzfHu/PxKf9BwaKLzfBRAEuYz6rpMaakaen7YUFAcRwqGQu0uhaafr9kxpzP3ipAtiS2FRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOLacvde; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOLacvde"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A83B1F00A3D;
	Wed, 29 Jul 2026 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785331928;
	bh=IGdHavip7JxTDusAB/Uo5MwL+ojTPGtIkgArw9SW8jA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fOLacvdeXoBiLnd713GgJ1a8E9pfgEDhBjn0WV3kK8PhmUqwdy44q0/2M2ZxjVAr9
	 HNI44ziVQTTyXbthej9wA3GtrrUbzqoQPAfZqhQkzlsl//nxXs+kitUH7tX3wSHip8
	 qvJnNGNVx+rdwFzoKMRNa7xDe6aU8MdSoEntjvmUHSKjbfrjB3vtXiJ1wUqV6lGiXx
	 sSOIX/GZsHD82EiKSvwRMIja1rk85szzK0GUHfCUSgi/j1sqRbRAV2Hz4Q84t/N3HJ
	 vLg5xgZ+2oF1WRsQBIrtrmECbgE8VRt2aEQ8Q34fhIz0kIqSbVlo2tcOvCDyHYFBLQ
	 /gsDiJi9iwrGg==
From: Mark Brown <broonie@kernel.org>
To: Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 linux-omap@vger.kernel.org, phucduc.bui@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20260716103911.77652-1-phucduc.bui@gmail.com>
References: <20260716103911.77652-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH v3 00/10] ASoC: ti: Improve probe error handling
Message-Id: <178526435380.318884.10754971669872535900.b4-ty@b4>
Date: Tue, 28 Jul 2026 19:45:53 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YKrR83CFG6tpDZzJZX//aN/Zfs0MXfWJ4eOlHzUUvns=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqagDVkcJzDko4vltVv2zuCu2AzOPU6N+4PLPrv
 eoA5UVoPfCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamoA1QAKCRAk1otyXVSH
 0JYkB/4v0yyDJwIm5CfrV9Y/33a/be4t1d560R3mnbQqxSE9HAhQQ0fYj8sCXu7iOK9K+3Tmitl
 OiOO9oBc0Th9RGHOhN0yFSy1ibCAlm2+23unnXAXlMiZN0WgmVFvtschanixIQbyiynHHTV7OgO
 pGYtIxInTHxe+PE1hOF2Nn2dyrK5EFZp0ruOQybJnL5fQ7UKbr8nl59YpR5BaKufdGmvibs9F05
 c3OUwq1BBEpEs/eIco/SH7SvBmgslvmdcobaa+Gq6jmRWfq85BN370SBoEEPjf/8ReRPtRl98+d
 5Z022YbxaLqmYU4bE4Zn8NyElY5LlADgHTI5fWWwQH0rdgq0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 16 Jul 2026 17:39:01 +0700, phucduc.bui@gmail.com wrote:
> ASoC: ti: Improve probe error handling
> 
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> This series cleans up probe error handling across several TI ASoC
> drivers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[01/10] ASoC: ti: ams-delta: Use dev_err_probe() for error handling
        https://git.kernel.org/broonie/sound/c/5413fb3ba54c
[02/10] ASoC: ti: davinci-evm: Use dev_err_probe() for error handling
        https://git.kernel.org/broonie/sound/c/7ae5829ab0f2
[03/10] ASoC: ti: j721e-evm: Return the original error from card name parsing
        https://git.kernel.org/broonie/sound/c/1a1145d1b249
[04/10] ASoC: ti: omap-abe-twl6040: Preserve error code and drop redundant log
        https://git.kernel.org/broonie/sound/c/e0b2ab952d19
[05/10] ASoC: ti: omap-abe-twl6040: Use dev_err_probe() for error handling
        https://git.kernel.org/broonie/sound/c/3e8b2361c651
[06/10] ASoC: ti: omap-dmic: Use dev_err_probe() for error handling
        https://git.kernel.org/broonie/sound/c/fa1d248f1638
[07/10] ASoC: ti: omap-hdmi: Use dev_err_probe() for error handling
        https://git.kernel.org/broonie/sound/c/492a53506ab2
[08/10] ASoC: ti: omap-twl4030: Return the original error code
        https://git.kernel.org/broonie/sound/c/23c89b7d91cc
[09/10] ASoC: ti: omap-twl4030: Use dev_err_probe() for error handling
        https://git.kernel.org/broonie/sound/c/31d9b5bc1abb
[10/10] ASoC: ti: rx51: Use dev_err_probe() for error handling
        https://git.kernel.org/broonie/sound/c/924448b41b65

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

