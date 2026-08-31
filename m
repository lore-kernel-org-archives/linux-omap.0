Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C942376B
	for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199884; cv=none; b=h8Opq7vRRKGLKPgJUM3gdGnUmYJACzQJNxy64TFdVFNEfdjWMB91w407JFa5MKS3nXaUrU24aZsCK7M42kTsdmplRLAkKQ6ddGE4jddI2odrABbbZzZQ6KQScbxi0SrgXwJuGFNsrdVvoxrTvgLYqw0n80x9dHGqKQpQouh8Wzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199884; c=relaxed/simple;
	bh=HqkxdqjH457Q9BNK25GoOuuKnbAaAVBhSzT49eSmRMk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lraeFSiOp2sHlHJAO0PVutKzktFtWRKZbJsFwCysqoVFXoqwG9OJsGMcrMwEu+OMBSGbEfwd36jaZy+5hboCHr0wkrmmGXuxcf5SPSJzLE7AkaolQBUisrx8cStCyhHnJsqvDOuIU43ZNN/BdGt3w5VFLc5LuycMmAgcxK3FfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dl+qBwZI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dl+qBwZI"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39266382df6so3212065a91.3
        for <linux-omap@vger.kernel.org>; Mon, 31 Aug 2026 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788199882; x=1788804682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+k/TRLRabTSJEMCHyIc7Jf71jgev3UqCsTHxCYbIzSQ=;
        b=dl+qBwZIK4QsbDj5Bc4jAWQxcYcU1LmDJxQbrwwp/WQlMgFfLLYAsAxdDbWn+8IMDL
         2Wu92T3GPXx31EF1U8ArgwZxT1dWj/8THBjXaSuWB73TCr2/8xhSSoV4aH/ypUyvh9rD
         K1pL2kNZbUr5jRsimROGxClQ+/AqJ/S9UmxeqWtRc0N00wwAHuXpOhZbXIKv5ktgT/6Y
         ZA5oou2dliAUpFVhCNtJsYLRSo9lofERaCnwEGs+X9he7Tf1AWdHhEOCF6/fYibC0CXs
         lDlaCQlsNNyVjcK6LgGuuDF39I8W9qh8HauiHMdid91QgevZbADqM9cRmrmi0RewTfyI
         Tgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199882; x=1788804682;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+k/TRLRabTSJEMCHyIc7Jf71jgev3UqCsTHxCYbIzSQ=;
        b=JQZd44A0Rr3pXvrGy1S+72HTE7XZYq++b0/tv/4vuVLD6tOlL+ONm9JtLK2df8BB72
         +wUENTW1I4rrYqfqAKfSGjF90hfq2u4o4GiTA39UvVV6Au8zB62EAMADAxCFhr6EPC5Q
         T/9QCkbTgFDgPlnBvT6j/P8ewWWMCKm96PVrtNqU1F+1jae2Ugkv0QvCKJQl/83D44KN
         F6dOQCdQFq7ndHGWv/Ah3LF69GlO/56s0kEeMH1euPD/U/FuA+jua1CSkrSd0+j6GGEw
         yuCziwqcwGMxJtkSaFuoNYKgasRhqj0rAI6R11w8grqOE44SwWzkqw3epXRCaM4pntwn
         BeCw==
X-Forwarded-Encrypted: i=1; AKwUvBwsmMnVooQyqvgieYMimpY8hP9G4Cl56JuIb3bzWrj5md9flEbHFMsab/EoX3lIpaLzUc82Lqhj5Pxh@vger.kernel.org
X-Gm-Message-State: AFuF++m2bYV9i2jYT372aznS4rA+lHrx4P16oZXNTGSmAPw+UDXV3eiP
	SoHs0DLAk9qh+QkZedG1FAvfspCsMHHbaEmYbDq9IXwbR731g59iVFwAwd/LH6qe8A0=
X-Gm-Gg: AYBFou0ngID/igtMeUeGOnqmRhFPdZf5GayzE+ov9WaUg3yROv0Yg988cO6fZb6iHLh
	bwEDYGKIXIF2FHcT7K/vyGZcDy7wSsnoTrVeWFlo4rUMb97zkiCAB/+CysgfT2sh2JrFAbe9Xit
	KBzxiwlf7t1dy3YZ9BLro5meyRDFeHWJBEZutc5/scq9mNsOyT8XuViinXvIVO1vPLYMiuvbsXq
	41A3OxcqcdmgD8PxdeJMmOIHKk2SNbfZbSv/fJvl1Ug8qsCtyMl7UeJ6tOc5F2fLAJW7zNNtKpw
	ATICZjGw7oFnPq8ND0Kl7r+46DLzNtj8T8k23ZJlN0BKLVm7DQOKS97qBREdbmv3YA8D9Y4ZH5k
	elNyzt4Gdfu5ecEedpysnU5lK0E4RlG9gFyavRvE4lX1TuyAS/GizU5WAPMtwfjrVlc4XkMzWnk
	YtFzKTXh6fMUVSR1K+3Rr9oert3o80yJFM8yN+9wRr0cLrci98f+kpM5vdAg==
X-Received: by 2002:a17:90b:4a4b:b0:398:9be6:f999 with SMTP id 98e67ed59e1d1-39907e17dcdmr2865018a91.24.1788199882306;
        Mon, 31 Aug 2026 11:11:22 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3990ba8cbf6sm829678a91.0.2026.08.31.11.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:11:21 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: aaro.koskinen@iki.fi, rogerq@kernel.org, tony@atomide.com, 
 linux@armlinux.org.uk, terrelln@fb.com, dsterba@suse.com, 
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20260828212843.614296-1-andreas@kemnade.info>
References: <20260828212843.614296-1-andreas@kemnade.info>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Support for compressed
 firmware
Message-Id: <178819988147.2869653.7385266758702402443.b4-ty@b4>
Date: Mon, 31 Aug 2026 11:11:21 -0700
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Fri, 28 Aug 2026 23:28:43 +0200, Andreas Kemnade wrote:
> Especially zstd-compressed firmware is at least the standard in Alpine,
> so enable it to avoid confusion when using firmware from such distros.

Applied, thanks!

[1/1] ARM: omap2plus_defconfig: Support for compressed firmware
      commit: 20e49e03ed714b6dd47d45eed9d6f8681d691e8f

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

