Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426883D7D60;
	Fri, 15 May 2026 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863207; cv=none; b=PcRHEly6SvlOrwAEGzMN4NGuY1TWi6HBu0ZdbLq02D4qCdlJ6ju9LtK6+v/fAN9qWWk1Rv0UUTmQDScxr/IQD0GjmqbKMGw/J1G/jYJ502VurqxgFhBfy9PQYgVqAiNkASCD1KAcgS1XpCCVJ2UzL4XF5SqyTBrq71/0aMHfeaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863207; c=relaxed/simple;
	bh=Zp1aGoaw6rYDcMxb3pplxni0XkxMFhFbSBE5zIZ74Ss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JDzRCEei5p1vBPkn8chDX4JNapc87B+a0uh5WbyU+RSl/VH2u5HyyV+Q6JX0uaKDpf8GfUPlzg1yqHiWNHP8GquE4VBAG+BMwSjXRbifyGG6VDDJlHDtqAGJt5yugQg1IfLjD+wurtMlh+c0O3p7lmXwgJkdr6JkYnibnu/oQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcM5cqPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcM5cqPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CB3C2BCB3;
	Fri, 15 May 2026 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778863206;
	bh=Zp1aGoaw6rYDcMxb3pplxni0XkxMFhFbSBE5zIZ74Ss=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hcM5cqPahAc1nKJB8OUzCGVdIlumRkc94YpWjuLlzprPeU+LY/7dodFXBUZDQNpGB
	 xoQOFROGAvuzccU3VtE2+VPceWJgU8n1ZviNPrtBOfuTS3HD+jW2j/AOqY/EwOnizL
	 B7m4YV0fjkueu1j9VjiLyKBhDwoc9ksVmtuc8uLEDQ3DFio/HU/iMBnv5080NH0Yiy
	 qOUmvWt6XGzyGuLMjtFvWo9WYnhs97Wv0YaFxQPOa8OjnfPydAsm1e9EPlRaH0Dp7L
	 7aoDGcwMZiPwUeDBTvPCY1hGIGo0zlTWRRcFdWtyKGyLpLtHGcyCpd9aZVq6bzEK7e
	 rzUiHsFeFaBiw==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Ingyu Jang <ingyujang25@korea.ac.kr>
Cc: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260514185215.3753998-1-ingyujang25@korea.ac.kr>
References: <20260514185215.3753998-1-ingyujang25@korea.ac.kr>
Subject: Re: [PATCH] ASoC: ti: omap-dmic: Fix IS_ERR() vs NULL check bug in
 omap_dmic_select_fclk()
Message-Id: <177881003945.1136679.5811990487179784216.b4-ty@b4>
Date: Fri, 15 May 2026 10:53:59 +0900
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Zp1aGoaw6rYDcMxb3pplxni0XkxMFhFbSBE5zIZ74Ss=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqB0xjOIg4m+K/aydFCQoTG1hNkdEm9Cekisa14
 VE6NYHZnVeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagdMYwAKCRAk1otyXVSH
 0C4JB/9bl2AuIavqnPwNrt2gg1l6paYqTOOKJSlfOQQiPUjQXkKBxhLFoWfBHFkv+3qO4fCrEMv
 mAbx/3Hiiu5sqaCoxyY6HLIurjteE+PMxRLPpg8l5FxF+1jiaM38SyeoDqME0b+rYUaba6txHkG
 ldL3UvZ2vH4cD4T8mLd91jKHmVSHRKXo5H1FTiPhTmYwBRK7diX7XSX5UFAK72WKtJuMLldXLsH
 XUXBOH/UtU5MOt2/JN5GaHKbuGkH8LhcSEh170Gf04Ny2Pi4HYUTY6Hdn2vGF9UG9gs3eUkVq6t
 vDQ37xwGBwts7f4S8S7a/8zcgzgZFL67kDcOmdgS88TEYJ8y
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 15 May 2026 03:52:15 +0900, Ingyu Jang wrote:
> ASoC: ti: omap-dmic: Fix IS_ERR() vs NULL check bug in omap_dmic_select_fclk()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: ti: omap-dmic: Fix IS_ERR() vs NULL check bug in omap_dmic_select_fclk()
      https://git.kernel.org/broonie/sound/c/c996a4418dd4

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

