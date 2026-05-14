Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479162E62A9
	for <linux-omap@vger.kernel.org>; Thu, 14 May 2026 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754967; cv=pass; b=fO+eF7as8Es9GQKHOAwj+8wmOEGTTIMy/x8b06HMQJKWN0bbOQCJW2JCuk4FN7tpdPhL+0q0MVJiJpkIFv28TT1YsczIIDckMKg6vIJMlaMErjhc82jJ080lMq+MeQR8MMnXmC0om3YRn6TcJIok+ewKflHs0YzZ5V04DcQaX5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754967; c=relaxed/simple;
	bh=yuTk495Vm0IloebmySK+gEVSk8s1hGPzD9oy77p6pxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8ZLVIKDONmAmScwgE2G5u/3TDtGnHyG/nJccZE6nYoUr6DXzU4qbj1OO5SNosDN/63o0vccsAJrgJF6DcQCl18yonLlw1WoJV3kGgF33rw4Ev9XPhQJYNcb0yQrfaS0qsfsum91H7Ww/mG52OvW8A6KkNfG0DBEhkpzNZEKAxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0Z7mSmy; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0Z7mSmy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bcf48850c4so26677345ad.1
        for <linux-omap@vger.kernel.org>; Thu, 14 May 2026 03:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778754965; cv=none;
        d=google.com; s=arc-20240605;
        b=S7VX3eQ8iPryoX0yaC7/azeBnGVVfrQJQF4t+RsxuxWKe+XZWlQWTFimiuGWLTLxQx
         tzz25kkoDIVG1Jw6VUOnbtjA9E7rrMAv0QJ7+3zz3U1Nr43nBEsXnGtM+ywqkSMSgE3+
         JF22sL2OM34UkRo1BFTdQFivTwBVNMZuas/VLicGEnfveJBN48c+JFoCitttgEoPb+wB
         QA9QZceegPo86qrrx31ZjuRYt12UUkkGpcJSJXy8jSsrFdqEopEKwUDVRonBFLAGfoRL
         Ih+Y+wEpRX6pvvx68zyIx2iF5veEjqeFAtLxsNOVIVJoX6EvL1c4lL7OvfpBl1lAx9/0
         XFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yuTk495Vm0IloebmySK+gEVSk8s1hGPzD9oy77p6pxc=;
        fh=xJHQczIV9ia6FhQGh5Fjdgi6/en0qS+Tvgfxp05XIU4=;
        b=bHcPyd2TlHAydDflx9gN4jWCUrJen5l5DduV9SI7szqCBLjt5ouQE7TB3DflN2Cfx0
         kGjfFrqO36SlN5DYXDZt9gPMc69pkWTJdTZUNsRhSKuLrcPpd1+GZf9Ni5BaFq989uBJ
         bhZI5zYabwRKROEajwlTRZzqcG6vl2M4v/TvTrALl9RUMotDRQ4Qde12jwMzZKK7PDaw
         ++5iPRw43vNU05XFodxyVgxUB21t7PaGSjn8G4scL4I+8CAs02PM/VhOxDCZedFIjC7v
         DxHCaNJdVbrCow3JEnuaI7eueocND4/Oa7FGY7JNND3+JkvewopRWc4hGYJ41Lz0/emj
         YxDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778754965; x=1779359765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yuTk495Vm0IloebmySK+gEVSk8s1hGPzD9oy77p6pxc=;
        b=K0Z7mSmy5hG/IEGEU6sANa3uKhWg1WR/aMLKgFyNscZ1RoNVJ7iYEVLxxIoppe0kIr
         vFoDtygEAM2dXKsas+b0+6+mGgRuC2eO2PR/0TfRQq5cu2NXKf0VAEeesa20fAj0M8LS
         JAsMg2U686Qsr3k32DhmabRZc9eMj5sVo3eY18ZQQtHuvFXVf6+GSaOHu7jc+ILA91cR
         k1Hx+wby7302sFS1DBRz+UCWJcZCYGM1WY8bZ10xhhipXddIyyPqIKdZRPiIwDZp6l62
         bAkNn/OIDooECbZnzc3N7ivABygXzs4LLpkB5FltBdEQRSh0Gh7hrSc4Q9nch5JKpxpo
         ZhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778754965; x=1779359765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuTk495Vm0IloebmySK+gEVSk8s1hGPzD9oy77p6pxc=;
        b=Ojl44vaiGLvg1C0VQ5P+fzMAb9+NmjGOL54tlaS/nEj3+HtvEXGMgBI6blOrUc5f3S
         J6jHzQvD6UmTAeu+lSbzc1pYUTxksAYTyo5jjyjfhEbSmPJCgnBfkqkf7jHK/9BMdz/b
         BCfF+nRJ0waq7IoH91UtwZz/9ej6LFCOQAbxHOFVlO4OFop7sk3pcYsF5Jh3n9csfCNC
         CAGpp0l2vtpFHvFim3tS2tt5+wijahkXPaHzOMaRQ+YM1z0JgBgsA9eIoS1Mrxskn2Nf
         sxrEq7sg4lR1A0OnFsLa5LivGfk2NdKCKepscz0YKO/uE5sZ5yv+LrfpgDPnllLhHKFc
         GyOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LfPPkzKgWajKpD7FoGNeQ/yI7wIvbTO146tNDhRlHWD65X0fN6osef2tDuPHGyIper38L0g4KPJus@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBHZ6N+g26Ub/cB7vFwv6Tkx3NQbhvMX6rwBiEgxQ97PAJsb6
	Af9i8LvIz9lIRRkIB5ylNj3Sh/NctTpW4FsbvNcBn0IX/lOV8eC/miVMwcWj9jXpm7P9zFqWpx+
	ZLkzcXa5y4qkfrRH2C3ftzIielVobklc=
X-Gm-Gg: Acq92OEELv9eiiadxzbEvJBOboqizg5P+VnRnGHPUbJnH9/yS1J9dgVO/33afyzrcaL
	gpWCh2Af1wgAQDFEIqtKNWa5Lf01k7fjmjxSueQ6I2CXsLCbGKw1kfR0GKY4mKdpJopK/JfmX3n
	lcMvpMF8RWKQLDzjNgzTDIwebO2l2NmMiJuEBNIw1JYlBqkTsVLYkryb7xwOEl5TpI9r/1aAP3+
	p+rh3akUVCAv9vjzT7J8Nydf4NqyxmNk6JtlAXwBS7zjaEWrRIgrIyKMtm4CV+2uUi4LM5Z94SQ
	9D1mfVWFhOt1Mj9ReWIo9MDj1mriGXfgQp27TQ==
X-Received: by 2002:a17:903:22d0:b0:2b7:abc0:3bd7 with SMTP id
 d9443c01a7336-2bd2716ecabmr78648755ad.9.1778754965388; Thu, 14 May 2026
 03:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508103837.138142-1-phucduc.bui@gmail.com>
 <20260508103837.138142-8-phucduc.bui@gmail.com> <af_g24kqkm4QhDuU@sirena.co.uk>
 <CAABR9nH62K5qqujXzr_HwT6F0V1ezzENAVnjqqu3zrMvmCYWbA@mail.gmail.com>
 <CAABR9nGHO+q5BUmUtER_tcC1drz3bBap-+=pew2+JBKYsg_6Pw@mail.gmail.com> <agUm188qDiaSbeqc@sirena.co.uk>
In-Reply-To: <agUm188qDiaSbeqc@sirena.co.uk>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Thu, 14 May 2026 17:35:54 +0700
X-Gm-Features: AVHnY4JM1pWwYl9VeVa0saoplG5zAR_2e0bH1Fa2OQK9QligFm04zKOKs1A98Ng
Message-ID: <CAABR9nFjsxMdzsdHfQ_HmTiM6d7zfjA0=G17pBCDJri4dVU4nw@mail.gmail.com>
Subject: Re: [PATCH 7/7] ASoC: ti: omap-mcbsp: Simplify lock and resource handling
To: Mark Brown <broonie@kernel.org>
Cc: peter.ujfalusi@gmail.com, lgirdwood@gmail.com, perex@perex.cz, 
	tiwai@suse.com, jarkko.nikula@bitmer.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

> That's probably a useful idea.

Thanks for the feedback.
I'll prepare and send the patch shortly.

Best regard,
Phuc
