Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57332233933;
	Fri, 18 Sep 2026 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725571; cv=none; b=SOHj1SloJhyxSP8N09YcUm5zK3wSTBZX0COPg6GxSlocUTWo3VZ91EngQYyDH1dKywfWTKcFgaZLKrW37e+f/RX7hKyox0jWzpE5siGuNlfQ4xQj5OBrvAFvU0Qv3PoRFLtmRuk2H/I8BSbZjtKDXtzDVKefqOXieBLUQXeyDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725571; c=relaxed/simple;
	bh=/zRSak1lAxIbHDbqXIouf1cZlAlyfRMZrnChjylsPLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mT8a0g2zOi8EHReRy1jpTv3HJBVhyFiKG4mw0stHVFdeGYuSOI1WEBVF+i86BYF0vrSlMonD1lxk6gDAZWpNkUFrv64mHBzUWbaHkyQafKGT/Cp/9kVJG4t8e0YsdtBk1mQ6yRZIaZSQmds4m9Whlf3plMERhmLe08RJvIKWknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Puu3U2cZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Puu3U2cZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B94A1F000FF;
	Fri, 18 Sep 2026 09:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789725570;
	bh=lgMv2zbGxpMjSU1Q12TUieC/fHlr4upj7o7tSr9up10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Puu3U2cZYIyWJMi7D+z6178AnlTL7FE1Zy1y55J+Pia2TSVMLauoTfBUy3vOIOQM3
	 yZJsMkBSz1D+q4Flx42onJbGinBIvq5VvndXAbuS3PH/cJfBC/K/jH6uGH1HiTG6pU
	 xvUIgrRf1/dOcfUvWmcLdVbitzNEyYjprAlng8K9Q849ic28eYBoCSSTIwN4F6NWfG
	 yOGOgW0Iww8zFBfqyrGj9A4v0o/Vp/TqK2HT6icehU0pAkXgm9ytw6/NjKouPe6lcp
	 pAdI4rtS+fjoaKLLiqeVKHEI6EknVvq30GsAcOoxFrMOCPRAlopNG20bkVoovw16sH
	 q0qXzqrb4epvg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Hemanth Selam <hemanth.selam@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrei Simion <andrei.simion@microchip.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Shenghao Ding <shenghao-ding@ti.com>, 
 Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
 Sen Wang <sen@ti.com>, Cezary Rojewski <cezary.rojewski@intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Jarkko Nikula <jarkko.nikula@bitmer.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20260917054001.15728-1-hemanth.selam@gmail.com>
References: <20260917054001.15728-1-hemanth.selam@gmail.com>
Subject: Re: [PATCH v4] ASoC: fix typos in comments
Message-Id: <178966626559.285745.8708474287640144157.b4-ty@b4>
Date: Thu, 17 Sep 2026 18:31:05 +0100
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/zRSak1lAxIbHDbqXIouf1cZlAlyfRMZrnChjylsPLE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrQt5bTHOE1BAdFm/GOH5MgfjjkzvnxEiNN/fC
 VdR/OVoCgaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq0LeQAKCRAk1otyXVSH
 0LA+B/95jFomfKKBgRBZ3Svo7TgDki1UIX7cgIQ3816/CKGuiu8nh3Qj36vZl+2xsX8R4e6+9Aj
 FyFv4gZ2anBe2u8QdnAsP1otAPXZVsvagmbp6t6jIDEQkerLsiUjesAuDdtyIN/DBaM7gdf10mc
 kyDJIx4iGPlf9g1vCp0GeKX+Ysb8mxeV3P4mo6X11U4ELBOvokDC21053xBWBlaWUwLlnM0zll0
 8yJKNt6Hbr8Wp9GyAomW7NaLzuPRIT5jJAToWs7+G+epN/ObyezHBTEDGKNYe/9/0SSaAMtALzb
 oWKiqNIa3OLge9jH+LeFUk9plwFWNOeCWrH4DdpbGb76GqfX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 11:10:01 +0530, Hemanth Selam wrote:
> ASoC: fix typos in comments

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: fix typos in comments
      https://git.kernel.org/broonie/sound/c/a603fe4e0003

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

