Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683D42BC56;
	Tue, 11 Aug 2026 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485990; cv=none; b=fLFhjK1j2ydZoviT3PGeeExF/uzB0iG1s1i/yDWj2ZAeE91qYgWiE4WbOlGEGqrfCZG6TZmQNPNLWxUTFiCgvChusJxyoGGdV6uj+tp1lReFHK9po9Oh1g5pCtx3zchEu2TInUD0X7NlITc75vpMfv2oe+3kAP2y3jhnvn9Zp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485990; c=relaxed/simple;
	bh=vPOwkA19BILr5jWVEFCEJ1E1syExXAu8WP+xH/2Au5s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N7GsQeBQ1XYehYf/HrCoMgKh+XCeDnkaN5/a9p+be9jVrv+yNjydafsKV4LUEm6OK/eg/wj++cdpaZkYkjRJv7vku+7yoi/A7Tzz172dSX1obfpTUdHNvSRNQjuUz//9/h3APqBu2yKIP2OlKoMq0el8MMhwkUHJNvr8FWW31MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlRCnUU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlRCnUU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ADA1F00A3A;
	Tue, 11 Aug 2026 22:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786485989;
	bh=AC3hifGM/g3I+wFfHWwI2131IAq2wrnFxUfvtLYQYDQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MlRCnUU+Ag/OFIL4j3SJoDoDGo0khcSU9lzqrMITDj1nQVxT3EUWURV3GIkrOke5z
	 mgB3f1O0X6oVuQbGPGPZPpA6kiWmreQMOgAO3bkiZHu/lKDGPyrx0yKXx/qhMqE86/
	 T5Qd8GL8Rou7tBk1Ln5xoBxymyRd/Ugm8KA9BgpUzcvX2v89LJk81hi92k0g95Nt4E
	 BfegYS1c/vHUXI8lj+tX6dVN9SCX2HQNRo5Y/Vd62NCaCUTYrRiBJpLq5NuvmpCxuD
	 m6rOEmfcU84FT1/mo44c+BmKW4WiBqzJpc2GL9WH4v8RZMhWAegaMqHWuB/xrQF3Yg
	 t6N86KcsaHA4A==
From: Mark Brown <broonie@kernel.org>
To: Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, 
 Andreas Kemnade <andreas@kemnade.info>, linux-omap@vger.kernel.org, 
 phucduc.bui@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20260805044556.38183-1-phucduc.bui@gmail.com>
References: <20260805044556.38183-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH] ASoC: ti: omap-twl4030: Check for missing card name
 after parsing
Message-Id: <178645686823.119683.658802759634601408.b4-ty@b4>
Date: Tue, 11 Aug 2026 15:01:08 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vPOwkA19BILr5jWVEFCEJ1E1syExXAu8WP+xH/2Au5s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqe5zi4M3C+vPXyQl6aDtJrd0qI1L/6eV9/smHy
 OOiXch3sOqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanuc4gAKCRAk1otyXVSH
 0Mr/B/4hdjCYFiCeSMzZ0JAc72WXA5EO/YdazvPxhEUrK53ZFoZUyhOKhpIrNZknfRrSrAr3yUv
 7f1pzH4l6HoJnXEy10VSObSPg7oEl2wzySQGbIt5m2ArpNJQBZXgb0zk/F5NwRH4+bZq4xbFEwk
 38xTKBNXcW7EbJNIoSPIP/8RzSbkanDDDqZa9m5+pipJMw56C3DIzIUb1afHZ0wZP7NXikS6HnR
 E/+xMnoDruyJUNhMDjlbI7uzRgmfe5RtFC9LaRnRJSxZ5Ai9sZ16XqK/qVhmdi9jw44L3yCV7aK
 1si/nnNa+z514ubSc6MX6PEEnt5FWhVC673NhEg0vMKEC83+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 05 Aug 2026 11:45:56 +0700, phucduc.bui@gmail.com wrote:
> ASoC: ti: omap-twl4030: Check for missing card name after parsing

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: ti: omap-twl4030: Check for missing card name after parsing
      https://git.kernel.org/broonie/sound/c/9e0698b77684

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

