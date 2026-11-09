Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268106;
	b=auPhgGvEbHRNYfrcNCE5Fk6qBaDZkOK2pbxx39NcxW/Er3ItSr732KWImvMBFPatmOKf
	 C8Q0aoyp5y335zqt/mwas6cT4WM9OgSc2OzstStP+pI8sa+z2XfqR/RoVC3Z+sYDPts2P
	 euU/qHZbv9UbYJPmWVXkdH3iv7C2nLyFmmuagNPsaoxke38BpUgWtypiLR1w14aqmkwD+
	 QE1EmqEYF9gH4B+PKZutPCmegIBU0fqrfDfWIqYtVUhT7G6u8G122Wo1iRQolg+Dw6Z22
	 ApMZscL78EREfjSfzn1c5PpMXgI3FuA3/ColHvGjmJxgTUDS/BU/p+tfj3yEuht29Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=mgC3aFnQzEkUSqr0EdV9/pvy4kdF1e+4cJ+OWTfkigE=;
	b=s1EAJPOqzOQip4WxFOYqjpH2r4xGk4DhKUz++ImSFAYUG0sPbPztG2dZ2i+gzLfSc/wU
	 Yy1C0U2hyCGtq4FnVE4ovd97N/+noy59LAam0T8NmbCSk2eRqSvO5dB+LsXHFT6wRuqKG
	 W5g+VnReZlNlKFTOlzshv31S2zcYVKIXr8VsHpcl+fb/CGTIPhnzjSarSsrwnMRXO/SSH
	 /s6lRfJe7RhTmC/Rm3TNGGot6DOMHExBYDcOITUsSTDEDUS3qkc4vAHUyguIcGoN9gy5t
	 JTCOyK2LWnfVSBjy1JqnN9UN9Y8HY8lJchsAdOARqhL91Eq4jhWdQ9fwSZniBAGuJ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JCV1Ttpn;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B518606A33C
	for <linux-omap@vger.kernel.org>; Mon,  9 Nov 2026 23:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B518606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JCV1Ttpn
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e987b4a710so6890345ad.1
        for <linux-omap@vger.kernel.org>; Mon, 09 Nov 2026 15:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794268105; x=1794872905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mgC3aFnQzEkUSqr0EdV9/pvy4kdF1e+4cJ+OWTfkigE=;
        b=JCV1TtpntEO2y+R3SwQjg0sprnLUZgcAIH+abSygcDUpyFJxTFDalHfw8MGnB9a0y5
         TRXJVvZZJLFxh3BwOs0WsTv53xhKY6lbuiT/Dc6u8M6mpIfPFHQ99/tpbqEjKR5bBtal
         UA/UzkXT3DyhoY0d+QxQ/GwFUvDMIthYPWvHv0PQopFgPe2HfzQXHo3rLg9kl27EoGi3
         EtqsUruCtPOXI4/gPYj+rW05dH2AYvQD666F6EXjBbXK7RPE795oRQ/e7D7ADvN+b2cW
         KDZXGaNiwpR7X0EEBRaIrGYDsR21J6VSiRz1J0r3ONfd1VxnPmuNRSkDefmnCUD9I5jG
         tcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268105; x=1794872905;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mgC3aFnQzEkUSqr0EdV9/pvy4kdF1e+4cJ+OWTfkigE=;
        b=NeEOc2P9DqdgQbi2T86WmzX5dhmT5jQw0BlP5HMMAQOzR8lqNYiR1zqitimfSai1RF
         0BgC016KHzLKV4jK9PcBVXj/CYPWxIQGV3Ltl4SviXpQ+PqeULU5B/JObTTiWa1W6eY0
         LNs2vhmllfRPmthdo3qhQ5s5F9kM/ztzzuivdEYRpZcMbVd+idSM6yiNnjgE/LTGVJWt
         tLzayqWEguzvxHlBqS5KwUPr7piv1TAENXjWJBSUd0HVHiFovkDJNhgyv7vguLPbIupd
         a8iX3geQfDg2mh5JL01evUzsiax/vdOHhE/BqFaCc4LkIaeGp8mP17lWchjLT3QtF0I0
         Rduw==
X-Gm-Message-State: APuU4Z8IxDp9E9DweypjfGfXbXf1TpLYuQDr/iUHaTpXgCCus9/N7BCr
	3NLi2LoCW2dmcZgaBG1IpQ1XTPTjoQTFK6PppJLsx9ZMPXVcZSrV8uyCz60rolQmC78=
X-Gm-Gg: AYBFou3IDC8vzMEsAqmyqk/IZ+6zorTjA/HWTwBXv7Ej+fpC1IhbNTgersRgLgVxIrJ
	OqE4OM+ChOZcpC4fL3oC2XKLv4rLJxBkcPivWBfS0Q1eYUl06T5kTbbnjnw4MRwQJvERw6t1DDw
	YYd4MKfJ/43qY8PSsUuhBXcGojCIX5sRrzROm0yMYNdwyWeMQ5of9Kd9QkRrmQiKfWhUPuuBmjb
	82pr2zyFPtk8CQEnT7vAsWwE0KWGdnTIcbzYmSAOtiunWa6N5KNRzGKH/fQZglrzO5JFQhi38zj
	LNipVNigWNI5N76oB4sQ8KnCbBZuCeYI7CjqRfHx+jFkxjYLQiflbQRqW/t2JsOdQw0KlhWaURS
	/XBHbC1JZAurNOLvqpo39Aal63xemlcX4ZzCYdl3lhNYctlffGrqSxduq4nrXHKAMcM7vwN+W21
	5RK7hUv6d4TwsjjBlnU9s5MnL+TKodilteQFA34FxED5AmmCcvLA/47yHh4MIA79clo0FXX6vRm
	7YZKwfv6isk3p+2Yy+tSwSjss4RDkFKrsLtUlvLXpOB/XC5juXKLdswmbLH+Dfv207529SuJ7+m
	Ur51wAgI2F+VRyFUwtYeDz9zOA==
X-Received: by 2002:a17:90b:3844:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3b16797724fmr660791a91.18.1794268105529;
        Mon, 09 Nov 2026 15:48:25 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b16771705asm1371571a91.12.2026.11.09.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:48:25 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Matthias Schiffer <matthias.schiffer@tq-group.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org
In-Reply-To: <20261103-v7-3-topic-am335lpm-ti-sysc-v1-1-1b9a23b4a7c1@baylibre.com>
References: <20261103-v7-3-topic-am335lpm-ti-sysc-v1-1-1b9a23b4a7c1@baylibre.com>
Subject: Re: [PATCH] bus: ti-sysc: Don't reserve the system timers on
 AM33xx
Message-Id: <179426810432.2265990.13205445943569497614.b4-ty@b4>
Date: Mon, 09 Nov 2026 15:48:24 -0800
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 03 Nov 2026 14:24:03 +0100, Markus Schneider-Pargmann (TI) wrote:
> Commit
>     3f6178392050 ("ti-sysc: allow OMAP2 and OMAP4 timers to be reserved on AM33xx")
> introduced handling of am33 SoC timers that are already active as
> reserved. During probe this means the clocks are enabled and a reference
> is kept.
> 
> On AM33xx deep sleep is entered by the PM coprocessor which
> requires the PER power domain to be idle. The system timer driver
> disables the clock during suspend but the additional reference held by
> ti-sysc leads to the PER power domain not being idle:
> 
> [...]

Applied, thanks!

[1/1] bus: ti-sysc: Don't reserve the system timers on AM33xx
      commit: 196abf4dabe28fe7732732d0c79b84bf30994cee

Best regards,
-- 
Kevin Hilman (TI) <khilman@baylibre.com>

