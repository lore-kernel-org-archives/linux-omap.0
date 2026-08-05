Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041734CFC7
	for <linux-omap@vger.kernel.org>; Wed,  5 Aug 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938948; cv=pass; b=ZuaaUrWuJJRCsGxUSMl8nfW7udhLsfXP8Zj54i3mNfStkVvMa8VWrTz6FoY5LCzvRrb4gZxB9T75AXY6Ti3A71oJ3FbMdyvNTHxyxbvOJVrOSlF2SZym6RGBF4Q9rlUFzgIeFbb8gFnQz3P4vDt9yAa6yZV4SwIao8g8FWkGS40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938948; c=relaxed/simple;
	bh=xemyfSPp9pwMFX19YwknZw26xsatniLD0Lp8dnh1cZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrxRz/lwdAQ0Gu4z9b43pEEOLd//soFytSNHc/t5dPoy9Z/wkvFGhMtxwrd0AohBHgu7eseLi3qXwlPykYQCjzsVhKXjQcLoffd67Crw5xO3oEMgmsRW8cWuEcEaUSgaOKTn29D9VC6aaajRzMKoGlO+R+DOip+7M4VaL53XU/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZUOfbXw; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZUOfbXw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfff5f88dbso15529165ad.3
        for <linux-omap@vger.kernel.org>; Wed, 05 Aug 2026 07:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785938943; cv=none;
        d=google.com; s=arc-20260327;
        b=Rs8APbPX1c44B23QW9rNZFb41EewajQA+sPOYjX//8U4SsFgGL5oc5qfnYmZmgqBt0
         VuC2raKcspEp7urRA1VaU/vRgFn00b0EA2c27TecbyitjV899cfSeH6aNBcI5/hLNB5Y
         IA4ym2GUXkD5OAtbQJl/hn2pprtDFv0gPBmWCwIIoL3XyAwWEonyhLUanFQNpI9X4UIH
         Me4V3cea4U0Xqw1d6a57cXVH7ov26KX67takRHjCWwGlTakHYqLvUtIPjre791uBSlZ8
         pLuU61qDcq1I9e3Xs8gVzgE5lr9R+31yYvJ7SSS57BQ8TiZJibqsMbc3/z7QDTpeJgWj
         Dakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xemyfSPp9pwMFX19YwknZw26xsatniLD0Lp8dnh1cZQ=;
        fh=8fsFVpJe5MHOrQXIvFhEqEKYjuHiCk28Byy2SYth5Bo=;
        b=co2dyNW+bHKl+fnWryPJvx7m3f3SakmfflV5jvekrdf4+eSGHr4BY/J+ITJjYZe6DK
         qjAwNXm5lUf8+uQAdbDkxtvh/5o6lmTrsXRqpljsoRbmOzNsWRr+EZlxRMth/9HYo1Fe
         Cil6GaxBb5OXo4lrrJ4MJvwh6F9d+T2kriV++xjYZFHUOtYKtobF/YmHYWPup2ZgIBge
         1sUguw4cwJIX2+JnMgWaEuCTdJPNy25u7DxsHHZdZi3/0Am1DJn69RExFOJ2BfP95Xvc
         MTzXBBvLUZH3tavc/3wz+xk/YM5e+e83vcHmK/rNaPrkVmpefrobzU6a00hpi4+MuaCZ
         S1BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785938943; x=1786543743; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xemyfSPp9pwMFX19YwknZw26xsatniLD0Lp8dnh1cZQ=;
        b=EZUOfbXwkyHaFXGNu2LftpHR/B0Vh/IiCqnOAymgXdrPaQ5mp4n2TNm7nhKnX/UtGK
         P5aBV+y2ZFFeTdKtdF5XDYveKHLFbgySk1hsaY6kByxgz4mTOSqp49SkwHd2DA8rmZ+d
         y779n94u5+K3YvJg2oIRSaQyd2kk07gMy33t4KmSuz/eWn8fXbUfSPpIVqo0aC49fVOH
         Rl0bi8K3/hvj/bS2rq13UWQBdoAuKmx3XohB1dlC59HVDHLWVyHEqwlBxC7ZICyYdTaG
         n80aeIANYjX24OepiMV8QuprYoa/2MGYS7UUb504mjq5N562krRQKQ0IlNcSKJ0UAMC8
         A54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785938943; x=1786543743;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xemyfSPp9pwMFX19YwknZw26xsatniLD0Lp8dnh1cZQ=;
        b=HLVSB0rntbCSupWJwnrb9n8V+yeCd/3qu92AuOJiReCGTqyRGC7JGGQECdKChgAxoX
         5oK5Q02LnSjo54lmazsdmUF7LNoq2xt7bNVFsyX2B+bJp5qM5UDn+WLFSHZdeQT1TNo0
         vy8jvjLAr8rBTdw4M7r4s1qnne3J92EAuYAQLTeuQS7ArjLX9dBlRz5LQ4sVreifMwbC
         obKkQs5e1NwjKbcHA8qm4pZSgW8zagxobVkkzCOeGBE3/oKIIWp3tUVO2aAwMWGomUHr
         21qIYAPEWoPFkFQipwp3qj1TbMN82+IJLalYo5fkhBDFErpc8b6P0VDKwb80C7fEv2cG
         xc1A==
X-Forwarded-Encrypted: i=1; AHgh+RqIzGrMWzAoBihaXJZxuX046gu43nPkIhcN10B9qIc8XHEMv9PZ+vxG1x1TUd1z2jE+sXHSFKGo497X@vger.kernel.org
X-Gm-Message-State: AOJu0Yypb2R/X39evezz+MK8w60aSgpYf6Kgpv8hLA/R55j4Yw3G8LIU
	Q0WchWoDZt/tgmrBNsa4vCPAHkY++brcmTwjSzBCu1x52+tSrfDg+XCTVDOVnQHCBCfAFImOo9M
	9eUgY8A2ltLt+juSvv7EU1rASaskXKWA=
X-Gm-Gg: AR+sD12dkZjpLN0KDfjoqGIPCUQifrdZwp5nFYYwTJwaGY/xr5eAD+zP4EP3iYOuJ2P
	3J9lnP1dWFsbEet6HNz8VFGNje66MdxeC/sutdqF0IB6Xv6Ge2UEla207HzE6B/5VxUcMN2OOK1
	BynUgwJzCsebhLQyB395bua1+048FS3K2zQZXNOH9JMF28uwrbVPVuKP/bSWQVfE9v2fAzTtyrs
	YV55JyJ+z7l/VtYymb3RMK2R8yg2GYaZbyaCPAuBXjLQWhGvIAOEv42wS4wcF6+ebOZKtoLL91m
	7shpZD0PRnMLMDfkrsuhqEN/fMK1s1i4uVJt0fTNXco5mHBGtuQBkSX9pe2KcvBH5YtniHyQBpx
	CdtRd7CGVikoZwRYnh9ITOikJFeqhc/o9oyPrX8LfI/QjaBPOd06jwz2IqUK8yLc9qvHqjsGSA7
	N1Bag/jp51vqejGCg=
X-Received: by 2002:a17:903:1a10:b0:2cc:f5b8:4c2e with SMTP id
 d9443c01a7336-2d0ca767b88mr93568555ad.9.1785938943593; Wed, 05 Aug 2026
 07:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714120042.491712-1-phucduc.bui@gmail.com> <99bc4c85-5f5e-42bc-8799-eaa7ef5d1257@intel.com>
In-Reply-To: <99bc4c85-5f5e-42bc-8799-eaa7ef5d1257@intel.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 5 Aug 2026 21:08:52 +0700
X-Gm-Features: AUfX_mzOqWTlDFK-96ZrRtf69s7sJAXD3xbqxGluQl2H8caDAyUMbDoCuVVOjKc
Message-ID: <CAABR9nE2-BTBNDrkAxd0Jg9RYwe48wfFynRQMwK55D7J1WeZSQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] ASoC: ti: Improve probe error handling
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cezary,

Thanks for the feedback.

>
> Which obviously you do not but the impression is there nonetheless.
>

There's no way I could hide anything from the reviewers anyway. :)


> If there are no dependencies between the 1) and 2), have all patches
> belonging to 1) lead the series before any 2)s pop up.
>
> Right now you have three outstanding patches in the middle of the set
> that clearly differentiate from "Use dev_err_probe() for error handling"
> pattern like if you are about to hide something.

From the earlier guard/scoped_guard series for Intel, I learned that you
prefer grouping patches by topic rather than mixing different kinds of
changes together.
I'm not sure whether other maintainers feel the same way, or would
rather prioritize what's more convenient for the developer preparing
the series.

Thanks again for the suggestion. I'll keep it in mind for future patch series.

Best regards,
Phuc
