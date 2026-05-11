Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499E379971;
	Mon, 11 May 2026 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500980; cv=none; b=g8VXg8FODJE4a+jhZsnWCQSLKXuI3e4cQ6gJRyd/7xinCgwZX0RUWUTZTebk1Bz/nVsN65NxA2s1KaZ/RWBSH/Jt5UR1CcdlC/n8ztOstJRasC9INMkS/qT4Dzg90JfwhWD/7qASaqqfWf/pbLIUqW7rVatjI6mKw1WnBAp8Ufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500980; c=relaxed/simple;
	bh=bEg2Oc42Jc1YTiUa6rw6CIPcwQmL+oHe4mTQX0c+a28=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RRobU50ryIFu7tCoarnVJotEJVNU1ntY+12DJ39b2K+RifUWtc6kDwIiM77x08DYYM6CgwFeJfHq3gSoVs/swMOXCR+Ou/gufJ6Wl9L2yk7uAGrqeWmsHZfYWtXH6O3dVD+pIJ9KvYSF1Ch3QB3RZl34ftmVnFPb5cOlylPslOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db86Lt37; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db86Lt37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87A7C2BCFA;
	Mon, 11 May 2026 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778500979;
	bh=bEg2Oc42Jc1YTiUa6rw6CIPcwQmL+oHe4mTQX0c+a28=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=db86Lt378y9R8RXR2snODXaYcOnBIjXKaAG3zaMPjW8VBneDp3zXnYMivY7dxf8c9
	 rYJBt4F2xk7PeaYWevVR33LNpbtsAStWG9tGdJ0S2K3Obi10jF+Lj19rkceSzSNaJZ
	 d71UcWzanMRvSnIen0Va2JtcNvMMQpDxffJ9Sh7YJFP9yzNek5wA8sYjBxO9F4UXq7
	 KG3FQ0ATkSiUa5rDHEYQoEqoEzRSAB8kr0Oe22d9VdQbtv9NDPYMNPBtjbykS1175d
	 fO/yOy20D6b8SPIuPHGE9aqpMRqi2dkMiCUDc0cIkznE7OtUxqWc8OjZDIGErLDaQl
	 78fbgVU4u/yNw==
From: Mark Brown <broonie@kernel.org>
To: peter.ujfalusi@gmail.com, phucduc.bui@gmail.com
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 jarkko.nikula@bitmer.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20260508103837.138142-1-phucduc.bui@gmail.com>
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH 0/7] ASoC: ti: Cleanup locking code using guard()
 helpers
Message-Id: <177846113679.988959.549301226983834069.b4-ty@b4>
Date: Mon, 11 May 2026 09:58:56 +0900
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bEg2Oc42Jc1YTiUa6rw6CIPcwQmL+oHe4mTQX0c+a28=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqAcVwRUcuGoablk5B0LXmYra1XeG2Two6IgYxP
 5iSVT/qNsmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagHFcAAKCRAk1otyXVSH
 0BMtB/9G8zJo+/JROGbvYdtwR0VOhgiMll9INUOP8ZuZFMHIy3sUj/0snGKWrfvmHylx2m7Dm2Y
 bBYzNuQIfTKoiiyzPCOk4v08xFDLSFPbenBi/6Bu65MjDD2ESYW3jj9T3nt3+2c2QFd8p+c02f2
 Ur18L2egqrwHqz7eOOlTIEWzFOhbeaASeYBGXfjsBo2edIiYG5xQgHBwNlnwrOaY5ELZAnaBRB3
 pFKtocGMsuQyjpV8aSocP/9+0urSuM2no+lVLftHpWGZdYX4CO0U3zmkpPGsB9NX9OwlmTpNqsD
 nN4r33S2qDiGDtOaedXFVKu+WX4Za48zYur8AIiEfmQ+9ypv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 08 May 2026 17:38:30 +0700, phucduc.bui@gmail.com wrote:
> ASoC: ti: Cleanup locking code using guard() helpers
> 
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> This series converts mutex and spinlock handling in TI ASoC drivers
> to use guard() helpers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/7] ASoC: ti: j721e-evm: Use guard() for mutex locks
      https://git.kernel.org/broonie/sound/c/6f4cf77320ae
[2/7] ASoC: ti: omap-dmic: Use guard() for mutex locks
      https://git.kernel.org/broonie/sound/c/bc59728f9349
[3/7] ASoC: ti: omap-hdmi: Use guard() for mutex locks
      https://git.kernel.org/broonie/sound/c/59115f79acd2
[4/7] ASoC: ti: omap-mcpdm: Use guard() for mutex locks
      https://git.kernel.org/broonie/sound/c/70031e9ad601
[5/7] ASoC: ti: ams-delta: Use guard() for spin locks
      https://git.kernel.org/broonie/sound/c/a8217778be47
[6/7] ASoC: ti: omap-mcbsp-st: Use guard() for spin locks
      https://git.kernel.org/broonie/sound/c/d94e794e8294
[7/7] ASoC: ti: omap-mcbsp: Simplify lock and resource handling
      https://git.kernel.org/broonie/sound/c/822f67bc269d

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

