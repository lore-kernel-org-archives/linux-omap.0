Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978559;
	b=OQF1VyFL8JvTVkCSQYnhUxWtVOYHnnR8xLPI3egsbOk62PhRwVjtaa188+p5tDJcNc/Q
	 l+TooCQNQoHCgHUYL6u3pfQAQYJfTpYfXnWRzhymvYo2yXfAa+1AupmuRgW/n/dCXfnab
	 +ew5OwztbzbKSc9wgx9Wyk6saK1fPvez73NUuCgxrNPY5zBTYg9d+NjTe5cCLpvwzlY0U
	 WKZVshwrkcouRnLqkKD27B5hrGBLucRdcHCm10+JYTDIURVrqBAsw6YK8VSRIn+pqMMWW
	 U5DctzSGlB0KT0J+LA9EptNeVGsg8bPUTDgeLDuNUgad5Qb6QPBuikCMBqZ7a6n50og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978559;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=GDWt7Xx8f2hrTHrvXOUqAMcvT8tyJ1b4aUv40Hj2kOI=;
	b=iPqYlG6oGHPV+9O7o18SdOmcq9xjgOdrIgcmtV/1F66GL58V7evLV9WSUcI/oOEcUCia
	 qpzFBXr4Io8VraLj1a62hGGZVlAizpl6iQ6QGlSJr4c7FL0vWqjD55BzMhk/W0LwL0tbr
	 Rn1+uZOMPA2hraWI1wL/mKTG2Hz4gQEhsP0a5JdZI8YUzfPd7xSUmSjNC3DjNGfRSE6E0
	 E4HtLHtgSxxCx5/iZ824kyEbJnh4RDykXo8Dv4k7jnRd1+LMqPzs/14JnSYd78FzrKUcx
	 OOqAAE95/OC1ndCqPnO++m2wx6URSp2fldd7OB8TR9xUkl6bUZdt4Lzqd1QvhyDvTkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F9606A335
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 05:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 498F9606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso328637a91.0
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2026 21:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794978559; x=1795583359;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GDWt7Xx8f2hrTHrvXOUqAMcvT8tyJ1b4aUv40Hj2kOI=;
        b=apHGS36QVIDjeyP08Ta0duOx5Dfei4jBjLioOdLBsfPbX/sK9eF/7TrKegSceAs0xX
         Hl7wQZ9rdJOXmN8iGbEkJAG0Wdx2hg9LbqLfxEWAbcOWGT7wVd1SEuWzlPA+rwNXJLRG
         2MV8FSbwLgPWxef9fWDU6CP8sLJDakMjzVgcG+eDYF9CEpAoWb4+06PGvEDfKYuwEw39
         GdHQBx+beiucA/C36zRbO2Ev1saSMzbPTn4WC4eKZcrK3NzVhzHRwvgEn+FJHw2EBsIR
         nvdwuCVDE5D0vFyrj1/UWtIG0teEPk3y7Nw4Ed/YXk+FJgA0s0YnA/qXnmsdfeF3tjQv
         FVEw==
X-Forwarded-Encrypted: i=1; AL+hErHv5ng0hY5aRO5wYPU8gzwbr9LbBoqfjei5Q8T+p5r80hvygtKw38W+wQCa/yTj+nW0j/DRGrDLDlzS@vger.kernel.org
X-Gm-Message-State: APuU4Z8lqeJhfkUFMMeU5CSSBnPpXdgsw1l2FKrBfgut+sfyWBOqoN1m
	gDplhPaEY41e9M94VzblDKul7D145+InIjHaj5HgtPmAu5Q47V0IDsFPaok804o3
X-Gm-Gg: AZFdTZdkwJTaGzUL4A50EBhwYThZh1VFPzlQmLE0W8nlu9qfY22YhNOTfGGVO8iqeCs
	WU6kmiFJSAKkMkIgRU0IZl2gR86GW7jegKVfIuOzhW4AnW44ZCO7CR5b8tBTbtiKgpcBEQejMtZ
	yl/CIVRqQsvGgnBZeLOUWJ9e0WcElpAue7smKW5hA/juYHJ3CMJfDKHB+xo7HXOdc0V0moaRspf
	4x9KRzZEV39x+q3XRj7E2Z4i9DOMs2mBpz9z0C/0Z9A69bf7BCNCOjcdt1kfNzsEJ1OrTQr86LE
	V69J7xHPOD8YG2wQBBtb1MzDW4z2D7Dz9NmfRSIky3Y98JHpyJVYGDQur26+u3XBZSm5Zumwm6P
	kRXJVmdAx0/UdzZbxM3gnM7M63981MbsnFLTSbV31MZ8MQUvz+bS90yHMygPKDl/VZPM3q2Ggii
	NOo17ZRBLnjzRMmK5J0do1U5pNuxwEvnTrdP+/7p/FsLafnXOm4d2J/VkC99GehXd6+OBvvDeJ8
	v7RaHLliAXWDqqTnrnEOyufkxODGSe7RNrj3NqQCD2uIxrGOGSZn4XzbOgOeQjKmctpbXvkYTHw
	/YkgzdURww7Julk89gQtwMbGOuUPDG6LYxl1lURMX6p8X08pD3zwxwJWxIP+OMEeSrbPC28ttKD
	sMlEFExzRS4bXdh6ldRnZJKIF026ZwGG5ovZlWKhbnRk8c6k=
X-Received: by 2002:a17:90b:5307:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3b3d0760eebmr1737087a91.24.1794978558541;
        Tue, 17 Nov 2026 21:09:18 -0800 (PST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com. [74.125.82.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acd118sm2188842a91.12.2026.11.17.21.09.17
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 21:09:17 -0800 (PST)
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso932924eec.0
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2026 21:09:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGfcCz9vZtT+WEZvt8I7b4xm/6js1WtrIILRvDt8EViN3QKbpXjS00Rblw4dkIGE3o79PUmYFuLhRRG@vger.kernel.org
X-Received: by 2002:a05:7301:710e:b0:36c:3b8a:8090 with SMTP id
 5a478bee46e88-3827db0e75bmr1699348eec.2.1794978557201; Tue, 17 Nov 2026
 21:09:17 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-omap-mcbsp-tdm-slot-v1-0-6c9f7aa45a29@telaak.dev>
 <20261116-omap-mcbsp-tdm-slot-v1-2-6c9f7aa45a29@telaak.dev> <179495350668.2707353.9603940609466130588.b4-review@b4>
In-Reply-To: <179495350668.2707353.9603940609466130588.b4-review@b4>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 18 Nov 2026 00:09:05 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ4QAvENNYMNz0vfjhwGPi8HMUJO8M3G0zBcxn6nBd1SrQ@mail.gmail.com>
X-Gm-Features: Aa3M54rshe7OANZPuVP9PlNMTTXkt0PN_Sfmm0dIkeYRICbDlqlKakJADXPsyNc
Message-ID: <CAPY4CJ4QAvENNYMNz0vfjhwGPi8HMUJO8M3G0zBcxn6nBd1SrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: ti: omap-mcbsp: Implement set_tdm_slot
To: Mark Brown <broonie@kernel.org>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Will this do the right thing with a card like simple card that sets
> the sysclk dynamically?

No. A sysclk of 0 at open fails startup(), and later opens keep the
last stream's rates. In v2 I'll only limit rates at open for a sysclk
set outside a stream, as simple-audio-card does at init, and check the
rest in hw_params().

> it'd be good to validate the params against the current slot
> configuration

Will do. hw_params() will check the channels, width and rate against
the slots and sysclk, and against the other direction, since both
share the sample rate generator.
