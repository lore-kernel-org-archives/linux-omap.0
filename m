Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793819661;
	b=uqWpehjFDucV5OMdYq6G3NMyvXHO3otV+5Bn0NbD9d/VAgCY62ZzJkxq5FewnQItSQj+
	 5kFonJ8trCTn0uxHUph9MPjk8bHs6WeVvKdS/vICkj43ged9Y52agRvf4dSQMKfh3/Uhe
	 Wn6JzKEVOT/TUe35W85pCfHHindopS+8yH8NGfTCecl91J3pv0WSJc6iI0UIJZ++Ced7y
	 qYtnnt+I3HFbI6+BQCXMbMaGdN3Nqz/VXsqDgNly6+3JqNGZEjVDb1xS1lk11VZRm/GwE
	 O1rT1i/Yl4HzX6rshr9VVUZ1QUJQK+yrXzM2vRQ7rWo87k178Y38EHq9k44YIL78hrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ke/7n0XLIEYiHaAKGZFuuKbcPuEg3xzGKtrQJnxCMlA=;
	b=CQpbmWgZCdW2DsxXwOB7Q0yvYECMWfngcY/sCxWiUIgaPi2xzpKrFdwyV8azDQ4nsXAj
	 NQo7YNV8BSpY0ThMXZVEc3Nli1Z8KGG7as77s0vtCnEqx3fKyKcx/OVDHM3YSe/4Ox3z2
	 N/wB9ShpdU13edNEagNmMZpI3R0qX5hMlerO/YrdTsMqymv13yTY4rcdYAZg3uxPl5Ld1
	 99p1AkIvsIVsAyJYb+oZol9K/8tzTK75dptWP8YngDoQO3VyZMyXKZAmwFuV3F4jfjGcW
	 sQj1/wbu8fOtayZ7PXJZSlqzYQIVYVDL1a/MFAYidQFf6WAbQWc1HIaCk+KuXyw5fTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=criticallink.com;
	spf=pass smtp.mailfrom=criticallink.com;
	dkim=pass header.d=criticallink.com header.i=@criticallink.com header.a=rsa-sha256 header.s=google header.b=KyPOF0j4;
	arc=fail smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B3606A31B
	for <linux-omap@vger.kernel.org>; Wed,  4 Nov 2026 19:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D5B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=criticallink.com header.i=@criticallink.com header.a=rsa-sha256 header.s=google header.b=KyPOF0j4
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b2d149693fso10056907b3.0
        for <linux-omap@vger.kernel.org>; Wed, 04 Nov 2026 11:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793819659; cv=none;
        d=google.com; s=arc-20260327;
        b=mbSkzsIGPJaK98L/qDzhOJpvUidhSVBXB9DW6gaJTaIc4F4wiqwWmbCPp6S01yrGSU
         WoQcr9hCv4oePunMAyhR+vzEum1gLqUaKeVZU8wDgX372Fan0IY2UcvRjY9Jxjt68vZa
         K+OJvZrDD2bgPHWhI/p7emovY09SsHhQ/IB+KIiGL89CQoUvXVcvNorJ+vACzKDkP+rW
         GzlYkbsNW1rFG+Lt41Xxksg4lN/wGK30EEPt0dcJUY1CRniFhn5+ewM0tzfdwOhxWH2D
         rqoie8PNVzskt8jhDpJ0QxyExdne4RT4hi55skt4i3SmG2cMfcXVfWs+kaCZGfQEtv8I
         zOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ke/7n0XLIEYiHaAKGZFuuKbcPuEg3xzGKtrQJnxCMlA=;
        fh=ZaYJqPvaUjfepPnjsXkyk7GgYlhjtkdNHMG0244i20Q=;
        b=RYpF5DPRc5HGBG3WW0UZmhDmVJCFIHYYf/H1iMUL3YiLRyc77KKnIrg5+8o6tu/EPK
         D4qPxHprdrmnAGOkQj1YXpzNCpSiytSHin5EP/DuNDNSJ1G5xfTwIgOa027BIPWBAYu0
         9nZO0640JnIVyjeay2xxvMZwIAVMqLLcw6WA+zTSikG434WAjvUngYaw8Ap5sspkVlI0
         tOWj9bXTtFCzVJtbs6IbEsfxQd1iHPQwHY2mV8S48TTyB0uJ50B+qfkElIVOsfzsHdm8
         RsoZAEGrXpysYpKt9eyTvmibzy79uiT/viqfhL9pRWeiF+tV3YyaSZpFQPq4QIPCkh6Q
         JsYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1793819659; x=1794424459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ke/7n0XLIEYiHaAKGZFuuKbcPuEg3xzGKtrQJnxCMlA=;
        b=KyPOF0j4HfonU6LaDyDbWBtub+I/n+ff+iKTumhe8EbWz6taew+Mhbaa17Irr8zjLL
         jSimCbaDOGMrERtDuQScolSF7LlR1K4VgWajwNRMI85kqBL4+xXxjOrBScEkCl46ZMGL
         ++pc7MrSy3xIss3WdW1LIqleuASAVnMD84pvPhyFsSVexneQR++peFoqpvRVXZpI8mvY
         e5p0gS/4DRC4jHoD7sQcgkvjOby9V80BOFg6o4gbSWQ3pZBxHpyFoRUJuIuKTJVUcUHW
         ow+RfnMEYF8yKe2mwkFLk7Xm8LBZclX/JhJwwq8rx4VgYgst2+4X178kgh0A1hVSVfE/
         0ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819659; x=1794424459;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke/7n0XLIEYiHaAKGZFuuKbcPuEg3xzGKtrQJnxCMlA=;
        b=N1WsS36Hb56AvKygoDHV34TSwPBeSZHGWOIo+s8F8I0k07E8rOANHzrrntLrFAu7Zc
         TWPizJxdaNp2hjqOZ5vKVw3L0fT3m0QkjymOhaDgbDAGkIOOQ0ZV7HRaAIMJLLgzT0f7
         k1LbPrOKBvr9pUlI7qhhgLh/y0jedB3s4BJ6ZtXZb57s8hn4hwSXAxi+V9yVN4VgEt49
         ivnjWY2NJjMBsF/XaaBXll5rKCcfJt0B2BBUTC63eTwjFAlsbzJKE7Q5bNBIH0cICYWO
         XzNI6udcnWtOFHZ1Ync8gHHe4cZQCXhWhJY75Q5+gSghwqpV3Rll5tcB8p3q44xfiUdg
         RWlw==
X-Forwarded-Encrypted: i=1; AKwUvBwPET3BT2N3ZovuEpRkm3PalwTw6ITVv3c6LONxU277RNF4fPpS9A5p0fjlg9srPp+gUt91oMRdSrM9@vger.kernel.org
X-Gm-Message-State: APuU4Z+UXLBkVV5IHj9v5J8uldtPQHKhG5Wq8Rds9yNBPcOwtaefOngd
	kpIDhW7SNoHtOHIJu2sgs9OwQ+YOwFwm4m/A5bS/jG1+zwLAuaMNi1ae+vrltny878kVNZfAZIE
	XzEIH1tXKNG8qLu1HCxPeaT2cb/1tac6Pj7Ft+8Ln
X-Gm-Gg: AYBFou0ijHjIzcepyEczfXvBzG4VS05nyV27mriKiCVJxxlArJ4EP70071qS6TiQvum
	L1yMa0Y8QyLPS3lVTFa/sbYyQFGlVH1zKS3VI/qHkhjWyPPYPvcCQd2kfBP01ARnXpRaJYp0nhf
	YG2l4CDMClcCiSz8qwtVugY3rzb3EA7FWYjzPWl2hPPKnb6sB/46m/Ik+UVwUwFpN6z4vNJ2iWH
	9hHzfTOgyVeGEEIBMlREiwrGpvdCcakWtGwDLiGa7VgdrFLKVsRT3maUhklkGLY8jG1vvXW2LCa
	huJfPRjKQz4uFlv3lxlc2jNSPFMGAHWP/t1USe1NXpL40dTR/EcvbYZXLoF9ZLbFJ94VnRopg5S
	A7ZsYibE/+NLUh3IduYKUfSdGmdLRubAfUig=
X-Received: by 2002:a05:690c:6604:b0:8b0:e680:615f with SMTP id
 00721157ae682-8b2b65aebecmr111771367b3.9.1793819659192; Wed, 04 Nov 2026
 11:14:19 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20250901101525.1090334-1-a-dutta@ti.com> <20260603191259.3723777-1-jcormier@criticallink.com>
In-Reply-To: <20260603191259.3723777-1-jcormier@criticallink.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Wed, 4 Nov 2026 14:14:06 -0500
X-Gm-Features: AclHuK9TU28yjjkJtRYMVXwCpIjDK5UJp8IOoxReP5fQzz76P4ZZMUxg_o-GJ44
Message-ID: <CADL8D3bBHupbuEFCMOFnFMEh7h-wDs9Eu4LqQDSQpzWO3TnjgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] AM57 timer fixes
To: Anurag Dutta <a-dutta@ti.com>
Cc: aaro.koskinen@iki.fi, andreas@kemnade.info, khilman@baylibre.com, 
	rogerq@kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, u-kumar1@ti.com, vigneshr@ti.com, 
	sinthu.raja@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 3:13=E2=80=AFPM Jonathan Cormier
<jcormier@criticallink.com> wrote:
>
> Tested this series on a Critical Link MitySOM-AM57x board (AM572x /
> DRA752-GP, 20 MHz SYS_CLK1).  With counter_32k disabled and DMTimer 12
> registered as the system clocksource via these patches, system clock
> drift dropped from +553 ppm (counter_32k 32,787Hz instead of 32,768Hz)
> to +2 ppm over a 50.8 h measurement window
>
>   /sys/devices/system/clocksource/clocksource0/available_clocksource:
>   dmtimer
>
> Note: to make the fix apply to non-beagle-x15 DRA7/AM57 boards, I moved
> the &timer12_target and &counter32k overrides from am57xx-beagle-x15.dts
> into dra7.dtsi.  Worth considering for v3 so other boards (MitySOM,
> am57xx-idk, AM572x-EVM, etc.) pick up the fix automatically rather than
> each needing the same per-board override.
>
> Tested-by: Jonathan Cormier <jcormier@criticallink.com>
Conflict, dmtimer12 is used by the secure software on the secure boot
processors...
>
> Thanks,
> Jonathan



--=20
Jonathan Cormier
Senior Software Engineer

Office:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
