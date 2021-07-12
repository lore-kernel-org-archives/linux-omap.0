Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370E6C07E9A
	for <linux-omap@archiver.kernel.org>; Mon, 12 Jul 2021 10:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB7C61151
	for <linux-omap@archiver.kernel.org>; Mon, 12 Jul 2021 10:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhGLKuj (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 12 Jul 2021 06:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234561AbhGLKu0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4374561156;
        Mon, 12 Jul 2021 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086857;
        bh=5PffPv5m03zjdC6dKPsQKTxZb3xwC3EG8J4GrquSg/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFJeMjffarDB8EMjr4V5bym8i3Qv3YX433R8f5mlPxa9/1fpjhLDELX0n2/uVdgAw
         VIKghoFvKIabOKzsKUZ9FuAEqGERaxq/ZBH7giyCCCX4Yjs4opr93Gv7h7pW+q1fpn
         FktncyLWGIlSVywjMfEuJVXi48k+6hz9cFof1X4YoJe6h54w7ModDD1KVybWibhFz+
         ktVOnNL3GVfN8hkqGmBvFZcg2nZrF7LUSo6MPB9YtbLmzuq7fUZjckmJQKKkOZM/gi
         JfMb5HS5xJkKU02Yyfi7IhdJd4W7xDMGFLnI8VEzlxQfCtBXA4qKnqPpo8azvmxmtw
         4E5to9MyWAvIQ==
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: delete some dead code in omap_abe_probe()
Date:   Mon, 12 Jul 2021 11:45:56 +0100
Message-Id: <162608623151.3192.14557258432919824298.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YNxTHXz58dhgbFtG@mwanda>
References: <YNxTHXz58dhgbFtG@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Wed, 30 Jun 2021 14:18:53 +0300, Dan Carpenter wrote:
> This code checks "priv->mclk_freq" twice and the second check is not
> required.  The code is left over from when removed support for legacy
> boot.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: delete some dead code in omap_abe_probe()
      commit: 3666a8f820075e99539ab50687e80fadf997822f

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
