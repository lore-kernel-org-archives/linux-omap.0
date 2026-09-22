Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317D47D932;
	Tue, 22 Sep 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790076985; cv=none; b=JACcgC+ReeOOv8uq1f1YVmb2b3RiJOBbeQG0N61L/ttDlk7fuUdwfSIGiWoZ7BdjP388qD5JL6BKF2J1EcNcKHwnicHdC9nIlOeD6zSuwz52B86ZK7ZtJ9nzpIKiX4WRKkDjzafglbetG9sfSl76AA0QPoQbf/LFw7c0IWDoMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790076985; c=relaxed/simple;
	bh=kbFezQWiRUq8SGabVB7immWkE63q4/6fKyVWW3ShPXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozh1dl2V+GPHfrajkX0p9ZA3ptbQTNnlc4YM8tOLsQcvswjml5gfVv0txqEbDZQ6W1QKf5ZtNStHQF4RIK6S2eOzaZ6M2baohf1aZo+smaEVOZPNz4Af+Qo91zGi9x5o5vtm5kGp73CozOLe4ugVti8twCUSAnSJNFOFiPo22jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOz7HibI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOz7HibI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80681F00893;
	Tue, 22 Sep 2026 11:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790076976;
	bh=TSepEe8gJ5V9PTOvT2CU7X853Enuy+dQkLPVUAgV/zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NOz7HibIFdheMN/q4+NYcN2EVOdq4KZAhUqJR4qXWTSSriVa0LwVfRGcSIYB1O6N+
	 bBzOY1zPRlv2VQT6RjL2gDelowLsMgwTAkLxui6wX7jc8G+um0oz4R+dpUp79IvDLl
	 xq5XBFYqNDp3ffnaCAI7NZbkmWzXGEOJXTrhI08t6tuRdYFrGoZaHJZUSpn+G9/3ML
	 7834fV6oXKNvPLgVDQuqiHcrOCribPTTPi3RKbXO1/zu1KhjPHbO1qDlFVKPgAti2v
	 3bpt/cozM2iK8deadZJAITpRm67wTqnjUSiG4OyhUc+bch1ekNhw4TUxfw20llgWr8
	 gB4YUB25OsbVQ==
Date: Tue, 22 Sep 2026 12:36:11 +0100
From: Lee Jones <lee@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	mfd@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] mfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20260922113611.GB3277918@google.com>
References: <20260911081022.3475479-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911081022.3475479-1-triet.hoang.dev@gmail.com>

On Fri, 11 Sep 2026, Triet Hoang wrote:

> Convert the deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
> and pm_sleep_ptr().
> 
> This allows us to drop the __maybe_unused annotations from PM callbacks.
> This is a straightforward cleanup with no functional change intended.
> 
> Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> ---
> Changes in v2:
> - Change commit message prefix from "drivers/mfd: " to "mfd: ".
> - Wrap to 75 ish chars for commit messages.
> 
> Link to v1: https://lore.kernel.org/all/20260821092508.324787-1-triet.hoang.dev@gmail.com/
> Link to v2: https://lore.kernel.org/all/20260829050228.42638-1-triet.hoang.dev@gmail.com/
> ---
>  drivers/mfd/iqs62x.c           | 8 ++++----
>  drivers/mfd/max77843.c         | 8 ++++----
>  drivers/mfd/mt6360-core.c      | 8 ++++----
>  drivers/mfd/rk8xx-i2c.c        | 4 ++--
>  drivers/mfd/rn5t618.c          | 8 ++++----
>  drivers/mfd/ti_am335x_tscadc.c | 8 ++++----
>  drivers/mfd/tps6586x.c         | 8 ++++----
>  drivers/mfd/twl-core.c         | 8 ++++----
>  8 files changed, 30 insertions(+), 30 deletions(-)

Already applied.

-- 
Lee Jones
