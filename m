Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4084B8DE2
	for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826274; cv=none; b=PXv6xTUvW8RmYBQEe3IinryGqS7GdmoclhiMdi7R8on7H0NfTs5Gp6xT9Y2V8EE4Mn3/YgUV9IfuXKmywIc70hKJyMt1eL65ies1f1SaX/KKEmSxQYz0YRh9xYuN2dl25kpxG0VLce1ao0UiOTGAjnjKri0kplyCZHW5tM49S3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826274; c=relaxed/simple;
	bh=o9VVTo6S42mbOL5YNHeNddQl83IMRvNt9iVw7Ax1zcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uLEHRMTuDeqFB+WKq/OZHlGdncL02qMUO3OXYME/BPiJh8FqSbckZs3zABmaqMeJxbMMRnWE3DgiEZlAK4elZtYIyqTFKlgy97AnRSO+gY0lXtNXQjRITwg7NpofTtTrcX6q9ERSeuC1uLSDK+cDJPxWzhTnLJGj/fkTkpKru9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BGcn2pm9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BGcn2pm9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so830447f8f.2
        for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784826265; x=1785431065; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jhojDdHC94+BdjAE5gd50YRzJP7qSAXpLrLf8nMSLLo=;
        b=BGcn2pm9WvAug4PR8l3FANDWOZnBQ4XdbW21YipeI3nJ4ukRiQBaauWySLaXoEROPo
         KYl4XqRUVJoStP/ov8Y2R4cynD3Uei8U7U/JNr1wxh6PHKu9iPfp+JkqsyRtiimnKIID
         u94WFQQfdiv8izgm05vPzHzcdo4Vk9kdWiKwzBpidPHKXf02aR/YRfXhapIB5D6i9zKP
         WecHCnnam4b7nQqsbx9VwAiQrqFyK840l+UkKI084tMkH5P2Ps9pXnEzoplZF157Wy1F
         bGraUumSEdCftfBBfBiVnH6T0G4KawEtzV9NMJ1YpeeG0ryczMqalGAvviv62T3ZbI9e
         2ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826265; x=1785431065;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jhojDdHC94+BdjAE5gd50YRzJP7qSAXpLrLf8nMSLLo=;
        b=qh0JJJ5coVxLvOJ1abDp63UJ2Lq4tylbUnUOarKwRGbFqQTKUdVFvcntiyfAjU91V8
         iCSKy5CJi4ZF6JxVSc/A0PBJNV8eceuP5FPxo0jTHsvZug59tiXQIbkJ5f8n/Vzr4GfO
         r94L+tcD9knDIj2sotPqseLo+3iOcSNv6RifvWM/V5HU7kN6zrzOeaA2ahTyUIWNuGWF
         sKB+aR92BOwkr3SpDoiMnd0r+9iET/YUjcViBO8Fj4Uevccr+S1SekwYi59KPDOBIs5I
         FtvfO/cFbkUgN95HFWTMDcCx3yuFpoob2gMw0QgEvaqm+i8jpZTeIe5UuvHBxxo41yHk
         ZoKg==
X-Forwarded-Encrypted: i=1; AHgh+RpLRYpUgw/GTeoCrosYKcVrDKfOefAqaLxF7BlyHAwalJ9v/y8hI1tsUu7LDT1KjtWy/JxUdDdzFlK6@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbrd9fPihNpMJvHf7DfOM3etYrP0M4aQtS9pLqmefRkdEhwMm
	l80giq6aggPIWaxdvPR1unMdCfa9cDJO98ORK8EgomB7JkVPMHgd4ZqZ16kkFTH+tv0=
X-Gm-Gg: AR+sD12JumytqFz1wLPQK+3rawN+pWBBMlZ5S32SpSUSdUtNxVOhhEd+CoZOhAOfHqd
	F/tK/5V3lmCcHxSdsEGtRWJve4K9U141s+fwdFVOq9135KZayZRvOd9co63lhYT7yQQ+nQmLICS
	57Lhb3K5/Pjx8kKab3XPhAzakJw1ZTTMsCGM7QL9AhxiGEksGcwHEgxIShCFATOW3vP4/x4sl7k
	blk6ySSljFOY+W2L263qK+zYZd0EVV+xg1zYNIayrAgRb7zRuzXVyxQ+DkWgFmqjPkzFkir81xw
	sOee0QvDt1HcbgKOtafw4BnqncgOlQBfZ7+3J//CKlb+uKGxVuLEZE0ykxW7Z2pdMZfffOBWyzr
	HwUqtbibBkBOqALhssV/xRgOrSYOTGbCGd/4G5K4D/AOe2o/VjWQGjkXtGhWs5c5pfDM8bTqK0A
	N1
X-Received: by 2002:a05:6000:230a:b0:47f:8aba:8a9a with SMTP id ffacd0b85a97d-47f8d71c7eamr5497660f8f.18.1784826265170;
        Thu, 23 Jul 2026 10:04:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:5f98:8c28:3e2c:1c72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f85c67339sm17937986f8f.31.2026.07.23.10.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:04:22 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>,  Gregory Clement
 <gregory.clement@bootlin.com>,  Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Bjorn
 Andersson <andersson@kernel.org>,  Geert Uytterhoeven
 <geert+renesas@glider.be>,  Heiko Stuebner <heiko@sntech.de>,  Prashant
 Gaikwad <pgaikwad@nvidia.com>,  Thierry Reding
 <thierry.reding@kernel.org>,  Jonathan Hunter <jonathanh@nvidia.com>,
  Tero Kristo <kristo@kernel.org>,  linux-arm-kernel@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-msm@vger.kernel.org,  linux-renesas-soc@vger.kernel.org,
  linux-rockchip@lists.infradead.org,  linux-tegra@vger.kernel.org,
  linux-omap@vger.kernel.org
Subject: Re: [PATCH] clk: clean-up simple provider misuse of the consumer API
In-Reply-To: <amImP6sFlv-sNhMh@redhat.com> (Brian Masney's message of "Thu, 23
	Jul 2026 10:33:35 -0400")
References: <20260723-clk-provider-simple-clean-v1-1-0c9668240467@baylibre.com>
	<amImP6sFlv-sNhMh@redhat.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 23 Jul 2026 19:04:08 +0200
Message-ID: <1j5x25d4dz.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On jeu. 23 juil. 2026 at 10:33, Brian Masney <bmasney@redhat.com> wrote:

> On Thu, Jul 23, 2026 at 03:20:59PM +0200, Jerome Brunet wrote:
>> Clock provider should not be using the consumer interface.
>> In other words, a provider should not be dealing with struct clk.
>> 
>> This change targets occurrences for which the provider uses the
>> consumer interface and corresponding clk_hw interface exist:
>> * __clk_get_name() -> clk_hw_get_name()
>> * __clk_is_enabled() -> clk_hw_is_enabled()
>> * clk_get_rate() -> clk_hw_get_rate()
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>> The change being very simple, I did not think it was necessary
>> to split it into multiple changes. If you prefer it to be split,
>> just let me know how.
>> ---
>>  drivers/clk/mvebu/clk-cpu.c            |  2 +-
>>  drivers/clk/qcom/clk-hfpll.c           |  4 ++--
>>  drivers/clk/qcom/clk-krait.c           |  2 +-
>>  drivers/clk/qcom/clk-rcg.c             |  4 ++--
>>  drivers/clk/qcom/clk-rcg2.c            |  2 +-
>>  drivers/clk/renesas/r9a06g032-clocks.c |  2 +-
>>  drivers/clk/rockchip/clk-pll.c         | 24 ++++++++++++------------
>>  drivers/clk/st/clkgen-pll.c            | 20 ++++++++++----------
>>  drivers/clk/tegra/clk-tegra210.c       |  2 +-
>>  drivers/clk/ti/clockdomain.c           |  2 +-
>>  10 files changed, 32 insertions(+), 32 deletions(-)
>
> This looks good to me however can you split this up by clk subsystem at
> the very least so that the various submaintainers can pick up these up?

Will do

>
> With that:
>
> Reviewed-by: Brian Masney <bmasney@redhat.com>

-- 
Jerome
