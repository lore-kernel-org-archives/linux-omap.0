Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB31B652E;
	Mon, 11 May 2026 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778459259; cv=none; b=qsqkYgN/Q9eQSiU8EDbpVliJPcEsXuppv1ahN2Ke2en/kV3Bxaqyl+RZFltkUH/rbPVbLR7ppL0qjdNvR5ICVM4uMu9/XCJKekFGkyTqTKwzGscgIHfKuJDPHt6537Qeiy9NoIaPDggnSWzLulyjP4Cswxp4peieI8x/ksU+0ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778459259; c=relaxed/simple;
	bh=EXnJNc4uG4BAVCjXbaO2UxpgiNj1MskFFtgbaOuMjXY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EEQrEHu/ZEPLAEe2/VYht3FHHq6qOl/bgg0KzpG6KxREUIActDKROTqkEvVl3aP62EzlcXDELS97ejda2ZqBk5X2Kzw4gqoG+twjP3u1EGD5H57n1rLMHAz807F/mct6dG8c5N+fiHTtca5tlzW/kQezNFA7tt0aqKpBNHFijl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB8zJlzr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB8zJlzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4821C2BCB8;
	Mon, 11 May 2026 00:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778459258;
	bh=EXnJNc4uG4BAVCjXbaO2UxpgiNj1MskFFtgbaOuMjXY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OB8zJlzriycYQulRXfxkOA3iA0BAykEX/wC0XtV6iUahVG2ZdkzgFjcmWQzO3jN3g
	 0DlfiUtgc69TzsJyaJ2cLpiMT6MN5SYNr78HRTYq1tU0aJEgD/Qtrgv6KfnLFUeEp9
	 xm7ugp54J4kFCuSIFSAUiE9+TI5Rf5qTCeFKWGYc/sFJfD71TTjSGiWcjDPzGgPXOr
	 ZZ4sAoHYGFqR2qX52dYawSRqkGCleiJUo9gkH9C80+b2pIzvvYEK3f64G9Wyhx26gQ
	 8OVJ2iUhj/OuHNpRK5f2ZjW722Dc8nI50kFuNPUeg7e25PqTd9jHvIh3Evb7BUPdK/
	 qf27KTJNgOUng==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20260510054214.564950-1-enelsonmoore@gmail.com>
References: <20260510054214.564950-1-enelsonmoore@gmail.com>
Subject: Re: [PATCH v2] ASoC: ti: rx51: remove stale reference to
 machine_is_nokia_rx51()
Message-Id: <177842078632.951539.11612543101019055489.b4-ty@b4>
Date: Sun, 10 May 2026 22:46:26 +0900
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EXnJNc4uG4BAVCjXbaO2UxpgiNj1MskFFtgbaOuMjXY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqASJ35yz6zvrU63Ds277FpsmU3ilvH0KCkD5Vj
 Y8Z9cUmEJSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagEidwAKCRAk1otyXVSH
 0KoNB/9X9ROEpJ5VS9DDwuLl+prTaIQo9pOp7Ck6hpsCv4viPwKVNGBIkacrHLDXl+/9FCNyfJp
 wdyYIJrK2raJOWA9iVEv5NIaMC3S5in/U3nquTwxJhMKbpoeOKE8uPmwz8xD6KITVxJhRT2NVnf
 ZLzZfaUlcv6yryz8N57pwaq1fTh/XrPwzhDk7F9Gp9Pq0+2LEMDWKRTLke+f6hdWTw9cYyetfeP
 zr8yBVGtl+TXbXV7W9pvA2R0pJdJvO5tq1qJxu3uPDjJ1v4jTn1kiO7mSbw40nKkbVe8AvQCFlv
 3P4qSaZ709Jz6iefnRk6L8HfysKGxWejqRMEYaWBgtgOtOPW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 09 May 2026 22:42:14 -0700, Ethan Nelson-Moore wrote:
> ASoC: ti: rx51: remove stale reference to machine_is_nokia_rx51()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: ti: rx51: remove stale reference to machine_is_nokia_rx51()
      https://git.kernel.org/broonie/sound/c/ee05c329c048

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

