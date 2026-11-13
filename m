Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605988;
	b=CCz9jRrJIWyNbMEsBITb3w9btAiTz7Xl9u1khIBw9VcgN7YNChLz6PW8O6yv1Jc6/tc5
	 q3baOeOAbbPAI6R5x0kkUZpZ7lP99ybKPqGQb5vW+bYOvOdJwwXj9hTLVRoRxw0TjU54e
	 oroOtrhlbVVQgzdrjFs7U/f/vCL7PWU4xynMwHnopXsHk9MMnuL6ZZuPpisYspGmlyqxn
	 fyxJIoHnInrEtMaZplrwaKP1gHI+iE46ue9zbCGuOerNo6HQxk4UkYXzQ1NHWOiH8edYS
	 KWkFZetgrAFYHZj7V7PxmZYwS2ZEkP4EIWgRBDcsPiU+J7lHbVMkRzHchglGS1omUbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z09G6Mh32lxTcN93Jth8bp3CpV5mh1cGftMTw1FyV+4=;
	b=a2DS5q+bGmOaXg1v35sSgoLXJbUFj+BRYHJz1D9SuMfpmFLnKwZx5VOGVB3foiDrd4F8
	 a5PfSHyZokt5bTcDS2zbyw/PRKmKp1IAtI8hCYetno+lZLOB06+cvm/1gqEfFArAHZqfQ
	 P2FzaUWLTQ0gJFbXXgv5RFnCaS0wcEemCHUXB1HPrVkxmYbVaqd3tLF/oJKr5EY5zULFH
	 bKCjpyqPuE/nZ1uxuvyTWqQ91IfEjZ7UHO41/xvNlPEjxhy4Et4bFNSf0mQFCKldeCvnl
	 MT0QTi+PYCU5+D7HVmQ8G70xXG3Cqfst/fn6p4XcnyOdUMrLurFS0jPqYS/Dg+iI6Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NYuf6ucd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A1606A89F
	for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 21:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591A1606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NYuf6ucd
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c50537f731eso22294866b.1
        for <linux-omap@vger.kernel.org>; Fri, 13 Nov 2026 13:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794605987; cv=none;
        d=google.com; s=arc-20260327;
        b=qAuF70991gFqEA/TTWRGq9IRMzoqrG4PrqH4kvGGVEjFRP1YiQpwqtAy9AaH9op/ij
         oaSohtlD7EpryS4K0ulJiXZBkvSY0p6pwh625kX7FPXK2kGxM/Usl0mLqfj7EbrCvtk1
         vptT7fzWq1IdDwe8Qbw1CBrLQiu8v54Dr0tliLifWOG3cqPKPDxVGac/lXoWZav6bqA4
         lIfsTs5sQTF5kpXo8pRT+UqLy6XLj/D5vB86ACDW0yhz/K+UxH7dpKvw505zGxMoB5jc
         m9Fpf1fsxh89M4y1mfxOtc7Z3kts+7kIRwJ3D/VAcK3mgNYGyijwlkCzXNCF/CDhg0pG
         dHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z09G6Mh32lxTcN93Jth8bp3CpV5mh1cGftMTw1FyV+4=;
        fh=T60IXzfJ0YI0OZ1I6T+ARRTbr/tXwvDph6Q94N3Y3S0=;
        b=pLp9McFtDW4U5ZD2xgwnG+Jz9FADG+v0ySeG+QWB8g4Hbo6FJAGvRoKymqm7xV/YD7
         et8X627+LByATmOJkbjrXwjaC3F/NKr61fO1s8+ltzjNhdW5+wis0vXs55tc7L2nNqdq
         +jHY6ghwFr7GiOsQmnKTPvZTd55/0pCfS06ftQyDWT9FRkVOepVg3l4M1RqbluQL36Ya
         NecHqTmu23sU7VydGRSMDdudU1CJvCAwI9/A44406AxSjSAJ3wRivMdiVZ4azNY5qzB8
         WZmsytnKALOUdE8qcnbGlUenI2zPUtBaFFz7XFl6elTL57jd71bz7rsSDrisciH935Gg
         V3jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605987; x=1795210787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z09G6Mh32lxTcN93Jth8bp3CpV5mh1cGftMTw1FyV+4=;
        b=NYuf6ucdQlZW6jzeitbcergVg/cyc1cbSBBFDiXM+vZjX1QWO592BJCRfAmF+K/O2l
         M4kH7hN7l3NXN18K/csofZeEeh1Diq+i3H0PosJgBls5YxvxoHJLTYbongEUieXFKycX
         cT0q0BowRibrBYvg7uMSd4+CPViFnKfdEqjcyAVgB4LfFsOU+Q/b2oaFVJcykHqxqE7h
         CHXcRlY+J0fDLurZqPDBZDmnwrlm0VFxD0XMnSRUSEeoHMZXz2U2FMv4P04HnCqY/CYw
         G6uQH57n0shjlpzI6Xus3OWfXDfhs9P0XZjIpt6WXadF071uyv0A3eodz/emGQXj4CXg
         7Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605987; x=1795210787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z09G6Mh32lxTcN93Jth8bp3CpV5mh1cGftMTw1FyV+4=;
        b=Myw8EAymVNqE5fLChdUpRqjT6JRZuvhDS4nUOY/6PutscogGRCtWty0wvhxZUV0mXE
         b9GYFjqoXANkQp7VX1ixrOC9goNZSNDoNrh0z2eyzF2eI53jd2Qh4YF9p+gIVHeuajMZ
         cCxibK5QGZ8THABt4BJtd1LNB8OfooOELGJuSV28mPLtpfHFrOnqD+suWt90Mqpx0Wej
         g/4nF2mT2zD25UBCtHqYs0pwn+MF1yDfRxjNcP9NQWfABFm73cp9jFAcomgNIVZ8YQVq
         wOZvFxbJZeayFikVX6/YJ+GX76hs46eUGNXNCxACbrhzc1Ukm34oRO2rS6a3tYsByW8B
         xKew==
X-Forwarded-Encrypted: i=1; AL+hErFBJptR889AQM2wZNetJtNB0Qg2klcu6hqQjiIDU1Cq0L7xrQ5Bh+RWGKncSZ1oNl2mJfwjXm71qvnQ@vger.kernel.org
X-Gm-Message-State: APuU4Z/Jo3p4jN4yfhqg2UxYJunQ6yP6UXcMIvFIeWyd+Qk21inS17NF
	dFpYFIvW9F0t4WjlrplJBECY2ZaCGoNdS3fzyx62UYQUIMXKfLq2HLJj/t2b6DrUS2U3TL5TUIv
	BTCZe3eSmVMR+q5WnrOeJPKj6ByoE8Sg=
X-Gm-Gg: AYBFou2tCw17wCvnoiszgoZVVQQdyEVlbF304UKY23WYYmcmiJZb4vwKmv3qGlX4C2h
	lIEbBxRS1S61jBjEAleXBNjuPI0pjB+dZAfw/VBGmtsaaA5LW/jFp+tKK0Y9oa0WLu1w3EEU86q
	kwGfDhhPO+LPp/D5+zFxH5JKoPGd4jbLvVmQvo3hJRlf6gtJX9qfFfRZ1/fSrwHo9UDh3TveyAe
	461T9FqOzEw9LUnSxXvFryIYy+jL3CEc/0NWEZxa6U8zXBGSzVXXKdJZIXyetVO+wh7G21Oe/sK
	WHzPUzUtDbl0jiBgQ1f1s5q8rwQDclDzF56SPy3WSNwsQq8XclwyMjdb8c+SPwf57OEqswTFIPp
	0ZcfOtG03O4XqmlMMZAMpXBtxOMcabbd1SiyJi6PsqKBmbMij4z442Gj08zONoFfnWwUIQRE=
X-Received: by 2002:a17:906:fd4f:b0:c50:850d:7317 with SMTP id
 a640c23a62f3a-c50962e7ec1mr326906266b.2.1794605986507; Fri, 13 Nov 2026
 13:39:46 -0800 (PST)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
 <20261111-ti-omap-dts-fix-v1-1-19022d1ff4b4@gmail.com> <20261113-handsome-agate-beaver-a641b5@quoll>
In-Reply-To: <20261113-handsome-agate-beaver-a641b5@quoll>
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Sat, 14 Nov 2026 03:09:33 +0530
X-Gm-Features: AclHuK9qMuSavHyZMHRslPpanBiVn4xnkEDEtZmjGZCm_S2Y7T6WYHlCBkoM4Pc
Message-ID: <CAOWyW_5xDrEmuEpm8LKuDKFjS__kJfr=oDLJT5884NTSfuTatw@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: vendor-prefixes: add eets and newflow
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Jackson <mpfj@newflow.co.uk>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 13, 2026 at 4:18=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Nov 11, 2026 at 01:22:31AM +0530, Bhargav Joshi wrote:
> > Add vendor prefixes for EETS GmbH ("eets") and Newflow Ltd ("newflow").
> > These prefixes are needed to document the compatibles for the in-tree
> > AM335x PDU001 and AM335x NanoBone boards.
>
> I see no eets in tree user. Neither newflow.
Actually both boards are already in tree am335x-nano.dts (Newflow NanoBone)=
 and
am335x-pdu001.dts (EETS PDU001) but they only list the SoC compatible
"ti,am33xx", so the root compatible does not identify the board. Patch 5/7 =
adds
a board-specific compatible to each, so the compatibles are new but the boa=
rds
are not.

Best regards,
Bhargav
